//
//  ViewController.swift
//  NavigationBar
//
//  Created by 곽현우 on 7/12/24.
//

import UIKit

class ViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    let myView = UIView()

    func configureCustomView(){
        var bottomSafeAreaInsets: CGFloat = 0.0
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        if let hasWindowScene = windowScene {
            bottomSafeAreaInsets = hasWindowScene.windows.first?.safeAreaInsets.bottom ?? 0
        }
        
        self.myView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.myView)
        self.myView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.myView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.myView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.myView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.myView.heightAnchor.constraint(equalToConstant: bottomSafeAreaInsets)
        ])
    }
}

