//
//  SettingView.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/05/11.
//

import UIKit

class SettingView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    let tableView = UITableView()
    
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for x in 0...10 {
            data.append("메뉴 구성 중 \(x)")
        }
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("cell tapped")
    }
}
