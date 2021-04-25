//
//  ResourceSet.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/26.
//

import Foundation

struct ResourceSet: Codable {
    let estimatedTotal: Int
    let resources: [Resource]
}
