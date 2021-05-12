//
//  HalfView.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/19.
//

import Foundation
import UIKit
import PanModal
import CoreLocation

class HalfView: UIViewController {
    let paddingView = UIView()
    let freeButton = UIButton()
    var dataManager = GetPath()
    var startLat: Double = 0.0
    var startLng: Double = 0.0
    var endLat: Double = 0.0
    var endLng: Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        paddingView.do {
            $0.frame = CGRect(x: 100, y: 100, width: 10, height: 10)
        }
        freeButton.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 10
            $0.tintColor = .black
            $0.setImage(UIImage(systemName: "figure.walk"), for: .normal)
            $0.addTarget(self, action: #selector(freeButtonDipTap), for: .touchUpInside)
        }
    }
    func layout() {
        [ freeButton ].forEach {
            view.addSubview($0)
        }
        
        freeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    @objc func freeButtonDipTap() {
        //처음 좌표는 출발지
        //두번째 좌표는 도착지
        
        dataManager.getPath(startLat, startLng, endLat, endLng) { result in
            let tempVC = WalkingRouteView()
            tempVC.tempPathOverlay = result
            self.present(tempVC, animated: true)
            print(result)
        }
    }
}


extension HalfView: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    var shortFormHeight : PanModalHeight {
         return . contentHeight ( 300 )
    }

    var longFormHeight : PanModalHeight {
         return . maxHeightWithTopInset ( 40 )
    }
}
