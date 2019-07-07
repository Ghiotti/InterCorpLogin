//
//  TextFieldCellView.swift
//  InterCorpLogin
//
//  Created by Franco Ghiotti on 06/07/2019.
//  Copyright © 2019 Franco Ghiotti. All rights reserved.
//
import UIKit
import Material

class TextFieldCellView: UITableViewCell {
    
    @IBOutlet weak var inputTextField: TextField!
    @IBOutlet weak var characterCountLabel: UILabel!
    var personModel: PersonModel!
    private var maxCount: Int!
    private var minCount: Int!
    private var row: Int!

    override func awakeFromNib() {
    }

    func render(personModel: PersonModel, placeHolder: String, maxCount: Int, minCount: Int, row: Int) {
        self.personModel = personModel

        self.maxCount = maxCount
        self.minCount = minCount
        self.row = row

        inputTextField.text = String()
        inputTextField.placeholder = placeHolder
        inputTextField.font = UIFont.systemFont(ofSize: 15)
        inputTextField.delegate = self
        characterCountLabel.isHidden = true
        characterCountLabel.text = String()

        inputTextField.text = textForTextField(row: row)

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "option_accept".localized(), style: .plain, target: self, action: #selector(doneTextEditing));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "option_cancel".localized(), style: .plain, target: self, action: #selector(cancelTextEditing));

        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

        inputTextField.inputAccessoryView = toolbar
    }

    func count(text: String?) -> String {
        if let text = text {
            let count = text.utf8.count
            return "\(count)/\(String(describing: maxCount!))"
        } else {
            return "0/\(String(describing: maxCount!))"
        }
    }

    @objc func doneTextEditing(){
        self.endEditing(true)
    }

    @objc func cancelTextEditing(){
        inputTextField.text = textForTextField(row: row)

        self.endEditing(true)
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
            self.inputTextField.isEnabled = false
            return personModel.age()
        default:
            return String()
        }

        return String()
    }

    func updateModelView(text: String?) {
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

extension TextFieldCellView: TextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        inputTextField.detail = "option_requiered".localized()
        characterCountLabel.isHidden = false
        characterCountLabel.text = count(text: textField.text)
    }

    func textField(textField: TextField, didChange text: String?) {
        characterCountLabel.text = count(text: text)
        if (text?.isEmpty)! || text == nil {
            characterCountLabel.textColor = UIColor.red
        } else {
            characterCountLabel.textColor = UIColor.lightGray
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if (textField.text?.isEmpty)! || textField.text == nil {
            inputTextField.detail = String()
            characterCountLabel.textColor = UIColor.red
        } else {
            inputTextField.detail = String()
            characterCountLabel.isHidden = true
        }

        updateModelView(text: textField.text)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.utf8.count - range.length
        return count <= maxCount - 1
    }
}
