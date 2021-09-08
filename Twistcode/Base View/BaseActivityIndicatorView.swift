//
//  BaseActivityIndicator.swift
//  Twiscode
//
//  Created by Mac on 13/07/21.
//

import Foundation
import NVActivityIndicatorView
import UIKit

class BaseActivityIndicatorView: UIView {
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!

    // MARK: - For loading from Nib
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        return self.loadFromNibIfEmbeddedInDifferentNib()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupLoadingIndicator()
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.type = .ballScaleRippleMultiple
        loadingIndicator.startAnimating()
    }
}
internal extension UIView {
    class func viewFromNib(withOwner owner: Any? = nil) -> Self {
      let name = String(describing: type(of: self)).components(separatedBy: ".")[0]
      let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: owner, options: nil)[0]
      return cast(view)!
    }

    func loadFromNibIfEmbeddedInDifferentNib() -> Self {
      let isJustAPlaceholder = subviews.count == 0
      if isJustAPlaceholder {
        let theRealThing = type(of: self).viewFromNib()
        theRealThing.frame = frame
        translatesAutoresizingMaskIntoConstraints = false
        theRealThing.translatesAutoresizingMaskIntoConstraints = false
        return theRealThing
      }
      return self
    }
}

private func cast<T, U>(_ value: T) -> U? {
  return value as? U
}
