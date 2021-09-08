//
//  ResponseApi.swift
//  Twistcode
//
//  Created by hilmy ghozy on 06/09/21.
//

import Foundation

struct ItemsModel: Codable, Equatable {
    
    let id: String?
    let cat_id: String?
    let sub_cat_id: String?
    let description: String?
    let title: String?
    let is_sold_out: String?
    let address: String?
    let location_name: String?
    let location_type: String?
    let is_food: String?
    let is_halal: String?
    let stock: String?
    let added_user_name: String
    let price: String?
    let default_photo: ItemPhoto?
    
    enum CodingKeys: String, CodingKey {
        case id, cat_id, sub_cat_id, description, title, is_sold_out, address, location_name, location_type, is_food, is_halal, stock, added_user_name, price, default_photo
    }
}

struct ItemPhoto: Codable {
    let img_path: String?
}

extension ItemsModel {
    static func ==(lhs: ItemsModel, rhs: ItemsModel) -> Bool {
        return lhs.id == rhs.id && lhs.price == rhs.price
    }
    
    func displayPrice() -> String {
        return String.init(format: "Rp %.03f@", price!)
    }
}

