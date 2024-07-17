//
//  Constants.swift
//  APIConnectUser
//
//  Created by 곽현우 on 7/16/24.
//

import Foundation

enum SEGUE_ID {
    static let USER_LIST_VC = "goToUserListVC"
    static let PHOTO_COLLECTION_VC = "goToPhotoCollectionVC"
}

enum API{
    static let BASE_URL : String = "https://api.unsplash.com/"
    
    static let CLIENT_ID : String = "0VkO-ZTsdw3FtEO_ZD0JSV1WNqqQmF0KoAXf5bWy04o"
    
    
}

enum NOTIFICATION {
    enum API{
        static let AUTH_FAIL = "authentication_fail"
    }
}
