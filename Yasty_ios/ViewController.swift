//
//  ViewController.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/03/25.
//

import UIKit
import Then
import NMapsMap


class ViewController: UIViewController {
    
    let mapView = NMFMapView()
    let searchTextField = UITextField()
    
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //mapView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.addSubview(mapView)
        mapView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        
        
    }


}

extension ViewController: NMFMapViewCameraDelegate {
    
}

