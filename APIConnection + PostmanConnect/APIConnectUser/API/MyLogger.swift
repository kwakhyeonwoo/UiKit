//
//  MyLogger.swift
//  APIConnectUser
//
//  Created by 곽현우 on 7/17/24.
//

import Foundation
import Alamofire

final class MyLogger : EventMonitor {
    
    let queue = DispatchQueue(label: "MyLogger")
    
    //로그창 [Request]부분
    func requestDidResume(_ request: Request) {
        print("MyLogger - requestDidResume()")
        debugPrint(request)
    }
    
    //로그창 [Response]부분
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        print("MyLogger - request() called ")
        debugPrint(response)
    }
}
