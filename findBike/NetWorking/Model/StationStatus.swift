//
//  StationStatus.swift
//  findBike
//
//  Created by Israel on 2/15/19.
//  Copyright © 2019 Israel. All rights reserved.
//

import Foundation
import EVReflection

class StationStatus: EVNetworkingObject {
    var id : NSNumber?
    var status : String?
    var availability : Availability?
}
