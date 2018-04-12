//
//  SCPromptView.swift
//  SCPromptView-SwiftDemo
//
//  Created by 陈世翰 on 2017/5/2.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

import UIKit

let iPhoneX = (UIScreen.main.bounds.size == CGSize(width: 375, height: 812))

let SC_SUGGEST_TOP_PADDING = iPhoneX ? 30 : 20

class SCPromptView: UIView {
    lazy var contentView:UIView = UIView()
    var showCommand:String?
    
    //MARK: Life cycle
    required init(){
        super.init(frame: CGRect.zero)
        setUp()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp(){
        addSubview(contentView)
        frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height:sc_height()+sc_slideDistanse())
        contentView.frame = CGRect(x: 0, y: sc_slideDistanse(), width: UIScreen.main.bounds.size.width, height:sc_height())
    }
    //MARK: default
    func sc_height() -> CGFloat {
        return (iPhoneX ? 88 : 64)
    }
    ///滑动距离
    func sc_slideDistanse() -> CGFloat {
        return 18
    }
    ///显示时间
    func sc_showTime() -> TimeInterval {
        return 2
    }
    ///出现动画时间
    func sc_showAnimationDuration() -> TimeInterval {
        return 0.35
    }
    ///隐藏动画时间
    func sc_hideAnimationDuration() -> TimeInterval {
        return 0.2
    }
    
    //MARK: load
    
    ///设置子控件
    func sc_setUpCustomSubViews(){
        
    }
    func sc_loadParam(param:Any?){
        
    }
}
