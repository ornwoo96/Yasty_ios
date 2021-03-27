//
//  Documents.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/03/28.
//

import Foundation

struct Documents: Codable {
    let id: String?
    let placeName: String?
    let categoryName: String?
    let categoryGroupCode: String?
    let categoryGroupName: String?
    let phone: String?
    let addressName: String?
    let roadAddressName: String?
    let x: String?
    let y: String?
    let placeURL: String?
    let distance: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case placeName = "place_name"
        case categoryName = "category_name"
        case categoryGroupCode = "category_group_code"
        case categoryGroupName = "category_group_name"
        case phone = "phone"
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case placeURL = "place_url"
        case x, y, distance
    }
}
