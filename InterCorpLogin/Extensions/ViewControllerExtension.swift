//
//  ViewControllerExtension.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 06/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import UIKit

var vSpinner : UIView?

extension UIViewController {
    
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center

        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }

        vSpinner = spinnerView
    }

    func removeSpinner(view: UIView? = nil) {
        DispatchQueue.main.async {
            if let view = view {
                for subView in view.subviews {
                    if subView.subviews.first as? UIActivityIndicatorView != nil {
                        subView.removeFromSuperview()
                    }
                }

                return
             }
        }

        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
