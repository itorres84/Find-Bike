//
//  LoginResponse.swift
//  findBike
//
//  Created by Israel on 2/14/19.
//  Copyright © 2019 Israel. All rights reserved.
//

import Foundation
import EVReflection

typealias CallbackResponseLogin = (_ response:LoginResponse?, _ error: NSError?) -> ()

class LoginResponse: ServiceStatusResponse {
    
    var access_token:String?
    var expires_in:NSNumber?
    var refresh_token:String?
    var scope:String?
    var token_type:String?
    
}
