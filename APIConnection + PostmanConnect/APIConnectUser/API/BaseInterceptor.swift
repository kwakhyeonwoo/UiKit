//
//  BaseInterceptor.swift
//  APIConnectUser
//
//  Created by 곽현우 on 7/17/24.
//

import Foundation
import Alamofire

class BaseInterceptor : RequestInterceptor{
    
    //API가 Request될 때 같이 호출되는 메소드(completion이 필수로 필요함, 사용 안하면 계속 멈춰있음)
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("BaseInterceptor - adapt() called ")
        
        var request = urlRequest
        
        //에러가 나도 HTML형태가 아닌 json형태로 파일을 받겠다
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Accept")
        
//        //공통 파라미터 추가
//        var dictionary = [String : String]()
//        
//        dictionary.updateValue(API.CLIENT_ID, forKey: "client_id")
//        
//        do {
//            //request를 값을 변경하는데 파라미터는 dictionary를 넣고 request자체에 넣겠다. 그 값이 request가 된다.
//            request = try URLEncodedFormParameterEncoder().encode(dictionary, into: request)
//        } catch{
//            print("error")
//        }
                
        
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        print("BascInterceptor - retry() called")
        
        //statusCode에 값이 안들어오면 doNotRetry
        guard let statusCode = request.response?.statusCode else {
            completion(.doNotRetry)
            return
        }
        
        let data = ["statusCode" : statusCode]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATION.API.AUTH_FAIL), object: nil, userInfo: data)
        
        completion(.doNotRetry)
    }
}
