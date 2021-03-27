//
//  RegionInfo.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/03/28.
//

import Foundation

struct RegionInfo: Codable {
    let region: [String]?
    let keyword: String?
    let selectedRegion: String?
    
    enum CodingKeys: String, CodingKey {
        case selectedRegion = "selected_region"
        case region, keyword
    }
}
