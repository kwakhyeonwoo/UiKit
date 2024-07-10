//
//  ViewController.swift
//  QRCodeCheck
//
//  Created by 곽현우 on 7/9/24.
//

import UIKit
import WebKit
//사진이나 영상에 사용하는 Framework
import AVFoundation
import QRCodeReader

//QRCode 핸드폰으로 연동시켜서 사용해보기
class MainViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var qrcodeButton: UIButton!
    
    //QR코드 리더 뷰 컨트롤러 생성
    // Good practice: create the reader lazily to avoid cpu overload during the
    // initialization and each time we need to scan a QRCode
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showTorchButton        = false
            $0.showSwitchCameraButton = false
            $0.showCancelButton       = false
            $0.showOverlayView        = true
            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    //MARK: - 오버라이드
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = URL (string: "https://www.naver.com")
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
        
        qrcodeButton.layer.borderWidth = 3
        qrcodeButton.layer.borderColor = UIColor.blue.cgColor
        qrcodeButton.layer.cornerRadius = 10
        //for : .touchUpInside - 언제 실행할거냐 = 터치가 되면 실행하겠다 선언
        //url링크나 method를 target으로 선언 #
        qrcodeButton.addTarget(self, action: #selector(qrcodeReaderLaunch), for: .touchUpInside)
    }
    
    //@objc를 이용해서 Request할때 qrcodeReaderLaunch사용
    //MARK: - fileprivate 메소드
    @objc fileprivate func qrcodeReaderLaunch(){
        print("MainViewController - qrcodeReaderLaunch() called")
        
        // Retrieve the QRCode content
          // By using the delegate pattern
          readerVC.delegate = self

          // Or by using the closure pattern
          readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            print(result)
              
              //현재 result가 옵셔널 되어 있으므로 언래핑 과정
              guard let scannedURLString = result?.value else { return }
              
              print("scannedURLString: \(scannedURLString)")
              let scannedUrl = URL(string: scannedURLString)
              self.webView.load(URLRequest(url: scannedUrl!))
          }

          // Presents the readerVC as modal form sheet
          readerVC.modalPresentationStyle = .formSheet
         
          //설정된 QR코드 뷰 컨트롤러를 화면에 보여줌
          present(readerVC, animated: true, completion: nil)
    }
    
    //MARK: - QR코드 리더 델리겟 메소드
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
      reader.stopScanning()

      dismiss(animated: true, completion: nil)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
      reader.stopScanning()

      dismiss(animated: true, completion: nil)
    }
}

