//
//  OTPViewController.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 2/8/23.
//

import UIKit

class OTPViewController: UIViewController {
    
    static let identifier = "OTPViewController"

    @IBOutlet weak var gradientBackgroundImage: UIImageView!
    @IBOutlet weak var otpTextField1: OTPTextField!
    @IBOutlet weak var otpTextField2: OTPTextField!
    @IBOutlet weak var otpTextField3: OTPTextField!
    @IBOutlet weak var otpTextField4: OTPTextField!
    @IBOutlet weak var verifyButton: ShadowButton!
    
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
        
        otpTextField1.delegate = self
        otpTextField2.delegate = self
        otpTextField3.delegate = self
        otpTextField4.delegate = self
        
        verifyButton.disabled()
        
    }
    
    
    private func otpPaste(_ textField: UITextField, _ string: String) {
        if textField.textContentType == UITextContentType.oneTimeCode {
            otpTextField1.becomeFirstResponder()
            //split the text to four text fields
            otpTextField1.text = String(string[string.index(string.startIndex, offsetBy: 0)])
            otpTextField2.text = String(string[string.index(string.startIndex, offsetBy: 1)])
            otpTextField3.text = String(string[string.index(string.startIndex, offsetBy: 2)])
            otpTextField4.text = String(string[string.index(string.startIndex, offsetBy: 3)])
            otpTextField1.resignFirstResponder()
        }
    }
    
    
    private func otpInputValidation(textField: UITextField, replacementString string: String) -> Bool {
        let numberOnly = NSCharacterSet(charactersIn: acceptableNumbers).inverted
        let strValid = string.rangeOfCharacter(from: numberOnly) == nil

        // number validation
        if (strValid) {

            // tf paste input
            if string.count == 4 {

                otpPaste(textField, string) //paste otp
                otpSentToApi(textField) //check for not empty & send api

                return false
            }

            // tf single input
            else if string.count == 1 {

                if textField == otpTextField1 {
                    otpTextField2.becomeFirstResponder()
                    textField.text? = string

                    otpSentToApi(textField) //check for not empty & send api

                }
                if textField == otpTextField2 {
                    if otpTextField1.text != "" {

                        otpTextField3.becomeFirstResponder()
                        textField.text? = string
                    }
                    else {
                        otpTextField1.becomeFirstResponder()
                        otpTextField1.text = string
                        textField.becomeFirstResponder()
                    }

                    otpSentToApi(textField) //check for not empty & send api

                }
                if textField == otpTextField3 {
                    if otpTextField2.text != "" {

                        otpTextField4.becomeFirstResponder()
                        textField.text? = string
                    }
                    else {
                        otpTextField1.becomeFirstResponder()
                        otpTextField1.text = string
                        otpTextField2.becomeFirstResponder()
                    }

                    otpSentToApi(textField) //check for not empty & send api

                }
                if textField == otpTextField4 {
                    if otpTextField2.text != "" {

                        otpTextField4.resignFirstResponder()
                        textField.text? = string
                    }
                    else {
                        otpTextField1.becomeFirstResponder()
                        otpTextField1.text = string
                        otpTextField2.becomeFirstResponder()
                    }

                    otpSentToApi(textField) //check for not empty & send api

                }
                return false
            }
            else if string.count == 0 {

                if textField == otpTextField4 {

                    otpTextField3?.becomeFirstResponder()
                    textField.text? = string
                }

                if textField == otpTextField3 {

                    if otpTextField2.text != "" && otpTextField4.text != "" {
                        textField.becomeFirstResponder()
                        textField.text = string
                    }

                    else {
                        otpTextField2?.becomeFirstResponder()
                        textField.text? = string
                    }

//                    otpTextField2?.becomeFirstResponder()
//                    textField.text? = string
                }

                if textField == otpTextField2 {

                    if otpTextField1.text != "" && otpTextField3.text != "" {
                        textField.becomeFirstResponder()
                        textField.text = string
                    }

                    else {
                        otpTextField1?.becomeFirstResponder()
                        textField.text? = string
                    }

//                    otpTextField1?.becomeFirstResponder()
//                    textField.text? = string
                }

                if textField == otpTextField1 {
                    otpTextField1?.becomeFirstResponder()
                    textField.text? = string
                }

                gradientBackgroundImage.image = UIImage(named: "Rectangle 161") // locked
                verifyButton.disabled()

                return false
            }

            else {
                return false
            }

        }
        else {
            return strValid
        }
    }
    
    
    private func otpSentToApi(_ textField: UITextField) {
        
        if otpTextField1.text != "" && otpTextField2.text != "" && otpTextField3.text != "" && otpTextField4.text != "" {
            // print( "not '' check")
            textField.resignFirstResponder()//
            
            //api call
            OTP = "\(otpTextField1.text!)\(otpTextField2.text!)\(otpTextField3.text!)\(otpTextField4.text!)"
            print("OTP  \(OTP)")
            
            //api success
            gradientBackgroundImage.image = UIImage(named: "Rectangle 161 (3)") // unlocked
            verifyButton.enabled()

        }
    }
    

    @IBAction func backPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func verifyPressed(_ sender: Any) {
        if verifyButton.isUserInteractionEnabled {
            print("====OTP Entered===", self.OTP)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserInfoViewController") as! UserInfoViewController
            navigationController?.pushViewController(vc, animated: true)
        }
        else {
            print("OTP disabled")
        }
    }
    
    @IBAction func resendOTPPressed(_ sender: Any) {
        otpTextField1.text = nil
        otpTextField2.text = nil
        otpTextField3.text = nil
        otpTextField4.text = nil
        
        gradientBackgroundImage.image = UIImage(named: "Rectangle 161") // locked
        verifyButton.disabled()
        
        otpTextField1.becomeFirstResponder()
    }
    
}


extension OTPViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection  otp")
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing otp")
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inputValidation = otpInputValidation(textField: textField, replacementString: string)
        return inputValidation
    }

}
