//
//  MapSearchDataManager.swift
//  Yasty_ios
//
//  Created by 김동우 on 2021/03/28.
//

import Foundation
import Alamofire
import SwiftyJSON

class MapSearchDataManager {
    let kakaoURL = "https://dapi.kakao.com/v2/local/search/keyword.json"
    
    
    func postKakaoKeywordAPI(keyword: String, completion: @escaping ([TempKeywordResult]) -> Void ) {
        // 진짜 url이냐?
        guard let url = URL(string: kakaoURL) else { return }
        //헤더만들고
        let headers = HTTPHeaders(["Authorization": "KakaoAK 762a3af136ad539130b57950c6dc7772"])
        //파라미터 만들고(파라미터는 필요한게 있으면 계속해서 추가 - 사용자위치)
        let parameters: Parameters = ["query": keyword, "category_group_code": "FD6"]
        //뷰로보내주기전 미리만든 빈배열
        var keywordResult: [TempKeywordResult] = []
        
        
        //쏜다
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    // 성공일 때 일로 들어와서
                    let json = JSON(data)
                    // 배열이야
                    let resultList = json["documents"]
                    for i in 0..<resultList.count {
                        let resultItem = TempKeywordResult(name: resultList[i]["place_name"].string ?? "",
                                                           x: Double(resultList[i]["x"].string ?? "") ?? 0.0,
                                                           y: Double(resultList[i]["y"].string ?? "") ?? 0.0)
                        if resultItem.name.isEmpty {
                    // 비어있음
                        } else {
                            keywordResult.append(resultItem)
                        }
                    }
                    completion(keywordResult)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
