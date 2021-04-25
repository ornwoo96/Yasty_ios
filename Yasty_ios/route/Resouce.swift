//
//  Resouce.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/26.
//

import Foundation

struct Resource: Codable {
    let routeLegs: [RouteLeg]

    enum CodingKeys: String, CodingKey {
        case routeLegs
    }
}
