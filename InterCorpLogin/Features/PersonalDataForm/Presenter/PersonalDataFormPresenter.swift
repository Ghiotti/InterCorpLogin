//
//  PersonalDataFormPresenter.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 06/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import Foundation

class PersonalDataFormPresenter {

    private unowned let view: PersonalDataFormViewControllerProtocol
    private let personalDataService: PersonalDataServiceProtocol
    private var personModel = PersonModel()
    private var tag = String(describing: PersonalDataFormPresenter.self)

    init(view: PersonalDataFormViewControllerProtocol, personalDataService: PersonalDataServiceProtocol) {
        self.view = view
        self.personalDataService = personalDataService
    }

    func start() {
        view.showLoader()
        personalDataService.personalData(onSucces: { [weak self] (personModel) in
            guard let strongSelf = self else {
                return
            }

            strongSelf.personModel = personModel
            strongSelf.view.hideLoader()
            strongSelf.view.refreshData()
        }, onError: { (error) in
            AppLogger.e(self.tag, "Error when try get PersonModel", error)
            self.view.hideLoader()
            self.view.showMessage(message: "")
        })
    }

    func savePersonModel() {
        view.showLoader()
        personalDataService.savePersonalData(
            personModel: personModel,
            onSucces: {
                AppLogger.i(self.tag, "Save Person Model")
                self.view.hideLoader()
        }, onError: { (error) in
            AppLogger.e(self.tag, "Error when try to save PersonModel", error)
            self.view.hideLoader()
            self.view.showMessage(message: "")
        })
    }

    func numberOfRows() -> Int {
            return 4
    }

    func getPersonModel() -> PersonModel {
        return personModel
    }

    func dataForRow(row: Int) -> String {
        switch row {
            case 0:
                if let firstName = personModel.firstName {
                    return firstName
                }
            case 1:
                if let lastName = personModel.lastName {
                    return lastName
                }

            case 2:
                if let dateBirth = personModel.birthDate {
                    return dateBirth
                }
            case 3:
                return personModel.age()
            default:
                return String()
        }

        return String()
    }
}
