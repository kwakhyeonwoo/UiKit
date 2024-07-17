//
//  MySearchRouter.swift
//  APIConnectUser
//
//  Created by 곽현우 on 7/17/24.
//

import Foundation
import Alamofire

//검색 관련 API호출 (API관련은 다 여기서 진행)
enum MySearchRouter : URLRequestConvertible {
    
    case searchPhotos(term: String)
    case searchUsers(term: String)

    //라우팅 과정
    //URL{}안에 내용들이 baseURL - 즉 클로저 호출
    var baseURL: URL {
        return URL(string: API.BASE_URL + "search/")!
    }

    //마찬가지로 HTTPMethod{} 내용들이 method - 클로저로 호출
    //두 방식이 들어오면 get방식으로 처리를 하겠다.
    var method: HTTPMethod {
        
        switch self{
        case .searchPhotos, .searchUsers:
            return .get
        }
//        switch self {
//        case .searchPhotos:
//            return .get
//        case .searchUsers:
//            return .post
//        }
    }

    //어떤 것이 오냐에 따라 로그를 다르게 설정
    var endPoint: String {
        switch self {
        case .searchPhotos:
            return "phtots/"
        case .searchUsers:
            return "users/"
        }
    }

    var parameters : [String : String] {
        switch self {
        case let .searchPhotos(term), let .searchUsers(term):
            return ["query" : term]
        }
    }
    
    //실질적 처리는 asURLRequest에서 처리
    func asURLRequest() throws -> URLRequest {
        
        //baseURL뒤에 붙는 글자를 endPoint를 더 붙이면서 로그를 기록한다
        let url = baseURL.appendingPathComponent(endPoint)
        print("MySearchRouter - asURLRequest() called / url: \(url)")
        
        
        var request = URLRequest(url: url)
        request.method = method

        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        
//        switch self {
//        case let .get(parameters):
//            request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
//        case let .post(parameters):
//            request = try JSONParameterEncoder().encode(parameters, into: request)
//        }

        return request
    }
}
