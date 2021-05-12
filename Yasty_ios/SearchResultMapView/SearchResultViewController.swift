//
//  SearchResultViewController.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/02.
//

import UIKit
import NMapsMap
import PanModal
import CoreLocation

class SearchResultViewController: UIViewController, CLLocationManagerDelegate {
    let mapView = NMFMapView()
    var receiveList: [TempKeywordResult]?
    var selectedIndex: Int = 0
    let infoWindow = NMFInfoWindow()
    let defaultDataSource = NMFInfoWindowDefaultTextSource.data()
    let backButton = UIButton()
    let newView = UIView()
    var dataManager = GetPath()
    var locationManager: CLLocationManager!
        
    //위도와 경도
    var latitude: Double?
    var longitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        // 현 위치 위도 경도 설정
        let coor = locationManager?.location?.coordinate
        latitude = coor?.latitude
        longitude = coor?.longitude
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // when in use auth로 요청 등록
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // 타이밍 이슈 해결
        // 뷰컨트롤러 라이프사이클 매우 중요
        searchResultMarker()
    }
    
    func getPath(_ targetLat: Double,
                 _ targetLong: Double) {
        dataManager.getPath(latitude ?? 0.0,
                            longitude ?? 0.0,
                            targetLat,
                            targetLong) { result in
            let tempVC = WalkingRouteView()
            tempVC.tempPathOverlay = result
        }
    }
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        infoWindow.close()
    }

    func searchResultMarker() {
        self.moveCamera(self.selectedIndex)
        
        for i in 0..<receiveList!.count {
            let marker = NMFMarker(
                position: NMGLatLng(lat: receiveList![i].y,
                                    lng: receiveList![i].x))
            marker.mapView = mapView
            marker.userInfo.updateValue(receiveList![i].y, forKey: "lat")
            marker.userInfo.updateValue(receiveList![i].x, forKey: "lng")
            let infoWindow = NMFInfoWindow()
            let dataSource = NMFInfoWindowDefaultTextSource.data()
            dataSource.title = receiveList![i].name
            infoWindow.dataSource = dataSource
            
            // 마커를 탭하면:
            let handler = { (overlay: NMFOverlay) -> Bool in
                if let marker = overlay as? NMFMarker {
                    if marker.infoWindow == nil {
                        // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                        infoWindow.open(with: marker)
                        // 해당 마커 클릭시 카메라가 마커좌표로 이동
                        self.moveCamera(i)
                        
                        // 루트 경로 데이터 보내기
                        let coor = self.locationManager?.location?.coordinate
                        self.latitude = coor?.latitude
                        self.longitude = coor?.longitude
                        
                        self.getPath(marker.userInfo["lat"] as! Double,
                                     marker.userInfo["lng"] as! Double)
                        
                        let halfView = HalfView()
                        // 여기서 값을 넘겨줘야됩
                        halfView.startLat = self.latitude ?? 0.0
                        halfView.startLng = self.longitude ?? 0.0
                        halfView.endLat = marker.userInfo["lat"] as! Double
                        halfView.endLng = marker.userInfo["lng"] as! Double
                        
                        self.presentPanModal(halfView)
                    } else {
                        // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                        infoWindow.close()
                    }
                }
                return true
            }
            marker.touchHandler = handler
        }
    }
    
    func moveCamera(_ index: Int) {
        let cameraUpdate = NMFCameraUpdate(
            scrollTo: NMGLatLng(lat: self.receiveList![index].y,
                                lng: self.receiveList![index].x))
        self.mapView.moveCamera(cameraUpdate)
    }
    
    func attribute() {
        mapView.moveCamera(
            NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: receiveList![0].y,lng: receiveList![0].x), zoom: 14)))
        backButton.do {
            $0.tintColor = .black
            $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
            $0.addTarget(self, action: #selector(backButtonDipTap), for: .touchUpInside)
        }
    }
    
    func layout() {
        [mapView, backButton].forEach { view.addSubview($0) }
        
        mapView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        backButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    
    @objc func backButtonDipTap() {
        //뒤로가기
        //present 일때만 dismiss 이다
        self.dismiss(animated: false)
    }
}
