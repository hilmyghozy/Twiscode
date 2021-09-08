//
//  ViewController.swift
//  Twiscode
//
//  Created by hilmy ghozy on 15/04/21.
//

import UIKit

protocol BaseViewControllerDelegate: AnyObject {
    func keyboardAppear(contentInset: UIEdgeInsets)
    func keyboarDissappear()
}

class BaseViewController: UIViewController {
    lazy var loadingIndicatorView: BaseActivityIndicatorView = {
        return BaseActivityIndicatorView.viewFromNib()
    }()
    
    weak var keyboardDelegate: BaseViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.title = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerKeyboardNotifications()
    }
    
    //MARK: KEYBOARD OBSERVER
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        self.keyboardDelegate?.keyboardAppear(contentInset: contentInsets)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.keyboardDelegate?.keyboarDissappear()
    }
    
    //MARK: - Activity Indicator
    func showActivityIndicator() {
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        loadingIndicatorView.frame = UIScreen.main.bounds
        window?.addSubview(loadingIndicatorView)
    }

    func hideActivityIndicator() {
        loadingIndicatorView.removeFromSuperview()
    }
    
    //MARK: Custom Navigation Back Button
    func setCustomBackButton() {
        let backBtnImage = UIImage(named: "arrow-left")
        self.navigationController?.navigationBar.backIndicatorImage = backBtnImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backBtnImage
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func showNavigationBar() {
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: Bottom Bar
    func hideBottomBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func showBottomBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: Navigation Back Gesture
    func disableNavigationBackGesture() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func enableNavigationBackGesture() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
}

