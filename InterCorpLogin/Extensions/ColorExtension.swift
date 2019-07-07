//
//  ColorExtension.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 07/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import UIKit

extension UIColor {

    static let colorPrimary = UIColor(red: 0, green: 93, blue: 170)

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}
