//
//  BaseVC.swift
//  APIConnectUser
//
//  Created by 곽현우 on 7/16/24.
//

import UIKit
import Toast_Swift

class BaseVC : UIViewController {
    //vcTitle를 초기 값으로 정의하지만 만약 값이 정의되면 (didSet이 실행)
    var vcTitle : String = ""{
        didSet {
            print("UserLiscVC - vcTitle didSet() called / vcTitle: \(vcTitle)")
            //이때 self는 UserLustVC를 의미, 즉 vcTitle로 넘어온 값을 UserListVC로 변경하겠다
            self.title = vcTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //인증 실패 노티피케이션 등록
        NotificationCenter.default.addObserver(self, selector: #selector(showErrorPopup(notification: )) , name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //인증 실패 노티피케이션 등록 해제
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil)
    }
    
    //MARK: - objc method
    @objc func showErrorPopup(notification: NSNotification){
        print("BaseVC - showErrorPoopup() called ")
        
        if let data = notification.userInfo?["statusCode"]{
            print("showErrorPopup() data: \(data)")
            
            //메인 스레드에서 돌리기 UI스레드 
            DispatchQueue.main.async {
                self.view.makeToast("🧑🏻‍🦱 \(data)에러 입니다", duration: 1.5, position: .center)
            }
        }
    }
}
