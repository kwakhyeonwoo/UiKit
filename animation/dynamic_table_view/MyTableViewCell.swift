//
//  MyTableViewCell.swift
//  dynamic_table_view
//
//  Created by Jeff Jeong on 2020/09/01.
//  Copyright © 2020 Tuentuenna. All rights reserved.
//

import Foundation
import UIKit
import SwipeCellKit

class MyTableViewCell: SwipeTableViewCell {
 
    
    @IBOutlet weak var userProfileImg: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    // 하트 버튼
    //하트 버튼을 커스텀 함
    @IBOutlet var heartBtn: MyHeartButton!
    
    // 따봉 버튼
    @IBOutlet var thumbsUpBtn: UIButton!
    
    //공유 버튼
    @IBOutlet weak var shareButton: UIButton!
    
    //버튼 3개를 가리키는 변수
    @IBOutlet var btns : [UIButton]!
    
    //현재 버튼의 상태가 참,거짓을 구분하는 Bool형태이기 때문에 return으로 반환
    var heartButtonAction : ((Bool) -> Void)?
    
    //awakeFromNib - 객체가 초기화 된 후 호출
    override func awakeFromNib() {
        print("MyTableViewCell - awakeFromNib() called")
        super.awakeFromNib()
        
        userProfileImg.layer.cornerRadius = userProfileImg.frame.height / 2
        btns.forEach{ $0.addTarget(self, action: #selector(onButtonClicked(_ :)), for: .touchUpInside)}
    }
    
    func updateUI(with data: Feed){
        print("MyTableViewCell - updateUI() called")
        
        heartBtn.setState(data.isFavorite)
        // 피드 데이터에 따라 쎌의 UI 변경
        thumbsUpBtn.tintColor = data.isThumbsUp ? #colorLiteral(red: 0.1887893739, green: 0.3306484833, blue: 1, alpha: 1) : .systemGray2
        contentLabel.text = data.content
    }
    
    //각 버튼이 클릭될 때 발생하는 이벤트들
    @objc fileprivate func onButtonClicked(_ sender: UIButton){
        switch sender {
        case heartBtn:
            print("하트 버튼이 클릭됨")
            //MyHeartButton에 가지고 있는 상태인 isActivated를 View로 가져옴 
            heartButtonAction?(heartBtn.isActivated)
        case thumbsUpBtn:
            print("따봉 버튼이 클릭되았디.")
        case shareButton:
            print("공유 버튼이 클릭되었다.")
        default:
            break
        }
    }
    
}
