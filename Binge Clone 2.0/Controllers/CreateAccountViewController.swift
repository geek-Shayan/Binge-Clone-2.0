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
        dobTextField.delegate = self
        countryTextField.delegate = self
        cityTextField.delegate = self
        areaTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self

        viewPasswordButton.setImage(UIImage(named: "eye"), for: .normal)
        viewPasswordButton.setImage(UIImage(named: "eye-off (3)"), for: .selected)
        
        viewConfirmPasswordButton.setImage(UIImage(named: "eye"), for: .normal)
        viewConfirmPasswordButton.setImage(UIImage(named: "eye-off (3)"), for: .selected)

        signUpButton.disabled()
        
    }
    
    
    private func inputValidation() {
        if nameTextField.text?.isEmpty == false && emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false && confirmPasswordTextField.text == passwordTextField.text {
            
            gradientBackgroundImage.image = UIImage(named: "Rectangle 163 (3)")
            signUpButton.enabled()
        }
        else {
            gradientBackgroundImage.image = UIImage(named: "Rectangle 163")
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
    
 
}
