//
//  ViewController.swift
//  CompletionBlock
//
//  Created by 곽현우 on 7/12/24.
//

import UIKit
import KRProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var mainTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("ViewController - viewDidLoad() called ")
        
        KRProgressHUD.show()
        //myName() parameter 값에 completion으로 정의하고 그 값을 호출부에서 completion을 받고 있으니 작동 됨
        myName(completion: { result in
            print(result)
            KRProgressHUD.showSuccess()
            
            //mainTitle의 값을 completion을 통해 result로 받고 해당 값을 초반에 보여준다.
            self.mainTitle.text = result
        })
    }

    //ViewController 파일 내에서만 사용 가능
    fileprivate func myName(completion: @escaping(String) -> ()){
        print("ViewController - myName() called ")
        
        //메인 스레드에서 2초 후에 발동 시켜라 - 시간 지연 메소드
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            print("저의 이름은 ")
            completion("곽현우입니다.")
        }
    }
}

