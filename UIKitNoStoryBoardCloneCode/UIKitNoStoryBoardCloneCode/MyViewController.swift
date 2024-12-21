//
//  ViewController.swift
//  UIKitNoStoryBoardCloneCode
//
//  Created by 곽현우 on 11/28/24.
//

import UIKit

class MyViewController: UIViewController {
    
    convenience init(title: String, bgColor: UIColor){
        self.init()
        self.title = title
        self.view.backgroundColor = bgColor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .systemYellow
    }

}

