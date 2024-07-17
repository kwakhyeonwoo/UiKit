//
//  MyAlamofireManager.swift
//  APIConnectUser
//
//  Created by 곽현우 on 7/17/24.
//

import Foundation
import Alamofire

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

    
}
