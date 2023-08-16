//
//  TermsAndConditionsLabel.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 16/8/23.
//

import UIKit

class TermsAndConditionsLabel: UILabel {
    
    var privacyTapped: (() -> Void)? = nil
    var termsTapped: (() -> Void)? = nil
    
    var isTapped: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayers()
    }
    
    private func setupLayers() {
        self.isUserInteractionEnabled = true
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(tappedOnLabel(_ :)))
        tapgesture.numberOfTapsRequired = 1
        self.addGestureRecognizer(tapgesture)
    }

    //MARK:- tappedOnLabel
    @objc func tappedOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let text = self.text else { return }
        let privacyPolicyRange = (text as NSString).range(of: "Privacy Notice")
        let termsAndConditionRange = (text as NSString).range(of: "Terms and conditions")
        
        if gesture.didTapAttributedTextInLabel(label: self, inRange: privacyPolicyRange) {
            print("user tapped on privacy policy text")
            isTapped.toggle()
            privacyTapped?()
        }
        else if gesture.didTapAttributedTextInLabel(label: self, inRange: termsAndConditionRange){
            print("user tapped on terms and conditions text")
            isTapped.toggle()
            termsTapped?()
        }
        else {
            isTapped = false
        }
    }
}
