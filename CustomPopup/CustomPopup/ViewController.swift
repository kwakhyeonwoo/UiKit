//
//  ViewController.swift
//  CustomPopup
//
//  Created by 곽현우 on 7/13/24.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var createPopupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // PopupButton이 클릭이 되었을 때 일어나는 행동
    @IBAction func onCreatePopupButtonClicked(_ sender: UIButton) {
        print("ViewController - onCreatePopupViewButtonClicked() Clicked")
        
        // 스토리보드 가져오기
        let storyboard = UIStoryboard(name: "PopupStoryboard", bundle: nil)
        // 스토리보드를 통해 ViewController를 가져옴
        let alertPopupViewController = storyboard.instantiateViewController(withIdentifier: "AlertPopUpViewController") as! CustomPopupViewController
        // 뷰 컨트롤러가 보여지는 스타일 - 설정 안할시 아래에서 위로 올라오는 설정 바로 나오는 효과가 아님
        alertPopupViewController.modalPresentationStyle = .overCurrentContext
        // 뷰 컨트롤러가 사라지는 스타일
        alertPopupViewController.modalTransitionStyle = .crossDissolve
        
        //linkButtonCompletion가 클릭되면 해당 링크를 channelURL에 저장하고 WebView에 보여준다.
        alertPopupViewController.linkButtonCompletion = {
            print("Completion Block called ")
            let channelURL = URL(string: "https://www.youtube.com")
            self.myWebView.load(URLRequest(url: channelURL!))
        }
        
        // alertPopupVC가 보여주고 애니메이션 설정한다. 애니메이션 다 나왔을 때는 아무것도 안 하겠다.
        self.present(alertPopupViewController, animated: true, completion: nil)
    }
}
