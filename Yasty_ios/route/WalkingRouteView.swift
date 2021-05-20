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
    var locationManager = CLLocationManager()
    var dataManager = GetPath()
    let SRVC = SearchResultViewController()
    
    //TimeBottomSheet
    let timeBottomSheet = UIView()
    let screenSize = UIScreen.main.bounds
    let indicatorBar = UIView()
    let indicatorBackgroundView = UIView()
    lazy var bottomPangesture = UIPanGestureRecognizer(
        target: self, action: #selector(bottomPangestureDidStart))
    var preYValue: CGFloat = 0.0
    var totalTimeLabel = UILabel()
    var destinationName = UILabel()
    var predictTime = UILabel()
    var destinationAddress = UILabel()
    
    
    //let mapView2 = NMFMapView()
    let searchTextField = UITextField()
    let paddingView = UIView()
    let freeButton = UIButton()
    let mapView = NMFMapView()
    var tempPathOverlay: [[Double]] = []
    let backButton = UIButton()
    var overlay: NMFLocationOverlay!
    
    //위도와 경도
    var latitude: Double?
    var longitude: Double?
    var startLat: Double = 0.0
    var startLng: Double = 0.0
    var endLat: Double = 0.0
    var endLng: Double = 0.0
    
    //
    let destinationMarker = NMFMarker()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locationManager.location {
            let coor = location.coordinate
            latitude = coor.latitude
            longitude = coor.longitude
            overlay.location = NMGLatLng(lat: latitude!, lng: longitude!)
//            locationManager.delegate = self
            
             // when in use auth로 요청 등록
        }
        print("업데이트")
        print(manager)
        print(locations)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        timeBottomSheetAnimate()
        // 도착지점 마커 생성 시잇프얼 안됨 왜?
        // ???????
        destinationMarker.position = NMGLatLng(lat: endLat, lng: endLng)
        destinationMarker.mapView = mapView
        destinationMarker.iconTintColor = UIColor.red
        print("마커 지점 여기닷",endLat,endLng)
        //위치 오버레이
//        let locationOverlay = mapView.locationOverlay
//        locationOverlay.hidden = true
        
        //경로선 오버레이
        let pathOverlay = NMFPath()
        var nmgLatLng: [NMGLatLng] = []
        nmgLatLng.append(NMGLatLng(lat: latitude!, lng: longitude!))
        tempPathOverlay.forEach {
            nmgLatLng.append(NMGLatLng(lat: $0[0], lng: $0[1]))
        }
        nmgLatLng.append(NMGLatLng(lat: endLat, lng: endLng))
        
        pathOverlay.path = NMGLineString(points: nmgLatLng)
        // 캐스팅
        pathOverlay.mapView = mapView
        
        // 카메라 이동
        
        self.startLat = self.latitude ?? 0.0
        self.startLng = self.longitude ?? 0.0
        
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: latitude ?? 0.0, lng: longitude ?? 0.0), zoomTo: 14)
        self.mapView.moveCamera(cameraUpdate)
        print(latitude ?? 0.0)
        print("워킹루트뷰 위도경도는 여깄다 !",SRVC.startLat,SRVC.startLng)
    }
    
    
    

    
    func attribute() {
        paddingView.do {
            $0.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        }
        backButton.do {
            $0.tintColor = .black
            $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
            $0.addTarget(self, action: #selector(backButtonDipTap2), for: .touchUpInside)
        }
        overlay = mapView.locationOverlay
        overlay.do {
            $0.hidden = false
            $0.iconWidth = 100
            $0.iconHeight = 100
        }
        indicatorBar.do {
            $0.backgroundColor = .gray
            $0.alpha = 0.1
            $0.layer.cornerRadius = 3
            $0.layer.masksToBounds = true
        }
        indicatorBackgroundView.do {
            $0.backgroundColor = .clear
            $0.addGestureRecognizer(bottomPangesture)
        }
        locationManager.do {
            $0.delegate = self
            $0.requestWhenInUseAuthorization()
            $0.startUpdatingLocation()
        }
        timeBottomSheet.do {
            $0.layer.cornerRadius = 25
            $0.layer.masksToBounds = false
            $0.backgroundColor = .white
            $0.layer.shadowColor = UIColor.gray.cgColor
            $0.layer.shadowOffset = CGSize(width: 0, height: 4)
            $0.layer.shadowRadius = 3
            $0.layer.shadowOpacity = 0.8
            $0.frame = CGRect(x: 0,
                              y: screenSize.height,
                              width: screenSize.width,
                              height: screenSize.height / 4)
        }
        predictTime.do {// 나눠서 어케함?
            $0.text = "16분 | 오후 3시 33분 도착"
            $0.textColor = .systemBlue
            $0.font = .boldSystemFont(ofSize: 25)
        }
        destinationName.do {
            $0.text = "야탑역 1번 출구"
            $0.textColor = .systemBlue
            $0.font = .systemFont(ofSize: 20)
        }
        destinationAddress.do {
            $0.text = "경기도 성남시 ...야탑동 220번지"
            $0.textColor = .gray
            $0.font = .systemFont(ofSize: 12)
        }
    }
    
    func layout() {
        [ mapView, backButton, timeBottomSheet].forEach {
            view.addSubview($0)
        }
        [ indicatorBar, indicatorBackgroundView,
          destinationName, destinationAddress, predictTime ].forEach { timeBottomSheet.addSubview($0) }
        
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
        backButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
        indicatorBar.do {
            $0.translatesAutoresizingMaskIntoConstraints = true
            $0.topAnchor.constraint(equalTo: timeBottomSheet.topAnchor, constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: timeBottomSheet.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 10).isActive = true
        }
        indicatorBackgroundView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: timeBottomSheet.topAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: timeBottomSheet.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 100).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        predictTime.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: timeBottomSheet.topAnchor,constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: timeBottomSheet.leadingAnchor, constant: 15).isActive = true
        }
        destinationName.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: predictTime.topAnchor,constant: 30).isActive = true
            $0.leadingAnchor.constraint(equalTo: timeBottomSheet.leadingAnchor, constant: 15).isActive = true
        }
        destinationAddress.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: destinationName.topAnchor, constant: 30).isActive = true
            $0.leadingAnchor.constraint(equalTo: timeBottomSheet.leadingAnchor, constant: 15).isActive = true
        }
    }
    func timeBottomSheetAnimate() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.timeBottomSheet.frame = CGRect(x: 0,
                                             y: self!.screenSize.height
                                                - self!.screenSize.height / 4,
                                             width: self!.screenSize.width,
                                             height: self!.screenSize.height / 4)
        }
    }
    // panGesture
    @objc func bottomPangestureDidStart(_ gesture: UIPanGestureRecognizer) {
        let gestureY = gesture.translation(in: timeBottomSheet).y
        let calculatedY = preYValue - gestureY
        preYValue = gestureY
        if gesture.state == .changed {
            if timeBottomSheet.frame.minY >= (screenSize.height - screenSize.height / 4) {
                var finalCalculatedY = timeBottomSheet.frame.minY - calculatedY
                if finalCalculatedY < (screenSize.height - screenSize.height / 4) {
                    finalCalculatedY = screenSize.height - screenSize.height / 4
                }
                timeBottomSheet.frame = CGRect(x: 0,
                                           y: finalCalculatedY,
                                           width: screenSize.width,
                                           height: screenSize.height / 4)
            }
        } else if gesture.state == .ended {
            if gesture.velocity(in: timeBottomSheet).y < 0 {
                UIView.animate(withDuration: 0.1) { [weak self] in
                    self?.timeBottomSheet.frame = CGRect(x: 0,
                                                     y: self!.screenSize.height
                                                        - self!.screenSize.height / 4,
                                                     width: self!.screenSize.width,
                                                     height: self!.screenSize.height / 4)
                }
            } else {
                UIView.animate(withDuration: 0.15) { [weak self] in
                    self?.timeBottomSheet.frame = CGRect(x: 0,
                                                     y: self!.screenSize.height,
                                                     width: self!.screenSize.width,
                                                     height: self!.screenSize.height / 4)
                }
            }
        }
    }
    @objc func backButtonDipTap2() {
        //뒤로가기
        //present 일때만 dismiss 이다
        self.dismiss(animated: false)
    }
}

