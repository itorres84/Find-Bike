//
//  StationsResponse.swift
//  findBike
//
//  Created by Israel on 2/14/19.
//  Copyright © 2019 Israel. All rights reserved.
//

import Foundation
import EVReflection

typealias CallbackStationsResponse = (_ response:StationsResponse?, _ error: NSError?) -> ()

class StationsResponse: ServiceStatusResponse {
    var stations:[StationResponse]?
}


class StationResponse: ServiceStatusResponse {
    
    var id: NSNumber?
    var name: String?
    var address: String?
    var addressNumber : String?
    var zipCode: String?
    var districtCode: String?
    var districtName: String?
    var altitude:String?
    var nearbyStations: [NSNumber]?
    var location:locationResponse?
    var stationType: String?
    var distance: Double?
}
