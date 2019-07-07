//
//  DateExtension.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 06/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import Foundation

extension Date {

    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }

    func formatMediumDate() -> String {
        let dateFormat = "dd MMM yyyy"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat

        return dateFormatter.string(from: self)
    }
}
