//
//  OTPSignUpViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 7/8/23.
//

import UIKit

class OTPSignUpViewController: UIViewController {
    
    static let identifier = "OTPSignUpViewController"

    @IBOutlet weak var gradientBackgroundImage: UIImageView!
    @IBOutlet weak var countryCodeTextField: BasicTextField!
    @IBOutlet weak var phoneNumberTextField: BasicTextField!
    @IBOutlet weak var termSeletionButton: UIButton!
    @IBOutlet weak var termsAndConditionsLabel: TermsAndConditionsLabel!
    @IBOutlet weak var continueButton: ShadowButton!
    
    @IBOutlet weak var facebookSignInButton: UIButton!
    @IBOutlet weak var googleSignInButton: UIButton!
    @IBOutlet weak var appleSignInButton: UIButton!
    @IBOutlet weak var emailSignInButton: UIButton!
//    @IBOutlet weak var appleSignInButton: ASAuthorizationAppleIDButton!
    
    
    private let maxLengthPhoneNumber = 10
    private let acceptableNumbers = "0123456789"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true

        setupView()
        
        dismissKeyboard()
    }
    
    private func setupView() {
        
        countryCodeTextField.delegate = self
        phoneNumberTextField.delegate = self

        termSeletionButton.setImage(UIImage(named: "Ellipse 5"), for: .normal)
        termSeletionButton.setImage(UIImage(named: "Ellipse 5 (3)"), for: .selected)
        
        termsAndConditionsLabel.privacyTapped = {
            //show privacy policy
            let vc = self.storyboard?.instantiateViewController(withIdentifier: PrivacyPolicyViewController.identifier) as! PrivacyPolicyViewController
            self.present(vc, animated: true)
        }
        termsAndConditionsLabel.termsTapped = {
            //show terms and conditions
            let vc = self.storyboard?.instantiateViewController(withIdentifier: TermsAndConditionsViewController.identifier) as! TermsAndConditionsViewController
            self.present(vc, animated: true)
        }

        continueButton.disabled()
        
    }
    
    private func inputValidation() {
        if phoneNumberTextField.text?.count == maxLengthPhoneNumber /*&& countryCodeTextField.text?.isEmpty == false */ {
//            phoneNumberTextField.resignFirstResponder() //
//            self.view.endEditing(true)
            
            if termSeletionButton.isSelected {
                gradientBackgroundImage.image = UIImage(named: "Rectangle 161 (3)")
                continueButton.enabled()
            }
            else {
                gradientBackgroundImage.image = UIImage(named: "Rectangle 161")
                continueButton.disabled()
            }
        }
        else {
            gradientBackgroundImage.image = UIImage(named: "Rectangle 161")
            continueButton.disabled()
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
    
    @IBAction func facebookSignInPressed(_ sender: Any) {
        if facebookSignInButton.isUserInteractionEnabled {
            print("facebookSignInButton")
        }
        else {
            print("facebookSignInButton disabled")
        }

    }
    
    @IBAction func googleSignInPressed(_ sender: Any) {
        if googleSignInButton.isUserInteractionEnabled {
            print("googleSignInButton")
        }
        else {
            print("googleSignInButton disabled")
        }
    }
    
    @IBAction func appleSignInPressed(_ sender: Any) {
        if appleSignInButton.isUserInteractionEnabled {
            print("appleSignInButton")
        }
        else {
            print("appleSignInButton disabled")
        }
    }
    
    @IBAction func emailSignInPressed(_ sender: Any) {
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



extension OTPSignUpViewController: UITextFieldDelegate {
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

}
