//
//  ViewController.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/03/25.
//

import UIKit
import Then
import NMapsMap
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    //위치 매니저 변수
    var locationManager: CLLocationManager!
    
    
    
    
    //let mapView2 = NMFMapView()
    let searchTextField = UITextField()
    let paddingView = UIView()
    let mapView = NMFNaverMapView()
    let freeButton = UIButton()
    let mapView2 = NMFMapView()
    
    //위도와 경도
    var latitude: Double?
    var longitude: Double?
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        myLocation()
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() // when in use auth로 요청 등록
        
        let coor = locationManager.location?.coordinate
        latitude = coor?.latitude
        longitude = coor?.longitude
                
    }
    // state
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            break
        case .restricted, .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("qkqh")
        @unknown default:
            return
        }
    }
    
    func myLocation() {
        mapView.do {
            $0.showCompass = true
            $0.showCompass = true
            $0.showScaleBar = true
            $0.showLocationButton = true
            $0.showIndoorLevelPicker = true
        }
    }
    
    func attribute() {
        paddingView.do {
            $0.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        }
        searchTextField.do {
            $0.backgroundColor = .white
            $0.textColor = .black
            
            //라운드
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            
            //테두리 (음영처리는 추가적으로)
            $0.layer.borderWidth = 0.5
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.placeholder = "맛집 키워드 검색 예) 냉면..."
            
            //레프트 뷰
            $0.leftView = paddingView
            $0.leftViewMode = .always
            $0.delegate = self
        }
        freeButton.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 10
            $0.tintColor = .black
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            $0.addTarget(self, action: #selector(freeButtonDipTap), for: .touchUpInside)
        }
    
        
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
        
        searchTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            //위
            //세이프에이리어 개념
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            //왼쪽
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
            //오른쪽
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
            //높이
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        freeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: searchTextField.centerXAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        }
    }
    @objc func freeButtonDipTap() {
        let searchResult = FSMResultMapView()
        self.present(searchResult, animated: true)
    }
}

extension ViewController: UITextFieldDelegate {
    //텍스트필드가 편집이 되기 시작했다
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // 맵서치뷰컨트롤러로 보내버리기
        // 다음으로 갈 뷰컨 객체
        let mapSearchVC = MapSearchViewController()
        // 뷰컨 객체의 모달 스타일 정의
        mapSearchVC.modalPresentationStyle = .fullScreen
        // 프레젠트
        self.present(mapSearchVC, animated: false)
    }
}
