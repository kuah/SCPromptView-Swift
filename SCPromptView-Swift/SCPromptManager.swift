//
//  SCPromptManager.swift
//  SCPromptView-SwiftDemo
//
//  Created by 陈世翰 on 2017/5/2.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

import UIKit

private let SCPrompt_Show_Command:String = "SCPROMPT_SHOW_COMMAND"

final class SCPromptManager: NSObject {
    static let shared = { () -> SCPromptManager in
       let manager = SCPromptManager()
       NotificationCenter.default.addObserver(manager, selector: #selector(didReceivedShowCommand), name: NSNotification.Name(rawValue: SCPrompt_Show_Command), object: nil)
       return manager
    }()
    ///注册信息
    lazy var registerInfo:[String:AnyClass] = [String:AnyClass]()
    ///重用池
    lazy var reusableViewPool:[String:[SCPromptView]] = [String:[SCPromptView]]()
    ///延时任务
    private var hideDelayTask:SCDelayTask?
    ///当前显示的view
    private var _showingView:SCPromptView?
    private var showingView:SCPromptView?{
        get{
            return _showingView
        }
        set{

            if _showingView != nil {
                hideDirectly(promptView: _showingView!)
            }
            _showingView = newValue
        }
    }
    
    private override init(){}
    
    
    ///注册
    ///
    /// - parameter viewClass      :view的类型
    /// - parameter showCommand    :注册显示命令
    @objc(registerPromptView:showCommand:)
    open func registerPromptView(_ viewClass:AnyClass,_ showCommand:String){
        assert(viewClass.isSubclass(of: SCPromptView.classForCoder()),"注册的class必须为SCPromptView的子类,the viewClass must be subClass of SCPromptView")
        registerInfo[showCommand] = viewClass
    }
    ///通过命令和参数显示view
    ///
    /// - parameter showCommand    :该类注册的显示命令
    /// - parameter param          :该param会被作为调用sc_loadParam的参数
    @objc(showPromptViewWithCommand:param:)
    open func showPromptViewWithCommand(_ showCommand:String,_ param:Any?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SCPrompt_Show_Command), object: param, userInfo: [SCPrompt_Show_Command:showCommand])
    }
    /// 收到显示命令
    @objc fileprivate func didReceivedShowCommand(notification:Notification){
        let command = notification.userInfo?[SCPrompt_Show_Command] as? String
        guard command != nil else {
            return;
        }
        let param = notification.object
        if Thread.isMainThread {
            match(showCommand: command!, param: param)
        }else{
            DispatchQueue.main.async {
                self.match(showCommand: command!, param: param)
            }
        }
    }
    ///用命令在注册信息中匹配得类，并创建view显示
    ///
    /// - parameter showCommand    :该类注册的显示命令
    /// - parameter param          :该param会被作为调用sc_loadParam的参数
    fileprivate func match(showCommand:String, param:Any?){
        let matchClass:AnyClass? = registerInfo[showCommand]
        guard matchClass != nil else {
            return;
        }
        let promptView = getReusableView(showCommand: showCommand)
        promptView.sc_loadParam(param: param)
        promptView.frame = CGRect(x: 0, y: -promptView.sc_height()-promptView.sc_slideDistanse(), width: UIScreen.main.bounds.size.width, height: promptView.sc_height()+promptView.sc_slideDistanse())
        promptView.contentView.frame = CGRect(x: 0, y: promptView.sc_slideDistanse(), width: promptView.bounds.size.width, height: promptView.sc_height())
        showInWindow(promptView: promptView)
    }
    ///根据显示命令来尝试在重用池获取到view，获取不到则新建，保证有view返回
    ///
    /// - parameter showCommand    :该类注册的显示命令
    fileprivate func getReusableView(showCommand:String)->SCPromptView{
        var promptViewQ:[SCPromptView]? = reusableViewPool[showCommand]
        
        if promptViewQ != nil && (promptViewQ?.count)!>1 {
            let promptView:SCPromptView = promptViewQ!.first!
            promptViewQ?.remove(at: 0)
            reusableViewPool[showCommand] = promptViewQ
            return promptView
        }else{
            let matchClass:SCPromptView.Type = (registerInfo[showCommand] as? SCPromptView.Type)!
            let promptView = matchClass.init()
            promptView.sc_setUpCustomSubViews()
            promptView.showCommand = showCommand
            return promptView
        }
    }
    ///将view显示在窗口上
    ///
    /// - parameter promptView     :需要显示的view
    fileprivate func showInWindow(promptView:SCPromptView){
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.addSubview(promptView)
        if promptView.gestureRecognizers == nil || promptView.gestureRecognizers?.count==0{
            promptView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:#selector(self.tapToHide(tap:))))
        }
        UIView.animate(withDuration: promptView.sc_showAnimationDuration(), delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.allowUserInteraction,.curveEaseInOut], animations: {
            promptView.frame = CGRect(x: 0, y: -promptView.sc_slideDistanse(), width: promptView.bounds.size.width, height: promptView.bounds.size.height)
        }) { (finished:Bool) in
            self.delayHideInWindow(promptView: promptView)
        }
    }
    ///延迟消失（延迟的时间，就是view显示的时间）
    ///
    /// - parameter promptView     :需要消失的view
    fileprivate func delayHideInWindow(promptView:SCPromptView){
        guard promptView.superview != nil else {
            return
        }
        showingView =  promptView
        sc_dt_cancel(hideDelayTask)
        hideDelayTask = sc_delay(promptView.sc_showTime()) { [weak self] () in
            self?.hideInWindow(promptView: promptView)
        }
    }
    ///消失动画  
    ///
    /// - parameter promptView     :需要消失的view
    fileprivate func hideInWindow(promptView:SCPromptView){
        guard showingView == promptView else {
            return
        }
        UIView.animate(withDuration: promptView.sc_hideAnimationDuration(), animations: {
            promptView.frame = CGRect(x: 0, y: -promptView.sc_height()-promptView.sc_slideDistanse(), width: promptView.frame.size.width, height: promptView.frame.size.height)
        }) { (finished:Bool) in
            
        }
    }
    ///直接消失
    ///
    /// - parameter promptView     :需要消失的view
    fileprivate func hideDirectly(promptView:SCPromptView){
        guard promptView.superview != nil && promptView.showCommand != nil else {
            return
        }
        promptView.removeFromSuperview()
        var queueForCommand:[SCPromptView]? = reusableViewPool[promptView.showCommand!]
        if queueForCommand == nil {
            queueForCommand = [SCPromptView]()
        }
        queueForCommand?.append(promptView)
        reusableViewPool[promptView.showCommand!] = queueForCommand
    }
    ///点击马上消失
    @objc fileprivate func tapToHide(tap:UITapGestureRecognizer){
        let promptView = tap.view as? SCPromptView
        
        if promptView != nil {
            hideInWindow(promptView: promptView!)
        }
    }
}
///convenient regiser func 便利的注册方法
public func sc_prompt_register(viewClass:AnyClass,showCommand:String){
    SCPromptManager.shared.registerPromptView(viewClass, showCommand)
}
///convenient show func  便利的显示方法
public func sc_prompt_show(showCommand:String,param:Any?){
    SCPromptManager.shared.showPromptViewWithCommand(showCommand, param)
    
}

