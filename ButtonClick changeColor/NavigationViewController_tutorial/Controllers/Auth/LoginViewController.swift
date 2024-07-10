//
//  ViewController.swift
//  NavigationViewController_tutorial
//
//  Created by Jeff Jeong on 2019/12/23.
//  Copyright © 2019 Tuentuenna. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var loginBtn: UIButton!
    
    // 뷰가 생성되었을때
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 상단 네비게이션 바 부분을 숨김처리한다.
        self.navigationController?.isNavigationBarHidden = true
        self.loginBtn.addTarget(self, action: #selector(moveToMainViewController), for: .touchUpInside)
    }


    //MARK:- private methods
    
    // 로그인 화면으로 이동시키는 메소드
    @objc fileprivate func moveToMainViewController(){
        print("LoginViewController - moveToLoginViewController() called")
        let mainViewController = MainViewController()

        self.navigationController?.pushViewController(mainViewController, animated: true)
        
    }
    
}

