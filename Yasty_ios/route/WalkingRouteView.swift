//
//  WakingRouteView.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/26.
//

import UIKit
import Then
import NMapsMap
import CoreLocation


class WalkingRouteView: UIViewController, CLLocationManagerDelegate {
    //위치 매니저 변수
    var locationManager: CLLocationManager!
    var dataManager = GetPath()
    
    
    //let mapView2 = NMFMapView()
    let searchTextField = UITextField()
    let paddingView = UIView()
    let freeButton = UIButton()
    let mapView = NMFMapView()
    var tempPathOverlay: [[Double]] = []
    let backButton = UIButton()
    
    //위도와 경도
    var latitude: Double?
    var longitude: Double?
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        
        //위치 오버레이
        let locationOverlay = mapView.locationOverlay
        locationOverlay.hidden = true
        
        //경로선 오버레이
        let pathOverlay = NMFPath()
        var nmgLatLng: [NMGLatLng] = []
        tempPathOverlay.forEach {
            nmgLatLng.append(NMGLatLng(lat: $0[0], lng: $0[1]))
        }
        
        pathOverlay.path = NMGLineString(points: nmgLatLng)
        // 캐스팅
        pathOverlay.mapView = mapView
        
        // 현 위치 위도 경도 설정
        let coor = locationManager?.location?.coordinate
        latitude = coor?.latitude
        longitude = coor?.longitude
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // when in use auth로 요청 등록
        
        // 카메라 이동
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: 37.45313, lng: 127.05056), zoomTo: 12)
        self.mapView.moveCamera(cameraUpdate)
        print(latitude ?? 0.0)
    }
    
    
    

    
    func attribute() {
        paddingView.do {
            $0.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        }
//        backButton.do {
//            $0.tintColor = .black
//            $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
//            $0.addTarget(self, action: #selector(backButtonDipTap2), for: .touchUpInside)
//        }
    }
    
    func layout() {
        [ mapView, searchTextField, freeButton ].forEach {
            view.addSubview($0)
        }
        
        mapView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            //위
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            //밑
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            //왼쪽
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            //오른쪽
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
//        backButton.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
//            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        }
    }
    @objc func freeButtonDipTap() {
        let searchResult = FSMResultMapView()
        self.present(searchResult, animated: true)
    }
    @objc func backButtonDipTap2() {
        //뒤로가기
        //present 일때만 dismiss 이다
        self.dismiss(animated: false)
    }
}

