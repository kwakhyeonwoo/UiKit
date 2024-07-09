//
//  ViewController.swift
//  SomeAnimation
//
//  Created by 곽현우 on 7/9/24.
//

import UIKit
import Lottie

class MainViewController: UIViewController {
    
    //밑에 ()는 선언과 동시에 정의하기 위해
    //UiLabel이 자료형이기 때문에 '='가 아닌 ':'로 선언을 해줘야 함
    let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.text = "메인 화면"
        label.font = UIFont.boldSystemFont(ofSize: 70)
        return label
    }()
    
    let animationView : LottieAnimationView = {
        let aniView = LottieAnimationView(name: "Animation - 1720500834524")
        //CGRect - 사각형을 만들것이다.
        //x축,y축 0으로 만들고 가로 세로 400의 크기로 설정할 것이다.
        aniView.frame = CGRect(x:0, y:0, width: 400, height: 400)
        
        //contentMode = 이미지 확대, 축소를 시킬 것인지 여부
        //scaleAspectFill - 다 채우겠다.
        aniView.contentMode = .scaleAspectFill
        return aniView
    }()

    //뷰가 생성되었을 때
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .black
        view.addSubview(animationView)
        //animaton의 중앙을 view의 중앙으로 두겠다.
        animationView.center = view.center
        
        //애니메이션 실행
        animationView.play{ (finish) in
            //끝나면 (finish)가 들어오면서 콜백 문법이 실행
            print("애니메이션 끝남")
            
            //클로저 안에서는 self를 붙여서 자기 자신임을 증명
            self.view.backgroundColor = .white
            self.animationView.removeFromSuperview()
            
            self.view.addSubview(self.titleLabel)
            //애니메이션이 끝나고 text부분 출력
            
            self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
            //equalTo: 부모 선언 부모가 view기때문에 view.centerXAnchor로 선언
            self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            self.titleLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        }
    }
}

