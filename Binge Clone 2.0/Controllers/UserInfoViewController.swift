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
    
    
    let countries = ["bd", "india", "kenya"]
    let cities = ["dhaka", "khulna", "rajshahi"]
    let areas = ["south", "north"]
    
    let countryPickerView = UIPickerView()
    let cityPickerView = UIPickerView()
    let areaPickerView = UIPickerView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        dismissKeyboard()
    }
    
    private func setupView() {
        nameTextField.delegate = self
        dobTextField.delegate = self
        
        countryTextField.delegate = self
        countryTextField.inputView = countryPickerView
        
        cityTextField.delegate = self
        cityTextField.inputView = cityPickerView

        areaTextField.delegate = self
        areaTextField.inputView = areaPickerView
        
        countryPickerView.delegate = self
        cityPickerView.delegate = self
        areaPickerView.delegate = self
        
        countryPickerView.dataSource = self
        cityPickerView.dataSource = self
        areaPickerView.dataSource = self
        
        countryPickerView.tag = 0
        cityPickerView.tag = 1
        areaPickerView.tag = 2
        
        continueButton.disabled()
        
    }
    
    private func inputValidation() {
        if nameTextField.text?.isEmpty == false {
            gradientBackgroundImage.image = UIImage(named: "Rectangle 161 (3)")
            continueButton.enabled()
        }
        else {
            gradientBackgroundImage.image = UIImage(named: "Rectangle 161")
            continueButton.disabled()
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


extension UserInfoViewController: UIPickerViewDelegate {
    
}


extension UserInfoViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 0:
            return countries.count
        case 1:
            return cities.count
        case 2:
            return areas.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 0:
            return countries[row]
        case 1:
            return cities[row]
        case 2:
            return areas[row]
        default:
            return "Data Not Found"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            countryTextField.text = countries[row]
            cityTextField.text = nil
            areaTextField.text = nil
        case 1:
            cityTextField.text = cities[row]
            areaTextField.text = nil
        case 2:
            areaTextField.text = areas[row]
        default:
            countryTextField.text = nil
            cityTextField.text = nil
            areaTextField.text = nil
            
        }
    }
    
}
