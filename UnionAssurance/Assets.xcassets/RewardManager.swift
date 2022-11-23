//
//  RewardManager.swift
//  UnionAssurance
//
//  Created by Danushika Priyadarshani on 2022-11-23.
//

import UIKit
import Alamofire

class RewardManager {
    
    static func getRewards(completionHandler: @escaping (_ result:[Reward]?) -> Void) {
        
        AF.request(RewardService.GetRewards.rawValue, method: .get, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { (responseData) in switch responseData.result {
            
        case .success( _):
            if(responseData.data != nil)
            {
                do {
                    let decoder = JSONDecoder()
                    let onBoardingResponse = try decoder.decode([Reward].self, from:
                        responseData.data!)
                    print(onBoardingResponse)
                    completionHandler(onBoardingResponse)
                } catch let parsingError {
                    print("Error", parsingError)
                    completionHandler(nil)
                }
                
            }
            else
            {
                completionHandler(nil)
            }
            
        case .failure(let error):
            print(error.localizedDescription)
            completionHandler(nil)
            }
        }
    }
}
