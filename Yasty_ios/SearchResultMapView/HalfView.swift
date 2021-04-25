//
//  HalfView.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/19.
//

import Foundation
import UIKit
import PanModal


class HalfView: UIViewController {
    let paddingView = UIView()
    let freeButton = UIButton()
    
    
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
    @objc func freeButtonDipTap() {
        // 알림 경고창 띄우기
        let alert = UIAlertController(title: "길찾기 기능",message: "길찾기 기능",preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in }
        alert.addAction(okAction)
        present(alert, animated: false, completion: nil)
        //
        let searchResult = FSMResultMapView()
        self.present(searchResult, animated: true)
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
