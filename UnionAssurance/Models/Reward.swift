//
//  Reward.swift
//  UnionAssurance
//
//  Created by Danushika Priyadarshani on 2022-11-23.
//

import Foundation

struct Reward: Codable {
    var id: String
    var title: String?
    var sub_title: String?
    var is_completed: Bool?
    var expire_date: String?
    var image: String?
    var imageURL: URL? {
        get {
            return URL(string: image ?? "")
        }
    }
}
