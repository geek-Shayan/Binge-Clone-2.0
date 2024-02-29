//
//  UIView+Extension.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 21/8/23.
//

import UIKit


// MARK: Custom UIView fade in/out animation extension

extension UIView {
   func fadeIn() {
       // Move our fade out code from earlier
       UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn, animations: {
           self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
           }, completion: nil)
    }

    func fadeOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: nil)
    }
}
