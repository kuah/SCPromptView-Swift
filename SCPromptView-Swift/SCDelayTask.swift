//
//  SCDelayTask.swift
//  SCPromptView-SwiftDemo
//
//  Created by 陈世翰 on 2017/5/4.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

import UIKit

/*
 
 原理:
       系统的异步 ---> SCDelayTask --->实际延时后执行的closure
                         ↑
                         ↑
   类型 : closure  sc_delay方法返回的task，就是可操纵的（相当于开关，一旦cancel就传递不到实际的closure）
 
 */

typealias SCDelayTask = (_ cancel : Bool) -> Void

func sc_delay(_ time: TimeInterval, task: @escaping ()->()) ->  SCDelayTask? {
    
    //封装系统延时任务
    func dispatch_later(block: @escaping ()->()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    var closure: (()->Void)? = task //回调的闭包
    var result: SCDelayTask?
    
    //创建延时后中间闭包实例(填充了该闭包内容)
    let delayedClosure: SCDelayTask = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure //赋值记录延时闭包
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)//执行延时
        }
    }
    //返回中间闭包
    return result
}
//取消任务(实际上加了拦截)
func sc_dt_cancel(_ task: SCDelayTask?) {
    task?(true)
}
