//
//  ActualEnd.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/26.
//

import Foundation

struct ActualEnd: Codable {
    let coordinates: [Double]
    enum CodingKeys: String, CodingKey {
        case coordinates
    }
}
