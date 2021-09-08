//
//  CartItem.swift
//  Twistcode
//
//  Created by hilmy ghozy on 08/09/21.
//

import Foundation

class CartItem {
    
    var quantity : Int = 1
    var product : ItemsModel
    
    var subTotal : Float { get { return product.price!.floatValue * Float(quantity) } }
    
    init(product: ItemsModel) {
        self.product = product
    }
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
