//
//  SearchResultViewController.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/02.
//

import UIKit
import NMapsMap

class SearchResultViewcontroller: UIViewController {
    
    let mapView = NMFMapView()
    var receiveList: [TempKeywordResult]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        for i in 0..<receiveList!.count {
            let marker = NMFMarker(position: NMGLatLng(lat: receiveList![i].y, lng: receiveList![i].x))
            marker.mapView = mapView
        }
        
    }
    
    func attribute() {
        mapView.moveCamera(
            NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: receiveList![0].y,
                                                                  lng: receiveList![0].x), zoom: 6)))
    }
    
    func layout() {
        [mapView].forEach { view.addSubview($0) }
        
        mapView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    
    
    
}
