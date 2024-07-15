//
//  ViewController.swift
//  pagerView
//
//  Created by 곽현우 on 7/15/24.
//

import UIKit
import FSPagerView

class ViewController: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    fileprivate let imageNames = ["1.jpg", "2.jpg", "3.jpg", "4.jpg"]
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var myPagerView: FSPagerView!{
        didSet{
            //페이저뷰에 Cell을 등록함
            self.myPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            //아이템 크기 설정
            self.myPagerView.itemSize = FSPagerView.automaticSize
            //무한스크롤 설정
            //isInfinite = true로 하면서 무한으로 돌림
            self.myPagerView.isInfinite = true
            //자동 스크롤 설정하기
            //4초 간격으로 스크롤을 자동으로 돌리겠다
            self.myPagerView.automaticSlidingInterval = 4.0
        }
    }
    
    @IBOutlet weak var myPageControl: FSPageControl!{
        didSet{
            self.myPageControl.numberOfPages = self.imageNames.count
            //right로 자동을 돌림
            self.myPageControl.contentHorizontalAlignment = .right
            //점과 점 사이의 간격은 16으로 설정
            self.myPageControl.itemSpacing = 16
            self.myPageControl.interitemSpacing = 16
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //이때 self는 FSPagerViewDataSource의미
        self.myPagerView.dataSource = self
        //얘 self는 FSPagerViewDelegate의미
        self.myPagerView.delegate = self
        
        //왼쪽,오른쪽 버튼은 프레임(크기)에 접근해서 나눔
        self.leftButton.layer.cornerRadius = self.leftButton.frame.height / 2
        self.rightButton.layer.cornerRadius = self.rightButton.frame.height / 2
        
    }
    
    //MARK: IBActions
    @IBAction func onLeftButtonClicked(_ sender: UIButton) {
        print("ViewController - onLeftButtonClicked")
        //현재 페이지에 -1을 함으로 인덱스를 -1의 값으로 설정
        self.myPageControl.currentPage = self.myPageControl.currentPage - 1
        //-1된 인덱스를 최근 페이지로 스크롤에 적용시키면서 화면에 보여줌 
        self.myPagerView.scrollToItem(at: myPageControl.currentPage, animated: true)
    }
    
    
    @IBAction func onrightButtonClicked(_ sender: UIButton) {
        print("ViewController - onrightButtonClicked")
        
        //overflow방지를 위해 배열이 끝까지 가면 최근 값을 0으로 바꾸겠다
        if(self.myPageControl.currentPage == self.imageNames.count - 1){
            self.myPageControl.currentPage = 0
        } else{
            self.myPageControl.currentPage = self.myPageControl.currentPage + 1
        }
        
        self.myPagerView.scrollToItem(at: myPageControl.currentPage, animated: true)
    }

    //MARK: - FSPagerView Datasource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    //각 쎌에 대한 설정
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    
    //MARK: FSPagerView delegate
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.myPageControl.currentPage = targetIndex
    }
    
    //4초가 지나 사진이 이동할 때 인덱스의 값 같이 이동
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.myPageControl.currentPage = pagerView.currentIndex
    }
    
    //이미지 클릭해도 뒤에 하이라이트가 생기지 않음
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
        return false
    }
}

