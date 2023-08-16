//
//  EmailSignInViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 6/8/23.
//

import UIKit

class EmailSignInViewController: UIViewController {
    
    static let identifier = "EmailSignInViewController"

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
        passwordTextField.delegate = self

        viewPasswordButton.setImage(UIImage(named: "eye"), for: .normal)
        viewPasswordButton.setImage(UIImage(named: "eye-off (3)"), for: .selected)
        
        signInButton.disabled()
        
    }
    
    private func inputValidation() {
        if emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false {
            
            gradientBackgroundImage.image = UIImage(named: "Rectangle 162 (3)")
            signInButton.enabled()
        }
        else {
            gradientBackgroundImage.image = UIImage(named: "Rectangle 162")
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
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GenreViewController") as! GenreViewController
            navigationController?.pushViewController(vc, animated: true)
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
