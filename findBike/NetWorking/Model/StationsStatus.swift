//
//  StationsStatus.swift
//  findBike
//
//  Created by Israel on 2/15/19.
//  Copyright © 2019 Israel. All rights reserved.
//

import Foundation
import EVReflection

typealias CallbackStationsStatusResponse = (_ response:StationsStatus?, _ error: NSError?) -> ()

class StationsStatus: ServiceStatusResponse {
    var stationsStatus:[StationStatus]?
}
