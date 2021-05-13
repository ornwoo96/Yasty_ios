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
import Gifu
import SwiftUI


class ViewController: UIViewController, CLLocationManagerDelegate {
    //위치 매니저 변수
    var locationManager: CLLocationManager!
    var delegate: HomeControllerDelegate?
    let searchTextField = UITextField()
    let paddingView = UIView()
    let mapView = NMFNaverMapView()
    let mapView2 = NMFMapView()
    let sideButton = UIButton()
    let gifIamgeView = GIFImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    let bottomTempButton = UIButton()
    let bottomSheet = UIView()
    let indicatorBar = UIView()
    let indicatorBackgroundView = UIView()
    let screenSize = UIScreen.main.bounds
    var latitude: Double?
    var longitude: Double?
    lazy var bottomPangesture = UIPanGestureRecognizer(
        target: self, action: #selector(bottomPangestureDidStart))
    var preYValue: CGFloat = 0.0
    
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
            $0.placeholder = "맛집 키워드 검색"
            $0.layer.shadowColor = UIColor.gray.cgColor
            $0.layer.masksToBounds = false
            $0.layer.shadowOffset = CGSize(width: 0, height: 4)
            $0.layer.shadowRadius = 3
            $0.layer.shadowOpacity = 0.3
            
            //레프트 뷰
            $0.leftView = paddingView
            $0.leftViewMode = .always
            $0.delegate = self
        }
        sideButton.do {
            $0.tintColor = .gray
            $0.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
            $0.addTarget(self, action: #selector(handleMenuToggle), for: .touchUpInside)
        }
        bottomTempButton.do {
            $0.setTitle("바텀", for: .normal)
            $0.backgroundColor = .black
            $0.addTarget(self, action: #selector(tempButtonDidTap), for: .touchUpInside)
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
        bottomSheet.do {
            $0.layer.cornerRadius = 25
            $0.layer.masksToBounds = true
            $0.backgroundColor = .white
            $0.frame = CGRect(x: 0,
                              y: screenSize.height,
                              width: screenSize.width,
                              height: screenSize.height / 3)
        }
    }
    
    // MARK: - Handlers
    
    @objc func bottomPangestureDidStart(_ gesture: UIPanGestureRecognizer) {
        
        let gestureY = gesture.translation(in: bottomSheet).y
        let calculatedY = preYValue - gestureY
        preYValue = gestureY
        if gesture.state == .changed {
            if bottomSheet.frame.minY >= (screenSize.height - screenSize.height / 3) {
                var finalCalculatedY = bottomSheet.frame.minY - calculatedY
                if finalCalculatedY < (screenSize.height - screenSize.height / 3) {
                    finalCalculatedY = screenSize.height - screenSize.height / 3
                }
                bottomSheet.frame = CGRect(x: 0,
                                           y: finalCalculatedY,
                                           width: screenSize.width,
                                           height: screenSize.height / 3)
            }
        } else if gesture.state == .ended {
            if gesture.velocity(in: bottomSheet).y < 0 {
                UIView.animate(withDuration: 0.1) { [weak self] in
                    self?.bottomSheet.frame = CGRect(x: 0,
                                                     y: self!.screenSize.height
                                                        - self!.screenSize.height / 3,
                                                     width: self!.screenSize.width,
                                                     height: self!.screenSize.height / 3)
                }
            } else {
                UIView.animate(withDuration: 0.15) { [weak self] in
                    self?.bottomSheet.frame = CGRect(x: 0,
                                                     y: self!.screenSize.height,
                                                     width: self!.screenSize.width,
                                                     height: self!.screenSize.height / 3)
                }
            }
        }
    }
    
    @objc func tempButtonDidTap() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.bottomSheet.frame = CGRect(x: 0,
                                             y: self!.screenSize.height
                                                - self!.screenSize.height / 3,
                                             width: self!.screenSize.width,
                                             height: self!.screenSize.height / 3)
        }
    }
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle()
    }
    
    func layout() {
        [ mapView, searchTextField , sideButton, bottomTempButton, bottomSheet ].forEach {
            view.addSubview($0)
        }
        bottomSheet.addSubview(indicatorBar)
        bottomSheet.addSubview(indicatorBackgroundView)
        
        mapView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        
        searchTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: sideButton.trailingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        sideButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: searchTextField.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 40).isActive = true
        }
        bottomTempButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
            $0.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        indicatorBar.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: bottomSheet.topAnchor, constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: bottomSheet.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 10).isActive = true
        }
        indicatorBackgroundView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: bottomSheet.topAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: bottomSheet.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 100).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
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
