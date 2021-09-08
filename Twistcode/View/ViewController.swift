//
//  ViewController.swift
//  Twistcode
//
//  Created by hilmy ghozy on 06/09/21.
//

import Foundation
import UIKit
import SDWebImage
import TTGSnackbar

class ViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    fileprivate var cart = Cart()
    
    var arrItem: [ItemsModel] = []
    var countArr: Array<ItemsModel> = Array()
    let presenter: HomePresenter = HomePresenter()
    var countingCart = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.showActivityIndicator()
        self.presenter.doGetAllItem()
        
        uiSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        
        cart.updateCart()
        self.navigationItem.rightBarButtonItem?.title = "Checkout (\(cart.items.count))"
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCart" {
            if let cartViewController = segue.destination as? ShopingCartVC {
                cartViewController.cart = self.cart
            }
        }
    }
    
    func uiSetup(){
        navigationController?.navigationBar.barTintColor = UIColor.green
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        
        
        let width = view.frame.width
        let logoContainer = UIView(frame: CGRect(x: 0 ,y: 0, width: width, height: 40))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "twiscode")
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: screenWidth/2.2, height: screenHeight/3)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 15
        collectionView!.collectionViewLayout = layout
        collectionView!.register(HomepageCVC.self, forCellWithReuseIdentifier: "CollectionViewCell")
        self.view.addSubview(collectionView!)
    }
    
    @IBAction func cartClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ShopingCartVC") as? ShopingCartVC{
            
            vc.itemsOrder = countArr
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrItem.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomepageCVC
        
        let items = self.arrItem[indexPath.row]
        
        if items.default_photo!.img_path! != "" {
            let img = "\(items.default_photo!.img_path!)"
            var urlString = img.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            let imgUrl = "https://ranting.twisdev.com/uploads/\(urlString!)"
            cell.productImg.sd_setImage(with: URL.init(string: imgUrl), completed: nil)
        }else{
            cell.productImg.image = UIImage(named: "logo")
        }
        if items.is_halal == "1" {
            cell.halalImg.isHidden = false
            cell.halalImg.image = UIImage(named: "halal")
        }else{
            cell.halalImg.isHidden = true
        }
        
        if items.stock! == "0" || items.stock! == "" {
            cell.stockCount.text = "Stok habis"
            cell.stockCount.backgroundColor = UIColor.gray
            cell.stockCount.textColor = UIColor.white
        }else{
            cell.stockCount.text = "Stok tersedia"
            cell.stockCount.backgroundColor = UIColor.systemBlue
            cell.stockCount.textColor = UIColor.white
        }
        cell.productName.text = items.title
        cell.productPrice.text = "Rp \(items.price!)"
        cell.user.text = items.added_user_name
        cell.userAddress.text = items.address

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomepageCVC

        let items = self.arrItem[indexPath.row]

//        if items.stock! == "0" || items.stock! == "" {
//            showSnackbar(message: "Oops... Stock Habis.", isSuccess: false)
//        }else{
            showSnackbar(message: "Pesanan berhasil ditambahkan.", isSuccess: true)
            cart.updateCart(with: items)
            self.navigationItem.rightBarButtonItem?.title = "Checkout (\(cart.items.count))"
//        }
    }
}


extension ViewController: HomeDelegate {
    func didSuccessGetItems() {
        self.hideActivityIndicator()
        if let data = self.presenter.responseItems{
            self.arrItem = data
        }
        self.collectionView.reloadData()
    }
    
    func didFailedGetItems(errorMessage: String) {
        self.hideActivityIndicator()
        showSnackbar(message: "Oops... Network bermasalah.", isSuccess: false)
        print(errorMessage)
    }
}

extension UIView {
    var cornerRadiuss: CGFloat {
        get { return self.cornerRadiuss}
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

func showSnackbar(message: String, isSuccess: Bool = true) {
   
    let snackbar = TTGSnackbar(
        message: message,
        duration: .middle,
        actionText: "",
        actionBlock: { (snackbar) in
            snackbar.dismiss()
        }
    )
    
    snackbar.leftMargin = 15
    snackbar.rightMargin = 15
    snackbar.topMargin = 60
    snackbar.animationType = .slideFromTopBackToTop
    snackbar.messageTextColor = .black
    snackbar.actionIcon = UIImage.init(named: "x")
    snackbar.separateViewBackgroundColor = UIColor.clear
    snackbar.layer.shadowColor = UIColor.clear.cgColor
    snackbar.backgroundColor = isSuccess ? UIColor.init(named: "lightGreen") : UIColor.init(named: "lightRed")
    snackbar.layer.cornerRadius = 5.0
    snackbar.show()
}
