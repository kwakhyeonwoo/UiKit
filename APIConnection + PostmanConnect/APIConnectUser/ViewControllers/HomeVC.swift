//
//  ViewController.swift
//  APIConnectUser
//
//  Created by 곽현우 on 7/16/24.
//

import UIKit
import Toast_Swift
import Alamofire

class HomeVC: BaseVC, UISearchBarDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var searchFilterSegment: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchIndicator: UIActivityIndicatorView!
    
    //뷰 외부 공간을 클릭했을 때
    var keyboardDissmissTabGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: nil)
    
    //MARK: - override method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("HomeVC - viewDidLoad() called")
        //Ui설정
        self.config()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.searchBar.becomeFirstResponder()
    }
    
    //화면 넘어가기전 준비
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("HomeVc - prepare() called / seque.identifier: \(segue.identifier)")
        
        switch segue.identifier {
        case SEGUE_ID.USER_LIST_VC:
            //다음 화면의 뷰 컨트롤러를 가져옴
            //segue가 USER_LIST_VC면 UserListVC로 받겠다 (as! - 뒤에 애로 무조건 받겠다)
            let nextVC = segue.destination as! UserListVC
            
            //언래핑 과정 값이 존재하면 userInputValue에 넣고 없으면 반환한다
            guard let userInputValue = self.searchBar.text else { return }
            
            nextVC.vcTitle = userInputValue + " 🧑‍💻"
        case SEGUE_ID.PHOTO_COLLECTION_VC:
            let nexttVC = segue.destination as! PhotoCollectionVC
            
            guard let userInputValue2 = self.searchBar.text else { return }
            
            nexttVC.vcTitle = userInputValue2 + " 🤦‍♂️"
        default:
            print("default")
        }
    }
    
    //화면에 전환할때 보여주는 뷰 viewWillAppear가 있으면 viewWillDisappear가 있어야 함
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("HomeVC - viewWillAppear() called")
        
        //키보드 올라가는 이벤트를 받는 처리(옵저버를 활용해서 처리함)
        //키보드 노티 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowHandling(notification: )), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideHandling), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("HomeVC - viewDidAppear() called ")
        
        //키보드 노티 해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: - fileprivate methods
    fileprivate func config(){
        //ui 설정
        self.searchButton.layer.cornerRadius = 10
        //Ui에 나오는 가로 선 제거
        self.searchBar.searchBarStyle = .minimal
        //self가 HomeVC를 사용한다는 의미인데 HomeVC는 UISearchBarDelegate를 사용하기 때문에 self를 사용해도 괜찮음
        self.searchBar.delegate = self
        
        self.keyboardDissmissTabGesture.delegate = self
        //제스처 추가 하기
        self.view.addGestureRecognizer(keyboardDissmissTabGesture)
        
    }
    
    //메소드간 이동
    fileprivate func pushVC(){
        var segueID : String = ""
        
        switch searchFilterSegment.selectedSegmentIndex {
        //사진 검색을 클릭했을 경우
        case 0:
            print("사진 화면으로 이동")
            segueID = "goToPhotoCollectionVC"
        //사용자 검색을 클릭했을 경우
        case 1:
            print("사용자 화면으로 이동")
            segueID = "goToUserListVC"
        default:
            print("default")
            segueID = "goToPhotoCollectionVC"
        }
        //화면이동
        //segueID를 통해 보낼 링크를 선택하고 자기 자신을 HomeVC에서 보낸다
        self.performSegue(withIdentifier: segueID, sender: self)
    }

    //키보드 입력시 화면이 위로 올라감
    @objc func keyboardWillShowHandling(notification: NSNotification){
        print("HomeVC - keyboardWillShowHandling() called ")
        //키보드 사이즈 가져오기
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("keyboardSizeHeight: \(keyboardSize.height)")
            print("searchButton.frame.origin.y: \(searchButton.frame.origin.y)")
            
            if(keyboardSize.height < searchButton.frame.origin.y){
                print("키보드가 버튼을 덮음")
                let distance = keyboardSize.height - searchButton.frame.origin.y
                print("\(distance)만큼 덮음")
                self.view.frame.origin.y = distance + searchButton.frame.height
            }
        }
        
//        //키보드가 프레임에 접근해서 위로 올라갈때 y축을 100만큼 올리겠다
//        self.view.frame.origin.y = -100
    }
    
    @objc func keyboardWillHideHandling(){
        print("HomeVC - keyboardWillHideHandling() called ")
        
        //키보드가 프레임에 접근해서 위로 올라갈때 y축을 0만큼 올리겠다
        self.view.frame.origin.y = 0
    }
    
    //MARK: - IBAction methods
    //검색버튼이 클릭 되었을 때
    @IBAction func onSearchButtonClicked(_ sender: UIButton) {
        print("HomeVc - onSearchButtonClicked() clicked/ \(searchFilterSegment.selectedSegmentIndex)")
        
//        let url = API.BASE_URL + "/search/photos"
//        
        guard let userInput = self.searchBar.text else { return }
//        
//        //키, 벨류 형식의 딕셔너리
//        let queryParam = ["query" : userInput, "client_id" : API.CLIENT_ID]
        
//        //AF - (alamofire약자)요청시 (url, 통신형태, 파라미터)가 들어감
//        AF.request(url, method: .get, parameters: queryParam)
//            .responseJSON(completionHandler: { response in
//            debugPrint(response)
//            
//        })
        
        var urlToCall : URLRequestConvertible?
        
        switch searchFilterSegment.selectedSegmentIndex {
        case 0:
            urlToCall = MySearchRouter.searchPhotos(term: userInput)
        case 1:
            urlToCall = MySearchRouter.searchUsers(term: userInput)
        default:
            print("default")
        }
        
        //urlToCall의 값이 존재할때만 urlConvertible실행
        if let urlConvertible = urlToCall{
            MyAlamofireManager
                .shared
                .session
                .request(urlConvertible)
                .validate(statusCode: 200..<401)
                .responseJSON(completionHandler: { response in
                debugPrint(response)
            })
        }
        
        //한꺼번에 데이터 처리 요청
        
        //검색버튼이 클릭되었을때 pushVC메소드를 통해 화면이 전환된다
//        pushVC()
    }
    
    
    
    //사진 검색, 사용자 검색이 클릭 되었을때
    @IBAction func searchFilterValueChanged(_ sender: UISegmentedControl) {
//        print("HomeVC - searchFilterValueChanged() clicked, index: \(sender.selectedSegmentIndex)")
        
        //사진검색, 사용자 검색 segment가 변경될때 값 바꿔주는 변수
        var searchBarTitle = ""
        
        switch sender.selectedSegmentIndex {
        case 0:
            searchBarTitle = "사진 키워드"
        case 1:
            searchBarTitle = "사용자 이름"
        default:
            searchBarTitle = "사진 키워드"
        }
        
        //검색창 미리 보여주기는 searchBarTitle입력으로 설정하겠다
        self.searchBar.placeholder = searchBarTitle + " 입력"
        
        //첫번째로 응답 할것이다. 포커싱을 준다. (키보드가 스스로 올라온다)
        self.searchBar.becomeFirstResponder()
//        //포커싱 해제 =resignFirstResponder()
//        self.searchBar.resignFirstResponder()
    }
    
    //MARK: - UISearchBar Delegate method
    
    //검색 버튼이 클릭 되었을때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("HomeVc - searchBarSearchButtonClicked() clicked")
        
        //사용자가 입력한 텍스트가 없으면 그냥 return을 하겠다.
        guard let userInputString = searchBar.text else{ return }
        
        //검색 버튼을 클릭했는데 텍스트가 비어있으면
        if userInputString.isEmpty{
            // toast with a specific duration and position
            self.view.makeToast("📣 검색 키워드를 입력해주세요", duration: 1.0, position: .center)
        } else{
            //값이 비어있지 않다면 pushVC를 통해 화면 전환을 함
            pushVC()
            searchBar.resignFirstResponder()
        }
    }
    //searchText이것이 내가 입력한 텍스트를 감지
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("HomeVC - searchBar textDidChanged(), searchText: \(searchText)")
        
        if (searchText.isEmpty){
            //텍스트가 비었으면 검색 버튼을 숨김
            self.searchButton.isHidden = true
            
            //main스레드에게 작업을 요청
            DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.01, execute: {
                //값이 없으면 포커싱 해제
                searchBar.resignFirstResponder()
            })
        } else{
            self.searchButton.isHidden = false
        }
    }
    
    //글자가 입력이 될 때
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        //만약 searchBar에서 텍스트가 비어있으면 0이라는 값을 넣겠다.
        let inputTextCount = searchBar.text?.appending(text).count ?? 0
        
        print("shouldChangeTextIn: \(inputTextCount)")
        
        if(inputTextCount >= 12){
            // toast with a specific duration and position
            self.view.makeToast("📢 12자까지만 입력가능합니다", duration: 1.0, position: .center)
        }
        
        if inputTextCount <= 12{
            return true
        } else{
            return false
        }
        
    }

    //MARK: - UIGestureRecognizerDelegate
    //view 외부 공간을 클릭했을 때 gestureRecognizer()를 생성하고 viewDidLoad에서 보여준다
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        print("HomeVc - gestureRecognizer shouldReceive() called ")
        
        //터치 된 애가 searchFilterSegment, searchBar면 false로 반환을 한다
        if(touch.view?.isDescendant(of: searchFilterSegment) == true){
            print("제스처가 터치 되었다.")
            return false
        } else if(touch.view?.isDescendant(of: searchBar) == true){
            print("검색바가 터치 되었다.")
            return false
        } else{
            print("화면이 터치 되었다.")
            view.endEditing(true)
            return true
        }
        
    }
    
}

