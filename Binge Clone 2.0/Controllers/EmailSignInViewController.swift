//
//  EmailSignInViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 6/8/23.
//

import UIKit

class EmailSignInViewController: UIViewController {

    @IBOutlet weak var gradientBackgroundImage: UIImageView!
    @IBOutlet weak var emailTextField: BasicTextField!
    
    @IBOutlet weak var passwordTextField: BasicTextField!
    @IBOutlet weak var viewPasswordButton: UIButton!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    
    @IBOutlet weak var signInButton: ShadowButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var facebookSignInButton: UIButton!
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var appleSignInButton: UIButton!
    @IBOutlet weak var otpSignInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.isNavigationBarHidden = true

        setupView()
        
        dismissKeyboard()
    }
    
    private func setupView() {
        
        emailTextField.delegate = self
//        emailTextField.layer.borderWidth = 1
//        emailTextField.layer.cornerRadius = 8
//        emailTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
//        emailTextField.addPadding(padding: .equalSpacing(14))  // right padding
        
        passwordTextField.delegate = self
//        passwordTextField.layer.borderWidth = 1
//        passwordTextField.layer.cornerRadius = 8
//        passwordTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
//        passwordTextField.addPadding(padding: .right(40))
//        passwordTextField.addPadding(padding: .left(14))
//        passwordTextField.addPadding(padding: .equalSpacing(10))  // equal padding right, left

        viewPasswordButton.setImage(UIImage(named: "eye"), for: .normal)
        viewPasswordButton.setImage(UIImage(named: "eye-off (3)"), for: .selected)
        
//        signInButton.isUserInteractionEnabled = false
//        signInButton.layer.backgroundColor = UIColor(red: 0.427, green: 0.431, blue: 0.431, alpha: 1).cgColor // gray
        signInButton.disabled()
        
    }
    
    private func inputValidation() {
        if emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
            
            gradientBackgroundImage.image = UIImage(named: "Rectangle 162 (3)")
//            signInButton.layer.backgroundColor = UIColor(red: 0.91, green: 0.204, blue: 0.192, alpha: 1).cgColor // red
//            signInButton.isUserInteractionEnabled = true
            signInButton.enabled()

        }
        else {
            gradientBackgroundImage.image = UIImage(named: "Rectangle 162")
//            signInButton.layer.backgroundColor = UIColor(red: 0.427, green: 0.431, blue: 0.431, alpha: 1).cgColor // gray
//            signInButton.isUserInteractionEnabled = false
            signInButton.disabled()
        }
    }
    
    @IBAction func viewPasswordPressed(_ sender: Any) {
        //show password
        passwordTextField.isSecureTextEntry.toggle()
        viewPasswordButton.isSelected = !viewPasswordButton.isSelected
    }
    
    @IBAction func forgetPasswordPressed(_ sender: Any) {
        emailTextField.text = nil
        passwordTextField.text = nil
//        inputValidation()

    }

    
    @IBAction func signInPressed(_ sender: Any) {
        if signInButton.isUserInteractionEnabled {
//            home
        }
        else {
            print("signInButton disabled")
        }
        
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        if signUpButton.isUserInteractionEnabled {
            let vc = storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController") as! CreateAccountViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            print("signUpButton disabled")
        }
        
    }
    
    @IBAction func facebookSignInPressed(_ sender: Any) {
        if facebookSignInButton.isUserInteractionEnabled {
            
        }
        else {
            print("facebookSignInButton disabled")
        }
    }
    
    @IBAction func googleSignInPressed(_ sender: Any) {
        if googleSignInButton.isUserInteractionEnabled {
            
        }
        else {
            print("googleSignInButton disabled")
        }
    }
    
    @IBAction func appleSignInPressed(_ sender: Any) {
        if appleSignInButton.isUserInteractionEnabled {
            
        }
        else {
            print("appleSignInButton disabled")
        }
    }
    
    @IBAction func otpSignInPressed(_ sender: Any) {
        if otpSignInButton.isUserInteractionEnabled {
            let vc = storyboard?.instantiateViewController(withIdentifier: "OTPSignUpViewController") as! OTPSignUpViewController
            navigationController?.pushViewController(vc, animated: true)            
        }
        else {
            print("otpSignInButton disabled")
        }
    }
    
}


extension EmailSignInViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection")
        
        inputValidation()
    }
    

    //textfield func for the touch on BG
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        passwordTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
 
}
