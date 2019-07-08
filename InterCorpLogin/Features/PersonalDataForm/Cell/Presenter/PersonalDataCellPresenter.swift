//
//  PersonalDataCellPresenter.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 08/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import Foundation

class PersonalDataCellPresenter {
    
    private var personModel: PersonModel
    
    init(personModel: PersonModel) {
        self.personModel = personModel
    }
    
    func textForTextField(row: Int) -> String {
        switch row {
            case 0:
                if let firstName = personModel.firstName {
                    return firstName
                }
            case 1:
                if let lastName = personModel.lastName {
                    return lastName
                }
            case 3:
                return personModel.age()
            default:
                return String()
        }
        
        return String()
    }
    
    func count(text: String?, maxCount: Int) -> String {
        if let text = text {
            let count = text.utf8.count
            return "\(count)/\(String(describing: maxCount))"
        } else {
            return "0/\(String(describing: maxCount))"
        }
    }
    
    func updateModelView(text: String?, row: Int) {
        switch row {
            case 0:
                personModel.firstName = text
            case 1:
                personModel.lastName = text
            default:
                // Do nothing
            break
        }
    }
}
