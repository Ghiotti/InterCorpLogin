//
//  PersonalDataCellProtocol.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 08/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import Foundation

protocol PersonalDataCellProtocol {
    
    func render(personModel: PersonModel, placeHolder: String, maxCount: Int, minCount: Int, row: Int)
}
