//
//  EcobiciService.swift
//  findBike
//
//  Created by Israel on 2/13/19.
//  Copyright © 2019 Israel. All rights reserved.
//

import Foundation
import Alamofire

enum grantType{
    
    case auth
    case refresh
    
    func getAccion() -> String {
        switch self {
        case .auth:
            return "client_credentials"
        case .refresh:
            return "grant_type"
        }
    }
    
}


class EcobiciService: Service {
    
    var client_id:String?
    var client_secret:String?
    var grant_type:grantType?
    
    var user:LoginResponse!
    
    
    override init() {
        client_id = "1628_1gvf84huvlwksk44k0gg40gs8ks0c880gkkw8o0k040o48goss"
        client_secret = "3hnz902nqg8w4g0s4k0s4400cggscksc0sgkk0w0g4ws4gc440"
        grant_type = .auth
    }
    
    func autenticate(callback:@escaping CallbackResponseLogin){
        
        Alamofire.request("https://pubsbapi.smartbike.com/oauth/v2/token", method: .get, parameters: ["client_id":self.client_id!,"client_secret":self.client_secret!,"grant_type":(self.grant_type?.getAccion())!], encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<300).responseObject{(response: DataResponse<LoginResponse>) in
                
                print("REQUESTT: \(String(describing: response.request))")
                
                switch response.result
                {
                case .success(let loginResponse):
                    
                    self.user = loginResponse
                    callback(loginResponse, nil)
                    break
                    
                case .failure(let error):
                    callback(nil, error as NSError)
                    break
                    
                }
        }
    }
    
    func getStations(callback:@escaping CallbackStationsResponse){
        
        Alamofire.request("https://pubsbapi.smartbike.com/api/v1/stations.json", method: .get, parameters: ["access_token":user.access_token!], encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<300).responseObject{(response: DataResponse<StationsResponse>) in
            
            print("REQUESTT: \(String(describing: response.request))")
            
            switch response.result
            {
            case .success(let stationResponse):
                callback(stationResponse, nil)
                break
                
            case .failure(let error):
                callback(nil, error as NSError)
                break
                
            }
        }
        
    }
    
    
    func getStationsStatus(callback:@escaping CallbackStationsStatusResponse){
        
        Alamofire.request("https://pubsbapi.smartbike.com/api/v1/stations/status.json", method: .get, parameters: ["access_token":user.access_token!], encoding: URLEncoding.default, headers: nil).validate(statusCode: 200..<300).responseObject{(response: DataResponse<StationsStatus>) in
            
            print("REQUESTT: \(String(describing: response.request))")
            
            switch response.result
            {
            case .success(let stationResponse):
                callback(stationResponse, nil)
                break
                
            case .failure(let error):
                callback(nil, error as NSError)
                break
                
            }
        }
        
    }
    
    
    
    
}
