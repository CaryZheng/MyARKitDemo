//
//  ViewController.swift
//  MyARKitDemo
//
//  Created by Cary on 2022/11/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        let button = UIButton()
        button.setTitle("启动AR_image", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.sizeToFit()
        button.frame.origin = CGPoint(x: 100, y: 100)
        button.addTarget(self, action: #selector(onButtonClicked), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        let button2 = UIButton()
        button2.setTitle("启动AR_object", for: .normal)
        button2.setTitleColor(.blue, for: .normal)
        button2.sizeToFit()
        button2.frame.origin = CGPoint(x: 100, y: 300)
        button2.addTarget(self, action: #selector(onButton2Clicked), for: .touchUpInside)
        
        self.view.addSubview(button2)
    }

    @objc func onButtonClicked() {
        print("onButtonClicked")
        
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
    @objc func onButton2Clicked() {
        print("onButton2Clicked")
        
        self.navigationController?.pushViewController(ThirdViewController(), animated: true)
    }

}

