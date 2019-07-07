//
//  StringExtension.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 06/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import Foundation

extension String {

    func localized() -> String {
        return Bundle.main.localizedString(forKey: self, value: nil, table: "Localizable")
    }

    func parseDate() -> Date? {
        let dateFormat = "dd MM yyyy"
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = dateFormat
        return dateFormatter.date(from: self)
    }
}
