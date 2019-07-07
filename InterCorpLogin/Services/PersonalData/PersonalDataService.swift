//
//  PersonalDataService.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 06/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase

class PersonalDataService: PersonalDataServiceProtocol {

    let colection = "users"
    private let ref = Database.database().reference()
    private let userId = Auth.auth().currentUser?.uid

    func personalData(onSucces: @escaping (PersonModel) -> Void, onError: @escaping (Error) -> Void) {
        ref.child(colection).child(userId!).observeSingleEvent(of: .value, with: { (response) in
            if let response = response.value as? [String: Any] {
                if let personModel = PersonModel(JSON: response) {
                    onSucces(personModel)
                    return
                }
            }
            onSucces(PersonModel())
        }, withCancel: { (error) in
            onError(error)
        })
    }

    func savePersonalData(personModel: PersonModel, onSucces: @escaping() -> Void, onError: @escaping(_ error: Error) -> Void) {
        ref.child(colection)
        .child(userId!)
        .setValue([
            "firstName": personModel.firstName!,
            "lastName": personModel.lastName!,
            "birthDate": personModel.birthDate!
            ]
        ) { (error:Error?, ref:DatabaseReference) in
            if let error = error {
                onError(error)
                return
            }
            onSucces()
        }
    }
}
