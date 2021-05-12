//
//  FSMResultMapView.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/11.
//

import UIKit
import NMapsMap
import Realm
import RealmSwift

class FSMResultMapView: UIViewController {
    let mapView2 = NMFNaverMapView()
    let mapView = NMFMapView()
    let infoWindow = NMFInfoWindow()
    let defaultDataSource = NMFInfoWindowDefaultTextSource.data()
    let backButton = UIButton()
    let marker = NMFMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        markers()
    }
    
    
    func markers() {
        
        // 안나의 집
        let infoWindow1 = NMFInfoWindow()
        let dataSource1 = NMFInfoWindowDefaultTextSource.data()
        dataSource1.title = "안나의 집"
        infoWindow1.dataSource = dataSource1
        let marker1 = NMFMarker()
        marker1.iconTintColor = UIColor.blue
        marker1.position = NMGLatLng(lat: 37.42849, lng: 127.13238)
        marker1.mapView = mapView
//        infoWindow1.open(with: marker1)
//        infoWindow1.close()
        
        // 관악산 무료급식소
        let infoWindow2 = NMFInfoWindow()
        let dataSource2 = NMFInfoWindowDefaultTextSource.data()
        dataSource2.title = "관악산 무료급식소"
        infoWindow2.dataSource = dataSource2
        let marker2 = NMFMarker()
        marker2.iconTintColor = UIColor.blue
        marker2.position = NMGLatLng(lat: 37.46829, lng: 126.94488)
        marker2.mapView = mapView
//        infoWindow2.open(with: marker2)
        
        // 동대문구 장애인 무료 급식소
        let infoWindow3 = NMFInfoWindow()
        let dataSource3 = NMFInfoWindowDefaultTextSource.data()
        dataSource3.title = "동대문구 장애인 무료 급식소"
        infoWindow3.dataSource = dataSource3
        let marker3 = NMFMarker()
        marker3.iconTintColor = UIColor.blue
        marker3.position = NMGLatLng(lat: 37.57212, lng: 127.03495)
        marker3.mapView = mapView

        // 천사무료급식소
        let infoWindow4 = NMFInfoWindow()
        let dataSource4 = NMFInfoWindowDefaultTextSource.data()
        dataSource4.title = "천사무료급식소"
        infoWindow4.dataSource = dataSource4
        let marker4 = NMFMarker()
        marker4.iconTintColor = UIColor.blue
        marker4.position = NMGLatLng(lat: 37.57016, lng: 126.99396)
        marker4.mapView = mapView

        // 탑골공원 원각사 무료급식소
        let infoWindow5 = NMFInfoWindow()
        let dataSource5 = NMFInfoWindowDefaultTextSource.data()
        dataSource5.title = "탑골공원 원각사 무료급식소"
        infoWindow5.dataSource = dataSource5
        let marker5 = NMFMarker()
        marker5.iconTintColor = UIColor.blue
        marker5.position = NMGLatLng(lat: 37.57194, lng: 126.98843)
        marker5.mapView = mapView

        // 백련자비원 무료급식소
        let infoWindow6 = NMFInfoWindow()
        let dataSource6 = NMFInfoWindowDefaultTextSource.data()
        dataSource6.title = "백련자비원 무료급식소"
        infoWindow6.dataSource = dataSource6
        let marker6 = NMFMarker()
        marker6.iconTintColor = UIColor.blue
        marker6.position = NMGLatLng(lat: 37.57741, lng: 126.92394)
        marker6.mapView = mapView

        // 무료급식소 보릿고개
        let infoWindow7 = NMFInfoWindow()
        let dataSource7 = NMFInfoWindowDefaultTextSource.data()
        dataSource7.title = "무료급식소 보릿고개"
        infoWindow7.dataSource = dataSource7
        let marker7 = NMFMarker()
        marker7.iconTintColor = UIColor.blue
        marker7.position = NMGLatLng(lat: 37.55967, lng: 126.90601)
        marker7.mapView = mapView

        // 곰돌이 무료급식소
        let infoWindow8 = NMFInfoWindow()
        let dataSource8 = NMFInfoWindowDefaultTextSource.data()
        dataSource8.title = "곰돌이 무료급식소"
        infoWindow8.dataSource = dataSource8
        let marker8 = NMFMarker()
        marker8.iconTintColor = UIColor.blue
        marker8.position = NMGLatLng(lat: 37.49964, lng: 126.85074)
        marker8.mapView = mapView

        // 전국천사무료급식소
        let infoWindow9 = NMFInfoWindow()
        let dataSource9 = NMFInfoWindowDefaultTextSource.data()
        dataSource9.title = "전국천사무료급식소"
        infoWindow9.dataSource = dataSource9
        let marker9 = NMFMarker()
        marker9.iconTintColor = UIColor.blue
        marker9.position = NMGLatLng(lat: 37.52106, lng: 126.85200)
        marker9.mapView = mapView

        // 전국천사무료급식소 영등포구
        let infoWindow10 = NMFInfoWindow()
        let dataSource10 = NMFInfoWindowDefaultTextSource.data()
        dataSource10.title = "전국천사무료급식소 영등포구"
        infoWindow10.dataSource = dataSource10
        let marker10 = NMFMarker()
        marker10.iconTintColor = UIColor.blue
        marker10.position = NMGLatLng(lat: 37.49755, lng: 126.91715)
        marker10.mapView = mapView
        
//        let arrayList = [1,2,3,4,5,6,7,8,9,10]
//
//        for i in 0...9 {
//            let info = "infoWindow"
//            let ifw = info + String(arrayList[i])
//
//
//        }
        


        
        // 마커를 탭하면:
        
        let handler1 = { (overlay: NMFOverlay) -> Bool in
            if let marker1 = overlay as? NMFMarker {
                if marker1.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                    print("열어주는 클릭")
                    infoWindow1.open(with: marker1)
                } else {
                    // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                    print("닫아주는 클릭")
                    infoWindow1.close()
                }
            }
            return true
        };
        let handler2 = { (overlay: NMFOverlay) -> Bool in
            if let marker2 = overlay as? NMFMarker {
                if marker2.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                    print("열어주는 클릭")
                    infoWindow2.open(with: marker2)
                } else {
                    // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                    print("닫아주는 클릭")
                    infoWindow2.close()
                }
            }
            return true
        };
        let handler3 = { (overlay: NMFOverlay) -> Bool in
            if let marker3 = overlay as? NMFMarker {
                if marker3.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                    print("열어주는 클릭")
                    infoWindow3.open(with: marker3)
                } else {
                    // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                    print("닫아주는 클릭")
                    infoWindow3.close()
                }
            }
            return true
        };
        let handler4 = { (overlay: NMFOverlay) -> Bool in
            if let marker4 = overlay as? NMFMarker {
                if marker4.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                    print("열어주는 클릭")
                    infoWindow4.open(with: marker4)
                } else {
                    // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                    print("닫아주는 클릭")
                    infoWindow4.close()
                }
            }
            return true
        };
        let handler5 = { (overlay: NMFOverlay) -> Bool in
            if let marker5 = overlay as? NMFMarker {
                if marker5.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                    print("열어주는 클릭")
                    infoWindow5.open(with: marker5)
                } else {
                    // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                    print("닫아주는 클릭")
                    infoWindow5.close()
                }
            }
            return true
        };
        let handler6 = { (overlay: NMFOverlay) -> Bool in
            if let marker6 = overlay as? NMFMarker {
                if marker6.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                    print("열어주는 클릭")
                    infoWindow6.open(with: marker6)
                } else {
                    // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                    print("닫아주는 클릭")
                    infoWindow6.close()
                }
            }
            return true
        };
        let handler7 = { (overlay: NMFOverlay) -> Bool in
            if let marker7 = overlay as? NMFMarker {
                if marker7.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                    print("열어주는 클릭")
                    infoWindow7.open(with: marker7)
                } else {
                    // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                    print("닫아주는 클릭")
                    infoWindow7.close()
                }
            }
            return true
        };
        let handler8 = { (overlay: NMFOverlay) -> Bool in
            if let marker8 = overlay as? NMFMarker {
                if marker8.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                    print("열어주는 클릭")
                    infoWindow8.open(with: marker8)
                } else {
                    // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                    print("닫아주는 클릭")
                    infoWindow8.close()
                }
            }
            return true
        };
        let handler9 = { (overlay: NMFOverlay) -> Bool in
            if let marker9 = overlay as? NMFMarker {
                if marker9.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                    print("열어주는 클릭")
                    infoWindow9.open(with: marker9)
                } else {
                    // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                    print("닫아주는 클릭")
                    infoWindow9.close()
                }
            }
            return true
        };
        let handler10 = { (overlay: NMFOverlay) -> Bool in
            if let marker10 = overlay as? NMFMarker {
                if marker10.infoWindow == nil {
                    // 현재 마커에 정보 창이 열려있지 않을 경우 엶
                    print("열어주는 클릭")
                    infoWindow10.open(with: marker10)
                } else {
                    // 이미 현재 마커에 정보 창이 열려있을 경우 닫음
                    print("닫아주는 클릭")
                    infoWindow10.close()
                }
            }
            return true
        };
        
        marker1.touchHandler = handler1
        marker2.touchHandler = handler2
        marker3.touchHandler = handler3
        marker4.touchHandler = handler4
        marker5.touchHandler = handler5
        marker6.touchHandler = handler6
        marker7.touchHandler = handler7
        marker8.touchHandler = handler8
        marker9.touchHandler = handler9
        marker10.touchHandler = handler10
        
//        let handler = { [weak self] (overlay: NMFOverlay) -> Bool in
//            if let marker = overlay as? NMFMarker {
//                // 정보 창이 열린 마커의 tag를 텍스트로 노출하도록 반환
//                self?.defaultDataSource.title = marker.userInfo["tag"] as! String
//                // 마커를 터치할 때 정보창을 엶
//                self?.infoWindow.open(with: marker)
//            }
//            return true
//        };
//        marker1.userInfo = ["tag": "마커 1"]
//        marker1.touchHandler = handler
//        marker2.userInfo = ["tag": "마커 2"]
//        marker2.touchHandler = handler
    }
    
    func attribute() {
        mapView.moveCamera(
            NMFCameraUpdate(position: NMFCameraPosition(NMGLatLng(lat: 37.52811, lng: 126.96977), zoom: 10)))
//        backButton.do {
//            $0.tintColor = .black
//            $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
//            $0.addTarget(self, action: #selector(backButtonDipTap), for: .touchUpInside)
//        }
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
//        backButton.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
//            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
//            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        }
    }
//    @objc func backButtonDipTap() {
//        self.dismiss(animated: false)
//    }
    @objc func infomation() {
        
    }
}

extension FSMResultMapView: UIImagePickerControllerDelegate {
    // 지도를 탭하면 정보 창을 닫음
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        infoWindow.close()
    }
}
