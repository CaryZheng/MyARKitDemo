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
        button.setTitle("启动AR", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.sizeToFit()
        
        button.frame.origin = CGPoint(x: 100, y: 100)
        
        self.view.addSubview(button)
        
        button.addTarget(self, action: #selector(onButtonClicked), for: .touchUpInside)
    }

    @objc func onButtonClicked() {
        print("onButtonClicked")
        
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }

}

