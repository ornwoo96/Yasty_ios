//
//  BingCodable.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/26.
//

import Foundation

struct LocationPathResult: Codable {
    let authenticationResultCode: String
    let brandLogoURI: String
    let copyright: String
    let resourceSets: [ResourceSet]
    let statusCode: Int
    let statusDescription, traceID: String

    enum CodingKeys: String, CodingKey {
        case authenticationResultCode
        case brandLogoURI = "brandLogoUri"
        case copyright, statusCode, statusDescription
        case resourceSets
        case traceID = "traceId"
    }
}

struct ResourceSet: Codable {
    let estimatedTotal: Int
    let resources: [Resource]
}

struct Resource: Codable {
    let routeLegs: [RouteLeg]

    enum CodingKeys: String, CodingKey {
        case routeLegs
    }
}

struct RouteLeg: Codable {
    let itineraryItems: [ItineraryItem]
}

struct ItineraryItem: Codable {
    let maneuverPoint: ActualEnd
    enum CodingKeys: String, CodingKey {
        case maneuverPoint
    }
}

struct ActualEnd: Codable {
    let coordinates: [Double]
    enum CodingKeys: String, CodingKey {
        case coordinates
    }
}
