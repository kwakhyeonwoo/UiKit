//
//  CustomPopupViewController.swift
//  CustomPopup
//
//  Created by 곽현우 on 7/13/24.
//

import UIKit
import WebKit

class CustomPopupViewController : UIViewController{
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var link: UIButton!
    @IBOutlet weak var bgButton: UIButton!
    
    //클로저로 값을 넘길 때 아무것도 넘기지 않고 값을 Void로 리턴 받는다
    var linkButtonCompletion : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CustomPopupViewController - viewDidLoad() called ")
        contentView.layer.cornerRadius = 30
        link.layer.cornerRadius = 10
    }
    
    //bgButton이 클릭되었을때 Action
    @IBAction func onbgButtonClicked(_ sender: UIButton) {
        print("CustomPopupViewController - onbgButtonClicked() Clicked")
        //dismiss의 역할 - 현재 창 종료 시키기
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onLinkClicked(_ sender: UIButton) {
        print("CustomPopupViewController - onLinkClicked() Clicked")
        
        self.dismiss(animated: true, completion: nil)
        //Completion블럭 호출
        //linkButtonCompletion값이 존재하면 값을 저장한다
        if let linkButtonCompletion = linkButtonCompletion {
            //메인에 알려줌
            linkButtonCompletion()
        }
    }
    
}
