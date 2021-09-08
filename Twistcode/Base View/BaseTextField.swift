//
//  BaseTextField.swift
//  Twiscode
//
//  Created by Mac on 29/08/21.
//

import Foundation
import UIKit

@IBDesignable
class BaseTextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    
    func setActiveState() {
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = UIColor.init(named: "dynamo_blue")?.cgColor
    }
    
    func setInactiveState() {
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = UIColor.init(named: "dynamo_val999")?.cgColor
    }
    
    func setErrorState() {
        self.layer.borderWidth = 2.0
        self.layer.cornerRadius = 8.0
        self.layer.borderColor = UIColor.init(named: "dynamo_red")?.cgColor
    }
}
