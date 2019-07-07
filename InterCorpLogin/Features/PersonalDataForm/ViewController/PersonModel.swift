//
//  PersonModel.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 06/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import Foundation
import ObjectMapper

class PersonModel: Mappable {

    var firstName: String?
    var lastName: String?
    var birthDate: String? {
        didSet {
            NotificationCenter.default.post(name: Notification.Name(Constants.updateEageNotificationName), object: nil)
        }
    }

    init(firstName: String?,
         lastName: String?,
         dateBirth: String?) {

        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = dateBirth
    }

    init() {
    }

    required init?(map: Map) {
    }

    func age() -> String {
        if let date = birthDate?.parseDate() {
            return "\(date.age)"
        }

        return String()
    }

    func isValidData() -> Bool {
        if isEmptyOrNull(text: firstName) {
            return false
        }

        if isEmptyOrNull(text: lastName) {
            return false
        }

        if isEmptyOrNull(text: birthDate) {
            return false
        }

        return true

    }

    private func isEmptyOrNull(text: String?) -> Bool {
        if text == nil || text!.isEmpty {
            return true
        }

        return false
    }

    func formattedBirthday(date: Date?) -> String {
        guard let date = date else {
            return String()
        }

        return date.formatMediumDate()
    }

    func mapping(map: Map) {
        firstName               <- map["firstName"]
        lastName                <- map["lastName"]
        birthDate               <- map["birthDate"]
    }
}
