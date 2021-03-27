//
//  KeywordResultMeta.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/03/28.
//

import Foundation

struct KeywordResultMeta: Codable {
    let totalCount: Int?
    let pageableCount: Int?
    let isEnd: Bool?
    let sameName: RegionInfo?
    
    enum Codingkeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
        case sameName = "same_name"
    }
}
