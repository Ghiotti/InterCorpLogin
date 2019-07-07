//
//  CalendarCellView.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 06/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//

import UIKit
import Material

class CalendarCellView: UITableViewCell {

    @IBOutlet weak var calendarTextField: TextField!
    let datePicker = UIDatePicker()
    private var personModel: PersonModel!

    override func awakeFromNib() {
        showDatePicker()
    }

    func render(personModel: PersonModel, placeHolder: String) {
        self.personModel = personModel
        calendarTextField.text = ""
        calendarTextField.placeholder = placeHolder
        calendarTextField.font = UIFont.systemFont(ofSize: 15)
        calendarTextField.delegate = self
        datePicker.date = personModel.birthDate?.parseDate() ?? Date()
        calendarTextField.text = personModel.birthDate
    }

    func showDatePicker() {
        datePicker.datePickerMode = .date

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "option_accept".localized(), style: .plain, target: self, action: #selector(doneDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "option_cancel".localized(), style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

        calendarTextField.inputAccessoryView = toolbar
        calendarTextField.inputView = datePicker
    }

    @objc func doneDatePicker() {
        personModel.birthDate = datePicker.date.formatMediumDate()
        calendarTextField.text = personModel.formattedBirthday(date: datePicker.date)
        self.endEditing(true)
    }

    @objc func cancelDatePicker() {
        self.endEditing(true)
    }
}

extension CalendarCellView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        calendarTextField.detail = "option_requiered".localized()
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
            if (textField.text?.isEmpty)! || textField.text == nil {
                calendarTextField.detailLabel.textColor = UIColor.red
            } else {
                calendarTextField.detail = ""
            }
    }
}
