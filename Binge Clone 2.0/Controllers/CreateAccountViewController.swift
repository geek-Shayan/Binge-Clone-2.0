//
//  CreateAccountViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 6/8/23.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    static let identifier = "CreateAccountViewController"
    
    @IBOutlet weak var gradientBackgroundImage: UIImageView!
    @IBOutlet weak var nameTextField: BasicTextField!
    @IBOutlet weak var dobTextField: DOBTextField!
    @IBOutlet weak var countryTextField: BasicTextField!
    @IBOutlet weak var cityTextField: BasicTextField!
    @IBOutlet weak var areaTextField: BasicTextField!
    @IBOutlet weak var emailTextField: BasicTextField!
    
    @IBOutlet weak var passwordTextField: BasicTextField!
    @IBOutlet weak var viewPasswordButton: UIButton!
    
    @IBOutlet weak var confirmPasswordTextField: BasicTextField!
    @IBOutlet weak var viewConfirmPasswordButton: UIButton!
    
    @IBOutlet weak var signUpButton: ShadowButton!
    @IBOutlet weak var signInButton: UIButton!
    
    
    private let maxLengthPhoneNumber = 1
    private let acceptableNumbers = "0123456789"
    
    private var OTP = "OTP"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.isNavigationBarHidden = true

        setupView()
        
        dismissKeyboard()
    }
    

    private func setupView() {
        
        nameTextField.delegate = self
//        nameTextField.layer.borderWidth = 1
//        nameTextField.layer.cornerRadius = 8
//        nameTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
        
        dobTextField.delegate = self
//        dobTextField.layer.borderWidth = 1
//        dobTextField.layer.cornerRadius = 8
//        dobTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
        
        countryTextField.delegate = self
//        countryTextField.layer.borderWidth = 1
//        countryTextField.layer.cornerRadius = 8
//        countryTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
        
        cityTextField.delegate = self
//        cityTextField.layer.borderWidth = 1
//        cityTextField.layer.cornerRadius = 8
//        cityTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
        
        areaTextField.delegate = self
//        areaTextField.layer.borderWidth = 1
//        areaTextField.layer.cornerRadius = 8
//        areaTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
        
        emailTextField.delegate = self
//        emailTextField.layer.borderWidth = 1
//        emailTextField.layer.cornerRadius = 8
//        emailTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
        
        passwordTextField.delegate = self
//        passwordTextField.layer.borderWidth = 1
//        passwordTextField.layer.cornerRadius = 8
//        passwordTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor

        viewPasswordButton.setImage(UIImage(named: "eye"), for: .normal)
        viewPasswordButton.setImage(UIImage(named: "eye-off (3)"), for: .selected)
        
        confirmPasswordTextField.delegate = self
//        confirmPasswordTextField.layer.borderWidth = 1
//        confirmPasswordTextField.layer.cornerRadius = 8
//        confirmPasswordTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
        
        viewConfirmPasswordButton.setImage(UIImage(named: "eye"), for: .normal)
        viewConfirmPasswordButton.setImage(UIImage(named: "eye-off (3)"), for: .selected)

        
//        signUpButton.isUserInteractionEnabled = false
//        signUpButton.layer.backgroundColor = UIColor(red: 0.427, green: 0.431, blue: 0.431, alpha: 1).cgColor // gray
        signUpButton.disabled()
        
    }
    
    
//    private func otpPaste(_ textField: UITextField, _ string: String) {
//        if textField.textContentType == UITextContentType.oneTimeCode {
//            otpTextField1.becomeFirstResponder()
//            //split the text to four text fields
//            otpTextField1.text = String(string[string.index(string.startIndex, offsetBy: 0)])
//            otpTextField2.text = String(string[string.index(string.startIndex, offsetBy: 1)])
//            otpTextField3.text = String(string[string.index(string.startIndex, offsetBy: 2)])
//            otpTextField4.text = String(string[string.index(string.startIndex, offsetBy: 3)])
//            otpTextField1.resignFirstResponder()
//        }
//    }
    
    
    private func inputValidation() {
        if nameTextField.text?.isEmpty == false && emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false && confirmPasswordTextField.text == passwordTextField.text {
            
            gradientBackgroundImage.image = UIImage(named: "Rectangle 163 (3)")
//            signUpButton.layer.backgroundColor = UIColor(red: 0.91, green: 0.204, blue: 0.192, alpha: 1).cgColor // red
//            signUpButton.isUserInteractionEnabled = true
            signUpButton.enabled()
        }
        else {
            gradientBackgroundImage.image = UIImage(named: "Rectangle 163")
//            signUpButton.layer.backgroundColor = UIColor(red: 0.427, green: 0.431, blue: 0.431, alpha: 1).cgColor // gray
//            signUpButton.isUserInteractionEnabled = false
            signUpButton.disabled()
        }
    }
    

    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    @IBAction func viewPasswordPressed(_ sender: Any) {
        //show password
        passwordTextField.isSecureTextEntry.toggle()
        viewPasswordButton.isSelected = !viewPasswordButton.isSelected

    }
    
    @IBAction func viewConfirmPasswordPressed(_ sender: Any) {
        //show confirm password
        confirmPasswordTextField.isSecureTextEntry.toggle()
        viewConfirmPasswordButton.isSelected = !viewConfirmPasswordButton.isSelected
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        if signUpButton.isUserInteractionEnabled {
//            home push
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GenreViewController") as! GenreViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            print("signUpButton disabled")
        }
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        if signInButton.isUserInteractionEnabled {
            let vc = storyboard?.instantiateViewController(withIdentifier: "EmailSignInViewController") as! EmailSignInViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            print("signInButton disabled")
        }
    }
}


extension CreateAccountViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection")
        
        inputValidation()
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        print(textFieldDidBeginEditing)
//
//    }
    
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//
//        return true
//    }
    
 
}
