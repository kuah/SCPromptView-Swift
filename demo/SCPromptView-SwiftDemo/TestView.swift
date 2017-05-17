//
//  TestView.swift
//  SCPromptView-SwiftDemo
//
//  Created by 陈世翰 on 2017/5/4.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

import UIKit

class TestView: SCPromptView {
    var label:UILabel?
    
    override func sc_setUpCustomSubViews() {
        backgroundColor = UIColor.clear
        contentView.backgroundColor = UIColor.init(red:CGFloat(arc4random()%255)*1.0/255, green: CGFloat(arc4random()%255)*1.0/255, blue: CGFloat(arc4random()%255)*1.0/255, alpha:1)
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        label = UILabel(frame: contentView.bounds)
        label?.textColor = UIColor.white
        label?.textAlignment = NSTextAlignment.center
        contentView.addSubview(label!)
    }
    override func sc_loadParam(param: Any?) {
        if param != nil {
        let text = param as! String
        label?.text = text
        }else{
            label?.text = ""
        }
    }

}
