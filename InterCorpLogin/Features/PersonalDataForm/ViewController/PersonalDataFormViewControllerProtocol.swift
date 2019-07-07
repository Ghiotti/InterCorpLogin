//
//  PersonalDataFormViewControllerProtocol.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 06/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import Foundation

protocol PersonalDataFormViewControllerProtocol: class {

    func refreshData()

    func showLoader()

    func hideLoader()

    func showMessage(message: String)

    func showConfimationPopUp() 

    func logOut()
}
