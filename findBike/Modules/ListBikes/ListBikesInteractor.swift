//
//  ListBikesInteractor.swift
//  findBike
//
//  Created by Israel on 2/12/19.
//  Copyright (c) 2019 Israel. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import CoreLocation

typealias CallbackStationsView = (_ response:[StationView]?) -> ()

class StationView: NSObject {
    var id: NSNumber?
    var name: String?
    var direccion:String?
    var estatus:String?
    var disponible:Availability?
    var location:locationResponse?
}



final class ListBikesInteractor{
    var location:CLLocation!
    var user: LoginResponse!
    var arrStations: [StationResponse] = []
    var arrStationsStatus: [StationStatus] = []
    let ws = EcobiciService()
    
}

// MARK: - Extensions -
extension ListBikesInteractor: ListBikesInteractorInterface {
    
    func getStationsNearby(_ id: NSNumber, callback: @escaping CallbackStationsView) {
        
        let selectedStation = self.arrStations.filter { (sta) -> Bool in
            id == sta.id
        }.first
        
        let locStation = CLLocation(latitude: CLLocationDegrees(exactly: (selectedStation!.location?.lat)!)!, longitude: CLLocationDegrees(exactly: (selectedStation!.location?.lon)!)!)
        
        for findstation in self.arrStations{
            let findLocation = CLLocation(latitude: CLLocationDegrees(exactly: (findstation.location?.lat)!)!, longitude: CLLocationDegrees(exactly: (findstation.location?.lon)!)!)
            findstation.distance = self.distanceBetweenTwoLocations(source: locStation, destination: findLocation)
        }
        
        self.arrStations.sort(by: { (val1, val2) -> Bool in
            Int(val1.distance!) < Int(val2.distance!)
        })
        
        let arrStationCut = arrStations.prefix(25)
        var arrView:[StationView] = []
        for arr in arrStationCut{
            
            let statusBike = self.arrStationsStatus.filter({ (station) -> Bool in
                station.id == arr.id
            }).first
            
            let stationView = StationView()
            stationView.direccion = arr.address
            stationView.disponible = statusBike?.availability
            stationView.estatus = statusBike?.status
            stationView.location = arr.location
            stationView.id = arr.id
            stationView.name = arr.name
            arrView.append(stationView)
        }
        callback(arrView)
    }
    
    func autenticate(callback:@escaping CallbackResponseLogin) {
        
        ws.autenticate { (response, error) in
            if let _ = error{
                print(error?.localizedDescription ?? "")
            }else{
                self.user = response
                callback(response, error)
                
            }
        }
    }
    
    
    
    func getStationsStatus() {
        
        if user == nil{
            
            ws.autenticate { (response, error) in
                
                if let _ = error{
                    print(error?.localizedDescription ?? "")
                }else{
                    self.user = response
                    self.ws.getStationsStatus { (response, error) in
                        
                        if let _ = error{
                            print(error?.localizedDescription ?? "")
                            
                        }else{
                            
                            print(response)
                            self.arrStationsStatus = (response?.stationsStatus)!
                            
                        }
                    }
                    
                }
                
            }
            
            
        }else{
         
            self.ws.getStationsStatus { (response, error) in
                
                if let _ = error{
                    print(error?.localizedDescription ?? "")
                    
                }else{
                    
                    print(response)
                    self.arrStationsStatus = (response?.stationsStatus)!
                    
                }
            }
            
        }
    }
    

    func getStations(_ location:CLLocation, callback:@escaping CallbackStationsView) {
     
        self.location = location
    
            
        self.ws.getStations(callback: { (response, error) in
                
            if let _ = error{
                print(error?.localizedDescription ?? "Error")
            }else{
                self.arrStations = (response?.stations)!
                var arrStations = response?.stations
                for station in arrStations!{
                    let locStation = CLLocation(latitude: CLLocationDegrees(exactly: (station.location?.lat)!)!, longitude: CLLocationDegrees(exactly: (station.location?.lon)!)!)
                    station.distance = self.distanceBetweenTwoLocations(source: self.location, destination: locStation)
                }
                
                arrStations?.sort(by: { (val1, val2) -> Bool in
                    Int(val1.distance!) < Int(val2.distance!)
                })
                
                let arrStationCut = arrStations!.prefix(25)
                
                var arrView:[StationView] = []
                for arr in arrStationCut{
                    
                    let statusBike = self.arrStationsStatus.filter({ (station) -> Bool in
                                        station.id == arr.id
                                     }).first
                    
                    let stationView = StationView()
                    stationView.direccion = arr.address
                    stationView.disponible = statusBike?.availability
                    stationView.estatus = statusBike?.status
                    stationView.location = arr.location
                    stationView.id = arr.id
                    stationView.name = arr.name
                    arrView.append(stationView)
                }
                
                callback(arrView)
                
            }
        })
        
    }
    
    private func distanceBetweenTwoLocations(source:CLLocation,destination:CLLocation) -> Double{
        
        let distanceMeters = source.distance(from: destination)
        print("Distancia en Metros \(distanceMeters)")
        
        let distanceKM = distanceMeters / 1000
        return distanceKM
        
    }
    
}
