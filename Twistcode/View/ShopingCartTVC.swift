//
//  ShopingCartTVC.swift
//  Twistcode
//
//  Created by hilmy ghozy on 07/09/21.
//

import UIKit
import FloatingPanel

protocol CartItemDelegate {
    func updateCartItem(cell: ShopingCartTVC, quantity: Int)
}

class ShopingCartTVC: UITableViewCell {

    @IBOutlet var imageItem: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var plusBtn: UIButton!
    @IBOutlet var countItem: UILabel!
    @IBOutlet var minusBtn: UIButton!
    
    var delegate: CartItemDelegate?
    var quantity: Int = 1
//    
//    var incClicked: (() -> Void)? = nil
//    var decClicked: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func updateCartItemQuantity(_ sender: Any) {
        if (sender as! UIButton).tag == 0 {
            quantity = quantity + 1
        } else if quantity > 0 {
            quantity = quantity - 1
        }
        
        minusBtn.isEnabled = quantity > 0
        minusBtn.alpha = !minusBtn.isEnabled ? 0.5 : 1
        
        self.countItem.text = String(describing: quantity)
        self.delegate?.updateCartItem(cell: self, quantity: quantity)
    }
}
