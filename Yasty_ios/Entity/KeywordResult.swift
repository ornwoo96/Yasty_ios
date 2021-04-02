//
//  KeywordResult.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/03/28.
//

import Foundation

struct KeywordResult: Codable {
    let meta: KeywordResultMeta?
    let documents: Documents?
    
    enum CondingKeys: String, CodingKey {
        case meta
        case documents = "documents"
    }
}


