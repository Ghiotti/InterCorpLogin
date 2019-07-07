//
//  PersonalDataFormViewController.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 06/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class PersonDataFormViewController: UITableViewController {

    private var presenter: PersonalDataFormPresenter!
    private let calendarCellIdentifier = String(describing: CalendarCellView.self)
    private let textFieldCellIdentifier = String(describing: TextFieldCellView.self)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Tableview setUp
        self.tableView.delegate = self
        self.tableView.rowHeight = 75

        // Cell registration
        self.tableView.register(UINib(nibName: calendarCellIdentifier, bundle: nil), forCellReuseIdentifier: calendarCellIdentifier)
        self.tableView.register(UINib(nibName: textFieldCellIdentifier, bundle: nil), forCellReuseIdentifier: textFieldCellIdentifier)

        NotificationCenter.default.addObserver(self, selector: #selector(updateAgeCell), name: Notification.Name("birthDateChange"), object: nil)

        // Presenter Set Up
        self.presenter = PersonalDataFormPresenter(view: self, personalDataService: PersonalDataService())
        presenter.start()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as? TextFieldCellView else {
                return UITableViewCell()
            }

            cell.render(personModel: presenter.getPersonModel(), placeHolder: "personal_data_first_mame".localized(), maxCount: 10, minCount: 1, row: indexPath.row)

            return cell

        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as? TextFieldCellView else {
                return UITableViewCell()
            }

            cell.render(personModel: presenter.getPersonModel(), placeHolder: "personal_data_last_name".localized(), maxCount: 10, minCount: 1, row: indexPath.row)

            return cell

        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: calendarCellIdentifier, for: indexPath) as? CalendarCellView else {
                return UITableViewCell()
            }

            cell.render(personModel: presenter.getPersonModel(), placeHolder: "personal_data_birth_date".localized())

            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellIdentifier, for: indexPath) as? TextFieldCellView else {
                return UITableViewCell()
            }

            cell.render(personModel: presenter.getPersonModel(), placeHolder: "personal_data_birth_age".localized(), maxCount: 10, minCount: 1, row: indexPath.row)

            return cell
        default:
            return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }

    @IBAction func logOutButtonAction(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logOut()
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveItemAction(_ sender: Any) {
        presenter.savePersonModel()
    }

    @objc private func updateAgeCell() {
        tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .none)
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("birthDateChange"), object: nil)
    }
}

extension PersonDataFormViewController: PersonalDataFormViewControllerProtocol {

    func refreshData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showLoader() {
        DispatchQueue.main.async {
            self.showSpinner(onView: self.view)
        }
    }

    func hideLoader() {
        DispatchQueue.main.async {
            self.removeSpinner(view: self.view)
        }
    }

    func showMessage(message: String) {
        DispatchQueue.main.async {

        }
    }
}


