//
//  ViewController.swift
//  Addadvertisement
//
//  Created by 곽현우 on 7/12/24.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let viewWidth = view.frame.inset(by: view.safeAreaInsets).width

            // Here the current interface orientation is used. Use
            // GADLandscapeAnchoredAdaptiveBannerAdSizeWithWidth or
            // GADPortraitAnchoredAdaptiveBannerAdSizeWithWidth if you prefer to load an ad of a
            // particular orientation,
            let adaptiveSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(viewWidth)
            //배너 뷰 사이즈 설정
            bannerView = GADBannerView(adSize: adaptiveSize)
        
            //Set the ad unit ID and view controller that contains the GADBannerView.
            //테스트용 광고 코드
            bannerView.adUnitID = "ca-app-pub-3940256099942544/2435281174"
            bannerView.rootViewController = self
            //광고를 로드함
            bannerView.load(GADRequest())
            //델리겟을 배너뷰에 연결 - 이게 없으면 안되는 중요한 사안
            bannerView.delegate = self
    }

    //화면에 배너뷰 추가
    func addBannerViewToView(_ bannerView: GADBannerView) {
        //오토레이아웃으로 배너 뷰 설정
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        //루트뷰에 배너 추가
        view.addSubview(bannerView)
        //앵커를 설정해 오토레이아웃 설정
        view.addConstraints(
          [NSLayoutConstraint(item: bannerView,
                              attribute: .bottom,
                              relatedBy: .equal,
                              toItem: view.safeAreaLayoutGuide,
                              attribute: .bottom,
                              multiplier: 1,
                              constant: 0),
           NSLayoutConstraint(item: bannerView,
                              attribute: .centerX,
                              relatedBy: .equal,
                              toItem: view,
                              attribute: .centerX,
                              multiplier: 1,
                              constant: 0)
          ])
       }
    
    //MARK: - GADBannerViewDelegate 관련 메소드
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
        //화면에 배너뷰 추가
        addBannerViewToView(bannerView)
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
    
}

