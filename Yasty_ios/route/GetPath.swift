//
//  json.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/04/24.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetPath {
    func getPath(_ startX: Double,
                 _ startY: Double,
                 _ endX: Double,
                 _ endY: Double,
                 completion: @escaping ([[Double]]) -> Void) {
        
        //URL을 만든다.
        let base_URL = "https://dev.virtualearth.net/REST/V1/Routes/Walking"
        guard let url = URL(string: base_URL) else { return }
        
        // Parameters을 만든다.
        let params: Parameters = [
            "wp.0": "\(startX),\(startY)",
            "wp.1": "\(endX),\(endY)",
            "optmz": "distance",
            "key": "Ajs4IC6-jD0nVO3hDcsTywjl6wCfxRx-QEPoTV56Yj-0jSpcQHLxDiOYVCbv56ZU"
        ]
        
        AF.request(url, parameters: params)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(LocationPathResult.self, from: data)
                        let ressources = result.resourceSets[0]
                        let routeLegs = ressources.resources[0].routeLegs[0]
                        let itineraryItems = routeLegs.itineraryItems
                        var pathValue: [[Double]] = []
                        itineraryItems.forEach {
                            pathValue.append($0.maneuverPoint.coordinates)
                        }
                        completion(pathValue)
                    } catch {
                        print("실패다이새기야")
                    }
                case .failure(let err):
                    print(err)
                }
            }
    }
}
