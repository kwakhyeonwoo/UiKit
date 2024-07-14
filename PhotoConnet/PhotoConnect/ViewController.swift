//
//  ViewController.swift
//  PhotoConnect
//
//  Created by 곽현우 on 7/14/24.
//

import UIKit
import YPImagePicker

class ViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileChangeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //이미지 크기 변경
        self.profileImage.layer.cornerRadius = profileImage.frame.height / 2
        self.profileChangeButton.layer.cornerRadius = 10
        
        //viewDidLoad자체적으로 버튼 액션 활성화
        self.profileChangeButton.addTarget(self, action: #selector(onProfileChnageButtonClicked), for: .touchUpInside)
        
    }

    //프사 변경 버튼이 클릭되었을때 활동
    @objc fileprivate func onProfileChnageButtonClicked(){
        print("ViewController - onProfileChnageButtonClicked() clicked")
        
        //카메라 라이브러리 세팅
        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo, .video]
        
        let picker = YPImagePicker(configuration: config)
        
        //사진이 선택 되었을때
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
                //사진이 선택되면 이미지 변경
                self.profileImage.image = photo.image
            }
            //사진 선택창 닫기
            picker.dismiss(animated: true, completion: nil)
        }
        //사진 선택창 보여주기
        present(picker, animated: true, completion: nil)
    }
}

