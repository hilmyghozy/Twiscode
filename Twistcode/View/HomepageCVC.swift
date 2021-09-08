//
//  HomepageCVC.swift
//  Twistcode
//
//  Created by hilmy ghozy on 06/09/21.
//

import UIKit

class HomepageCVC: UICollectionViewCell {
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var userAddress: UILabel!
    @IBOutlet var user: UILabel!
    @IBOutlet var stockCount: UILabel!
    @IBOutlet var halalImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 15
        layer.masksToBounds = false
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
        
        stockCount.layer.masksToBounds = true
        stockCount.layer.cornerRadius = 10
        
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            layer.shadowPath = UIBezierPath(
                roundedRect: bounds,
                cornerRadius: 15
            ).cgPath
        }
    
}

