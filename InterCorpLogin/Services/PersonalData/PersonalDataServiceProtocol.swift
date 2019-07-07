//
//  PersonalDataServiceProtocol.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 06/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import Foundation

protocol PersonalDataServiceProtocol {

    func personalData(onSucces: @escaping(_ model: PersonModel) -> Void, onError: @escaping(_ error: Error) -> Void)

    func savePersonalData(personModel: PersonModel, onSucces: @escaping() -> Void, onError: @escaping(_ error: Error) -> Void)
}
