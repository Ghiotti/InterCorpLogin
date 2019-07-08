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
        self.tableView.sectionFooterHeight = 150
        
        // Cell registration
        self.tableView.register(UINib(nibName: calendarCellIdentifier, bundle: nil), forCellReuseIdentifier: calendarCellIdentifier)
        self.tableView.register(UINib(nibName: textFieldCellIdentifier, bundle: nil), forCellReuseIdentifier: textFieldCellIdentifier)

        NotificationCenter.default.addObserver(self, selector: #selector(updateAgeCell), name: Notification.Name(Constants.updateEageNotificationName), object: nil)

        // Presenter Set Up
        self.presenter = PersonalDataFormPresenter(view: self, personalDataService: PersonalDataService())
        presenter.start()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(Constants.updateEageNotificationName), object: nil)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = presenter.identifierForCell(row: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        presenter.setUpCell(cell: cell as! PersonalDataCellProtocol, row: indexPath.row)
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return addFooterButton()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    @IBAction func logOutButtonAction(_ sender: Any) {
        presenter.checkModelAfterLogOut()
    }

    @IBAction func saveItemAction(_ sender: Any) {
        presenter.savePersonModel()
    }

    @objc private func updateAgeCell() {
        tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .none)
    }
    
    func addFooterButton() -> UIView {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width - 32, height: 50))
        button.setTitle("option_save".localized(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 23
        button.backgroundColor = UIColor.white
        button.setTitleColor(UIColor.colorPrimary, for: .normal)
        button.layer.borderColor = UIColor.colorPrimary.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(saveItemAction(_:)), for: .touchUpInside)
        customView.addSubview(button)
        button.center = customView.center
        return customView
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
            self.showSpinner(onView: self.navigationController!.view)
        }
    }

    func hideLoader() {
        self.removeSpinner(view: self.navigationController!.view)
    }

    func showMessage(message: String) {
        self.alertView(with: message)
    }

    func showConfimationPopUp() {
        self.alertView(withButtonActions: "save_person_data_confimation".localized(), actionLeftButton: {
        }) {
            self.logOut()
        }
    }

    func logOut() {
        DispatchQueue.main.async {
            let loginManager = LoginManager()
            loginManager.logOut()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
