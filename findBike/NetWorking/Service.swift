//
//  Service.swift
//  findBike
//
//  Created by Israel on 2/13/19.
//  Copyright © 2019 Israel. All rights reserved.
//

import Foundation
import Alamofire

class Service
{
    var baseURLString = ""
    var headers: HTTPHeaders!
    
    func getURL(servicePath:String) -> URLConvertible?
    {
        let url : String = "\(baseURLString)\(servicePath)"
        
        return url
    }
    
    func getStringURL(servicePath:String) -> URLConvertible?
    {
        let url : String = "\(servicePath)"
        return url
    }
    
}
