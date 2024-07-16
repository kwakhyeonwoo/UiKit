//
//  BaseVC.swift
//  APIConnectUser
//
//  Created by 곽현우 on 7/16/24.
//

import UIKit

class BaseVC : UIViewController {
    //vcTitle를 초기 값으로 정의하지만 만약 값이 정의되면 (didSet이 실행)
    var vcTitle : String = ""{
        didSet {
            print("UserLiscVC - vcTitle didSet() called / vcTitle: \(vcTitle)")
            //이때 self는 UserLustVC를 의미, 즉 vcTitle로 넘어온 값을 UserListVC로 변경하겠다
            self.title = vcTitle
        }
    }
}
