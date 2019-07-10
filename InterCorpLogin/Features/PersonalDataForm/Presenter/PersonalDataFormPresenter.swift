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
    private var backUpPersonModel = PersonModel()
    private var tag = String(describing: PersonalDataFormPresenter.self)
    private let calendarCellIdentifier = String(describing: CalendarCellView.self)
    private let textFieldCellIdentifier = String(describing: TextFieldCellView.self)

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
            strongSelf.backUpPersonModel = PersonModel(firstName: personModel.firstName, lastName: personModel.lastName, dateBirth: personModel.birthDate)
            strongSelf.view.hideLoader()
            strongSelf.view.refreshData()
        }, onError: { (error) in
            AppLogger.e(self.tag, "Error when try get PersonModel", error)
            self.view.hideLoader()
            self.view.showMessage(message: "generic_error".localized())
        })
    }

    func savePersonModel() {
        if !personModel.isValidData() {
            view.showMessage(message: "Please complete all fields")
            return
        }
        
        view.showLoader()
        personalDataService.savePersonalData(
            personModel: personModel,
            onSucces: {
                AppLogger.i(self.tag, "Save Person Model")
                self.backUpPersonModel = PersonModel(firstName: self.personModel.firstName, lastName: self.personModel.lastName, dateBirth: self.personModel.birthDate)
                self.view.hideLoader()
                self.view.showMessage(message: "save_person_data_success".localized())
        }, onError: { (error) in
            AppLogger.e(self.tag, "Error when try to save PersonModel", error)
            self.view.hideLoader()
            self.view.showMessage(message: "generic_error".localized())
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

    func checkModelAfterLogOut() {
        if !personModel.isValidData() ||
            hasPersonModelChange() {
            self.view.showConfimationPopUp()

            return
        }

        self.view.logOut()
    }
    
    func identifierForCell(row: Int) -> String {
        if row == 2 {
            return calendarCellIdentifier
        }
        
        return textFieldCellIdentifier
    }
    
    func setUpCell(cell: PersonalDataCellProtocol, row: Int) {
        cell.render(personModel: personModel, placeHolder: placeHolderForCell(row: row) , maxCount: 10, minCount: 1, row: row)
    }

    private func hasPersonModelChange() -> Bool {
        if personModel.firstName != backUpPersonModel.firstName ||
           personModel.lastName != backUpPersonModel.lastName ||
           personModel.birthDate != backUpPersonModel.birthDate {

            return true
        }

        return false
    }
    
    private func placeHolderForCell(row: Int) -> String {
        switch row {
            case 0:
                return "personal_data_first_mame".localized()
            case 1:
                return "personal_data_last_name".localized()
            case 2:
                return "personal_data_birth_date".localized()
            case 3:
                return "personal_data_birth_age".localized()
            default:
                return String()
        }
    }
}
