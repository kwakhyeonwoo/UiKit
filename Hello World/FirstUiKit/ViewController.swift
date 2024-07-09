//
//  ViewController.swift
//  FirstUiKit
//
//  Created by 곽현우 on 7/9/24.
//

import UIKit

class ViewController: UIViewController {
    //제목 작성
    var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Hello World!"
        label.textAlignment = .center
        //systemFont = 폰트 크기, boldSystemFont = 폰트크기 + 강조 선언
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .white
        return label
        
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .red
        view.addSubview(titleLabel)
        
        //X축, Y축을 가운데에 설정하겠다.
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }


}

