//
//  ShopingCartVC.swift
//  Twistcode
//
//  Created by hilmy ghozy on 07/09/21.
//

import UIKit
import FloatingPanel

class ShopingCartVC: BaseViewController, FloatingPanelControllerDelegate, ModalExitCartVCDelegate {

    @IBOutlet var tableView: UITableView!
    
    var itemsOrder: Array<ItemsModel> = Array()
    var cart: Cart? = nil
    var quotes : [(key: String, value: Float)] = []
    
    var fpc: FloatingPanelController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.cart!.totalQuantity > 0{
            self.fpc = FloatingPanelController()
            self.fpc.layout = orderFloatingLayout()
            self.fpc.delegate = self

            let story = UIStoryboard(name: "Main", bundle:nil)
            let modalVC = story.instantiateViewController(withIdentifier: "ModalCartVC") as? ModalCartVC
            modalVC?.delegate = self
            modalVC?.totalPrices = Float(self.cart!.total.description)!
            self.fpc.set(contentViewController: modalVC)
            
            self.fpc.isRemovalInteractionEnabled = false
            self.fpc.panGestureRecognizer.isEnabled = false
            self.fpc.contentMode = .fitToBounds
            self.fpc.backdropView.dismissalTapGestureRecognizer.isEnabled = false
            
            let appearance = SurfaceAppearance()
            appearance.cornerRadius = 24
            self.fpc.surfaceView.appearance = appearance
            self.fpc.addPanel(toParent: self)
        }
    }
    
    func didTapOrderButton() {
        print("yes")
    }

}

extension ShopingCartVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (cart?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShopingCartTVC
        let items = cart?.items[indexPath.row]
        cell.delegate = self as CartItemDelegate
        
        if items?.product.default_photo!.img_path! != "" {
            let img = "\((items?.product.default_photo!.img_path!)!)"
            var urlString = img.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let imgUrl = "https://ranting.twisdev.com/uploads/\(urlString!)"
            cell.imageItem.sd_setImage(with: URL.init(string: imgUrl), completed: nil)
        }else{
            cell.imageItem.image = UIImage(named: "logo")
        }

        cell.title.text = items?.product.title
        cell.price.text = items?.product.displayPrice()
        cell.countItem.text = "\((items?.quantity)!)"
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99.0
    }
}

extension ShopingCartVC: CartItemDelegate {
    func updateCartItem(cell: ShopingCartTVC, quantity: Int) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        guard let cartItem = cart?.items[indexPath.row] else { return }

        cartItem.quantity = quantity
        guard let total = cart?.total else { return }
        
        self.fpc = FloatingPanelController()
        self.fpc.layout = orderFloatingLayout()
        self.fpc.delegate = self

        let story = UIStoryboard(name: "Main", bundle:nil)
        let modalVC = story.instantiateViewController(withIdentifier: "ModalCartVC") as? ModalCartVC
        modalVC?.delegate = self
        modalVC?.totalPrices = total
        self.fpc.set(contentViewController: modalVC)
        
        self.fpc.isRemovalInteractionEnabled = false
        self.fpc.panGestureRecognizer.isEnabled = false
        self.fpc.contentMode = .fitToBounds
        self.fpc.backdropView.dismissalTapGestureRecognizer.isEnabled = false
        
        let appearance = SurfaceAppearance()
        appearance.cornerRadius = 24
        self.fpc.surfaceView.appearance = appearance
        self.fpc.addPanel(toParent: self)
    }
    
    
}

class orderFloatingLayout: FloatingPanelLayout {
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    
    var anchors: [FloatingPanelState: FloatingPanelLayoutAnchoring] {
        return [
            .half: FloatingPanelLayoutAnchor(fractionalInset: 100 / UIScreen.main.bounds.size.height, edge: .bottom, referenceGuide: .safeArea)
        ]
    }
}
