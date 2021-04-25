//
//  RealmFSMData.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/10.
//

import UIKit
import Realm
import RealmSwift

class FreeData: Object {
    @objc dynamic var FSMname: String = ""
    @objc dynamic var xComa: Double = 0.0
    @objc dynamic var yComa: Double = 0.0
    
}
class RealmFSMDataController: UIViewController {
    
    func addData(FSMname: String, xComa: Double, yComa: Double) {
        
        let freeData = FreeData()
        freeData.FSMname = FSMname
        freeData.xComa = xComa
        freeData.yComa = yComa
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(freeData)
        }
        print("Success")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addData(FSMname: "안나의 집", xComa: 37.42851, yComa: 127.13236)
        addData(FSMname: "관악산 무료급식소", xComa: 37.46854, yComa: 126.94492)
        
        print(NSHomeDirectory())
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}


