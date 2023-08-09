//
//  LoginViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 2/8/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var gradientBackgroundImage: UIImageView!
    @IBOutlet weak var conuntryCodeTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var termSeletionButton: UIButton!
    @IBOutlet weak var termLinkedLabel: UILabel!
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var facebookSignInButton: UIButton!
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var appleSignInButton: UIButton!
    @IBOutlet weak var emailSignInButton: UIButton!
//    @IBOutlet weak var appleSignInButton: ASAuthorizationAppleIDButton!
    
    
    
    
    
    private let maxLengthPhoneNumber = 10
    private let acceptableNumbers = "0123456789"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.isNavigationBarHidden = true

        setupView()
    }
    
    private func setupView() {
        
//                conuntryCodeTextField.delegate = self
        conuntryCodeTextField.layer.borderWidth = 1
        conuntryCodeTextField.layer.cornerRadius = 8
        conuntryCodeTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
        conuntryCodeTextField.addPadding(padding: .right(10))  // right padding
        
        phoneNumberTextField.delegate = self
        phoneNumberTextField.layer.borderWidth = 1
        phoneNumberTextField.layer.cornerRadius = 8
        phoneNumberTextField.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1).cgColor
        phoneNumberTextField.addPadding(padding: .equalSpacing(14))  // equal padding right, left
//        phoneNumberTextField.becomeFirstResponder()

        termSeletionButton.setImage(UIImage(named: "Ellipse 5"), for: .normal)
        termSeletionButton.setImage(UIImage(named: "Ellipse 5 (3)"), for: .selected)
        
        continueButton.isUserInteractionEnabled = false
        continueButton.layer.backgroundColor = UIColor(red: 0.427, green: 0.431, blue: 0.431, alpha: 1).cgColor // gray
        

        
//        let attributedString = NSMutableAttributedString(string:"I love stackoverflow!")
//        attributedString.addAttributes(range: <#T##NSRange#>)
////        let linkWasSet = attributedString.setAsLink(textToFind: "stackoverflow", linkURL: "https://www.google.com/")
//
//        if linkWasSet {
//            // adjust more attributedString properties
//            termLinkedLabel.attributedText = attributedString
//        }
        
    }
    
    private func inputValidation() {
        if phoneNumberTextField.text?.count == maxLengthPhoneNumber /*&& conuntryCodeTextField.text?.isEmpty == false */ {
//            phoneNumberTextField.resignFirstResponder() //
//            self.view.endEditing(true)
            
            if termSeletionButton.isSelected {
                gradientBackgroundImage.image = UIImage(named: "Rectangle 161 (3)")
                continueButton.layer.backgroundColor = UIColor(red: 0.91, green: 0.204, blue: 0.192, alpha: 1).cgColor // red
                continueButton.isUserInteractionEnabled = true
            }
            else {
                gradientBackgroundImage.image = UIImage(named: "Rectangle 161")
                continueButton.layer.backgroundColor = UIColor(red: 0.427, green: 0.431, blue: 0.431, alpha: 1).cgColor // gray
                continueButton.isUserInteractionEnabled = false
            }
        }
        else {
            gradientBackgroundImage.image = UIImage(named: "Rectangle 161")
            continueButton.layer.backgroundColor = UIColor(red: 0.427, green: 0.431, blue: 0.431, alpha: 1).cgColor // gray
            continueButton.isUserInteractionEnabled = false
        }
    }
    
    
    @IBAction func termSeletionPressed(_ sender: Any) {
        termSeletionButton.isSelected = !termSeletionButton.isSelected
        
        inputValidation()
        
    }

    
    @IBAction func continuePressed(_ sender: Any) {
        if continueButton.isUserInteractionEnabled {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OTPViewController") as! OTPViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            print("continueButton disabled")
        }
        
    }
    
    @IBAction func facebookLoginPressed(_ sender: Any) {
        if facebookSignInButton.isUserInteractionEnabled {
            print("facebookSignInButton")
        }
        else {
            print("facebookSignInButton disabled")
        }

    }
    
    @IBAction func googleLoginPressed(_ sender: Any) {
        if googleSignInButton.isUserInteractionEnabled {
            print("googleSignInButton")
        }
        else {
            print("googleSignInButton disabled")
        }
    }
    
    @IBAction func appleLoginPressed(_ sender: Any) {
        if appleSignInButton.isUserInteractionEnabled {
            print("appleSignInButton")
        }
        else {
            print("appleSignInButton disabled")
        }
    }
    
    @IBAction func emailLoginPressed(_ sender: Any) {
        if emailSignInButton.isUserInteractionEnabled {
            print("emailSignInButton")
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "EmailSignInViewController") as! EmailSignInViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            print("emailSignInButton disabled")
        }
    }
}



extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection")
        
        inputValidation()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength: Int = textField.text!.count + string.count - range.length
        let numberOnly = NSCharacterSet.init(charactersIn: acceptableNumbers).inverted
        let strValid = string.rangeOfCharacter(from: numberOnly) == nil
        return (strValid && (newLength <= maxLengthPhoneNumber))
    }
    

    //textfield func for the touch on BG
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneNumberTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
 
}
