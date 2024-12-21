//
//  MainTabBarController.swift
//  UIKitNoStoryBoardCloneCode
//
//  Created by 곽현우 on 11/28/24.
//

import UIKit

class MainTabBarController: UITabBarController{
    //메모리에 올라갈 때
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MainTabBarController - viewDidLoad() called")
        // MARK: 버튼 눌렸을때 나오는 배경
        let firstNC = UINavigationController.init(rootViewController: MyViewController(title: "첫번째", bgColor: UIColor.blue))
        let secondNC = UINavigationController.init(rootViewController: MyViewController(title: "두번째", bgColor: UIColor.red))
        let thirdNC = UINavigationController.init(rootViewController: MyViewController(title: "세번째", bgColor: UIColor.green))
        let forthNC = UINavigationController.init(rootViewController: MyViewController(title: "네번째", bgColor: UIColor.gray))
        let fifthNC = UINavigationController.init(rootViewController: MyViewController(title: "다섯번째", bgColor: UIColor.black))
        
        firstNC.navigationBar.barTintColor = .white
        secondNC.navigationBar.barTintColor = .white
        thirdNC.navigationBar.barTintColor = .white
        forthNC.navigationBar.barTintColor = .white
        fifthNC.navigationBar.barTintColor = .white
        
        self.viewControllers = [firstNC, secondNC, thirdNC, forthNC, fifthNC]
        
        // MARK: 버튼 누를 수 있는 아이콘 버튼
        let firstTabBarItem = UITabBarItem(title: "첫번째", image: UIImage(systemName: "airplayaudio"), tag: 0)
        let secondTabBarItem = UITabBarItem(title: "두번째", image: UIImage(systemName: "airplayvideo"), tag: 1)
        let thirdTabBarItem = UITabBarItem(title: "세번째", image: UIImage(systemName: "arrow.clockwise.icloud.fill"), tag: 2)
        let fourthTabBarItem = UITabBarItem(title: "네번째", image: UIImage(systemName: "arrow.down.left.video.fill"), tag: 3)
        let fifthTabBarItem = UITabBarItem(title: "다섯번째", image: UIImage(systemName: "safari.fill"), tag: 4)
        
        firstNC.tabBarItem = firstTabBarItem
        secondNC.tabBarItem = secondTabBarItem
        thirdNC.tabBarItem = thirdTabBarItem
        forthNC.tabBarItem = fourthTabBarItem
        fifthNC.tabBarItem = fifthTabBarItem
        
        self.tabBar.barTintColor = .white
    }
}
