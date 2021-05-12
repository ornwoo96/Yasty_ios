//
//  HomeController.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/05/09.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - Properties
    
    var delegate: HomeControllerDelegate?
        
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
//        configureNavigationBar()
        
    }
    
    // MARK: - Handlers
    
    @objc func handleMenuToggle() {
        delegate?.handleMenuToggle()
        print("Toggle menu...")
    }
    
//    func configureNavigationBar() {
//        navigationController?.navigationBar.barTintColor = .darkGray
//        navigationController?.navigationBar.barStyle = .black
//
//        navigationItem.title = "Side Menu"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: "house", style: .plain, target: self, action: #selector(handleMenuToggle))
//    }
}
