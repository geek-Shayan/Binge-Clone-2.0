//
//  UIViewController+Extension.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 21/8/23.
//

import UIKit


// MARK: Custom UIViewController dismiss keyboard when touching anywhere outside UITextField

extension UIViewController {
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}
