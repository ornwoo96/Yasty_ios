//
//  SearchResultViewController.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/02.
//

import UIKit
import NMapsMap
import PanModal

class SearchResultViewcontroller: UIViewController {
    let mapView = NMFMapView()
    var receiveList: [TempKeywordResult]?
    let infoWindow = NMFInfoWindow()
    let defaultDataSource = NMFInfoWindowDefaultTextSource.data()
    let backButton = UIButton()
    let newView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        searchResultMarker()
        
        
    }
    
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        infoWindow.close()
    }

    
    func searchResultMarker() {
        for i in 0..<receiveList!.count {
            let marker = NMFMarker(position: NMGLatLng(lat: receiveList![i].y, lng: receiveList![i].x))
            marker.mapView = mapView
            let infoWindow = NMFInfoWindow()
            let dataSource = NMFInfoWindowDefaultTextSource.data()
            dataSource.title = receiveList![i].name
            infoWindow.dataSource = dataSource
            infoWindow.close()
            
            // 마커를 탭하면:
            let handler = { (overlay: NMFOverlay) -> Bool in
                if let marker = overlay as? NMFMarker {
                    if marker.infoWindow == nil {
                        
                        // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                        infoWindow.open(with: marker)
                        // 해당 마커 클릭시 카메라가 마커좌표로 이동
                        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: self.receiveList![i].y, lng: self.receiveList![i].x))
                        self.mapView.moveCamera(cameraUpdate)
                        
                        // panmodal 사용
                        let halfView = HalfView()
                        self.presentPanModal(halfView)
                        

                        
                    } else {
                        // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                        infoWindow.close()
                    }
                }
                return true
            };
            marker.touchHandler = handler
        }
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


