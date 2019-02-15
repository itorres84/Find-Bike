//
//  ListBikesPresenter.swift
//  findBike
//
//  Created by Israel on 2/12/19.
//  Copyright (c) 2019 Israel. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import CoreLocation

final class ListBikesPresenter {

    // MARK: - Private properties -

    private unowned let _view: ListBikesViewInterface
    private let _wireframe: ListBikesWireframeInterface
    private let _interactor: ListBikesInteractorInterface

    // MARK: - Lifecycle -

    init(wireframe: ListBikesWireframeInterface, view: ListBikesViewInterface, interactor: ListBikesInteractorInterface) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
    }
}

// MARK: - Extensions -

extension ListBikesPresenter: ListBikesPresenterInterface {
    
    func getStationsNearby(_ id: NSNumber) {
        _interactor.getStationsNearby(id) { (arrFindStations) in
            self._view.succesStationsNearby(arrFindStations!)
        }
    }
    
    
    func goToDetail(_ data: StationView, _ arrFind: [StationView]) {
        _wireframe.navigate(to: ListBikesNavigationOption.detail, data, arrFind)
    }
    
    
    func autenticate() {
        _interactor.autenticate { (response, error) in
            if let _ = error{
                self._view.loginSucces(false)
            }else{
                self._view.loginSucces(true)
            }
        }
    }

    func getStationsStatus() {
        _interactor.getStationsStatus()
    }
    
    func getStations(_ location:CLLocation) {
        _interactor.getStations(location) { (arrViews) in
            self._view.setDataView(arrViews!)
        }
    }
    
}
