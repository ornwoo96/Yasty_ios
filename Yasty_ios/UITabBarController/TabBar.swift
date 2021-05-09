//
//  TabBarViewController.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/05/09.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance ().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
        
    }
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                    image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = image
        navController.isNavigationBarHidden = true
        return navController
      }
    func setupVCs() {
            viewControllers = [
                createNavController(for: ViewController(), image: UIImage(systemName: "magnifyingglass")!),
                createNavController(for: FSMResultMapView(), image: UIImage(systemName: "heart.circle")!),
                createNavController(for: ViewController(), image: UIImage(systemName: "gearshape")!)
            ]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
