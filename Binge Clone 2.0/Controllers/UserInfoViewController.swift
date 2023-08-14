//
//  UserInfoViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 3/8/23.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    static let identifier = "UserInfoViewController"
    
    @IBOutlet weak var gradientBackgroundImage: UIImageView!
    @IBOutlet weak var nameTextField: BasicTextField!
    @IBOutlet weak var dobTextField: DOBTextField!
    @IBOutlet weak var countryTextField: BasicTextField!
    @IBOutlet weak var cityTextField: BasicTextField!
    @IBOutlet weak var areaTextField: BasicTextField!
    @IBOutlet weak var continueButton: ShadowButton!
    
//    private let datePicker = UIDatePicker()
//    private let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
//        createDatePicker()
        
        dismissKeyboard()
    }
    
    private func setupView() {
        
        nameTextField.delegate = self

//        nameTextField.layer.borderWidth = 1
//        nameTextField.layer.cornerRadius = 8
//        nameTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
//        nameTextField.addPadding(padding: .equalSpacing(30))
        
        dobTextField.delegate = self
//        dobTextField.layer.borderWidth = 1
//        dobTextField.layer.cornerRadius = 8
//        dobTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
//        dobTextField.addPadding(padding: .equalSpacing(14))
        
//        dateFormatter.dateStyle = .medium
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//
//        dateFormatter.timeStyle = .none
        
        countryTextField.delegate = self
//        countryTextField.layer.borderWidth = 1
//        countryTextField.layer.cornerRadius = 8
//        countryTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
//        countryTextField.addPadding(padding: .equalSpacing(14))
        
        cityTextField.delegate = self
//        cityTextField.layer.borderWidth = 1
//        cityTextField.layer.cornerRadius = 8
//        cityTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
//        cityTextField.addPadding(padding: .equalSpacing(14))
        
        areaTextField.delegate = self
//        areaTextField.layer.borderWidth = 1
//        areaTextField.layer.cornerRadius = 8
//        areaTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
//        areaTextField.addPadding(padding: .equalSpacing(14))
        
//        continueButton.isUserInteractionEnabled = false
//        continueButton.layer.backgroundColor = UIColor(red: 0.427, green: 0.431, blue: 0.431, alpha: 1).cgColor // gray
        continueButton.disabled()
        
    }
    
    
//    private func createDatePicker() {
//        datePicker.preferredDatePickerStyle = .inline
//        datePicker.datePickerMode = .date
//
//        dobTextField.inputView = datePicker
//        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
//    }
//
//    @objc func dateSelected() {
////        dobTextField.text = dateFormatter.string(from: datePicker.date)
//        dobTextField.text = dateFormatter.string(from: datePicker.date) as String
//        self.view.endEditing(true)
//    }

    
    private func inputValidation() {
        if nameTextField.text?.isEmpty == false {
            gradientBackgroundImage.image = UIImage(named: "Rectangle 161 (3)")
            continueButton.enabled()
//            continueButton.layer.backgroundColor = UIColor(red: 0.91, green: 0.204, blue: 0.192, alpha: 1).cgColor // red
//            continueButton.isUserInteractionEnabled = true
        }
        else {
            gradientBackgroundImage.image = UIImage(named: "Rectangle 161")
            continueButton.disabled()
//            continueButton.layer.backgroundColor = UIColor(red: 0.427, green: 0.431, blue: 0.431, alpha: 1).cgColor // gray
//            continueButton.isUserInteractionEnabled = false
        }
    }

    
    @IBAction func continuePressed(_ sender: Any) {
        if continueButton.isUserInteractionEnabled {
//            HOME push
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GenreViewController") as! GenreViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            print("continueButton disabled")
        }
    }
    
}


extension UserInfoViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection")
        
        inputValidation()
    }

    
}
