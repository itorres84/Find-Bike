//
//  ConstNetWorking.swift
//  findBike
//
//  Created by Israel on 2/13/19.
//  Copyright © 2019 Israel. All rights reserved.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "https://pubsbapi.smartbike.com/"
    }
    
    struct APIParameterKey {
        static let client_id = "client_id"
        static let client_secret = "client_secret"
        static let grant_type = "grant_type"
        static let access_token = "access_token"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
