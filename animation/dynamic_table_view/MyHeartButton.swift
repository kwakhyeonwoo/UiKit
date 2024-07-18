//
//  MyHeartButton.swift
//  dynamic_table_view
//
//  Created by 곽현우 on 7/18/24.
//  Copyright © 2024 Tuentuenna. All rights reserved.
//

import Foundation
import UIKit

class MyHeartButton : UIButton{

    //상태 변화에 따른 변수
    var isActivated : Bool = false
    
    //변경된 상태에 대한 이미지 변경
    let activatedImage = UIImage(systemName:
                                    "heart.fill")?.withTintColor(.systemPink).withRenderingMode(.alwaysOriginal)
    
    let normalImage = UIImage(systemName: "heart")?.withTintColor(.systemGray2).withRenderingMode(.alwaysOriginal)
    
    //스토리보드로 작성한 뷰를 호출하는 것
    override func awakeFromNib() {
        super.awakeFromNib()
        print("MyHeartButton - awakeFromNib() called")
        configureAction()
    }
    
    func setState(_ newValue : Bool){
        print("MyHeatButton - setState() called / newValue: \(newValue)")
        
        //현재 버튼의 상태 변경
        //현재의 상태를 매개변수로 들어온 newValue를 통해 변경하겠다
        self.isActivated = newValue
        
        self.setImage(self.isActivated ? activatedImage : normalImage, for: .normal)
        
    }
    
    fileprivate func configureAction(){
        print("MyHeartButton - configureAction() called")
        self.addTarget(self, action: #selector(onBtnClicked(_:)), for: .touchUpInside)
    }
    
    @objc fileprivate func onBtnClicked(_ sender : UIButton){
        print("MyHeartButton - onBtnClicked() called")
        self.isActivated.toggle()
        
        //애니메이션 처리하기
        animate()
    }
    
    fileprivate func animate(){
        print("MyHeartButton - animate() called")
        
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            guard let self = self else { return }
            //내부 상태가 클로저이기때문에 self.activatedImage로 self를 붙여줌
            let newImage = self.isActivated ? self.activatedImage : self.normalImage
            //클릭 됐을때 쪼그라들기 - 스케일(크기가 변경됨 1초동안 작게 만들기)
            self.transform = self.transform.scaledBy(x: 0.5, y: 0.5)
            //바뀐 이미지를 setImage를 활용해서 적용함, 상태는 기본값으로 저장
            self.setImage(newImage, for: .normal)
        }, completion: { _ in
            //원래 크기로 돌리기
            UIView.animate(withDuration: 0.1, animations: {
                //원래 있던 자기 자신의 크기로 바꾼다.
                self.transform = CGAffineTransform.identity
            })
        })
    }
}
