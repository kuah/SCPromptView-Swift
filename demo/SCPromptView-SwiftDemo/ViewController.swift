//
//  ViewController.swift
//  SCPromptView-SwiftDemo
//
//  Created by 陈世翰 on 2017/5/2.
//  Copyright © 2017年 Coder Chan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var num:Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpDemoButton()
        sc_prompt_register(viewClass:TestView.classForCoder(), showCommand: "test")
    }

    func setUpDemoButton(){
        let screenWidth = UIScreen.main.bounds.size.width
        let width:CGFloat = 100
        let height:CGFloat = 50
        
        let margin = (screenWidth-width)/2
     
        let button = UIButton(frame: CGRect(x:margin, y: 100, width: width, height: height))
//        let button1 = UIButton(frame: CGRect(x:margin, y: 200, width: width, height: height))
//        let button2 = UIButton(frame: CGRect(x:margin, y: 300, width: width, height: height))
        
        view.addSubview(button)
//        view.addSubview(button1)
//        view.addSubview(button2)
        
        button.setTitle("0", for: UIControlState.normal)
//        button1.setTitle("1", for: UIControlState.normal)
//        button2.setTitle("2", for: UIControlState.normal)
        
        button.backgroundColor = UIColor.red
//        button1.backgroundColor = UIColor.yellow
//        button2.backgroundColor = UIColor.blue
        
        button.addTarget(self, action: #selector(clickBtn), for: UIControlEvents.touchUpInside)
        
        
    }
    func clickBtn(){
        let str:String = "\(num)"
        sc_prompt_show(showCommand: "test", param: str)
        num += 1
    }

}

