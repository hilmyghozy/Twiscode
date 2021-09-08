//
//  ModalCartVC.swift
//  Twistcode
//
//  Created by hilmy ghozy on 08/09/21.
//

import UIKit

protocol ModalExitCartVCDelegate: AnyObject {
    func didTapOrderButton()
}

class ModalCartVC: UIViewController {

    @IBOutlet var totalPrice: UILabel!
    @IBOutlet var order: UIButton!
    
    var totalPrices = Float()
    var delegate: ModalExitCartVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalPrice.text = "\(totalPrices)"
        order.cornerRadiuss = 20
    }

    @IBAction func didTapOrderButton(_ sender: Any) {
        print("ohyes")
    }
}
