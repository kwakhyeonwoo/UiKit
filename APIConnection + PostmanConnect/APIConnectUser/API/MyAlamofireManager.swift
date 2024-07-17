//
//  MyAlamofireManager.swift
//  APIConnectUser
//
//  Created by 곽현우 on 7/17/24.
//

import Foundation
import Alamofire
import SwiftyJSON

//싱글톤 디자인 패턴 적용
final class MyAlamofireManager {
    
    //자기 자신을 가져오는 변수 shared - 싱글톤 적용
    static let shared = MyAlamofireManager()
    
    //인터셉터 - 중간에 가로채서 API를 확인
    let interceptors = Interceptor(interceptors: [
        BaseInterceptor()
    ])
    
    //로커 설정
    //자료형이 EventMonitor배열이기 때문에 as로 설정
    let monitors = [MyLogger()] as [EventMonitor]
    
    //세션 설정
    var session : Session
    
    private init(){
        session = Session (
            interceptor: interceptors,
            eventMonitors: monitors
        )
    }

    //사용하기 위해 들어오는 매개변수는 userInput이며 getPhotos메소드를 호출할 때는 searchTerm를 사용하겠다
    //completion이라 값을 반환하는게 있어야 함
    func getPhotos(searchTerm userInput: String, completion: @escaping (Result<[Photo], MyError>) -> Void){
        
        print("MyAlamofireManager - getPhotos() called, userInput: \(userInput) ")
        
        self.session
            .request(MySearchRouter.searchPhotos(term: userInput))
            .validate(statusCode: 200..<4000)
            .responseJSON(completionHandler: { response in
                
                guard let responseValue = response.value else { return }
                
                let reponseJson = JSON(responseValue)
                
                let jsonArray = reponseJson["results"]
                
                var photos = [Photo]()
                
                print("jsonArray.count: \(jsonArray.count)")
                
                for (index, subJson): (String, JSON) in jsonArray {
                    print("index: \(index), subJson: \(subJson)")
                    
                    //데이터 파싱
                    let thumnail = subJson["urls"]["thumb"].string ?? ""
                    let userName = subJson["user"]["username"].string ?? ""
                    let likesCount = subJson["likes"].intValue ?? 0
                    let createdAt = subJson["created_at"].string ?? ""
                    
                    let photoItem = Photo(thumnail: thumnail, userName: userName, likesCount: likesCount, createdAt: createdAt)
                    //배열에 넣기
                    photos.append(photoItem)
                }
                
                if photos.count > 0{
                    completion(.success(photos))
                } else {
                    completion(.failure(.noContent))
                }
            })
    }
    
}
