//
//  UINavigationBar+Extension.swift
//  Binge Clone 2.0
//
//  Created by MD. SHAYANUL HAQ SADI on 21/8/23.
//

import UIKit


// MARK: Custom UINavigationBar layer toggle extension

extension UINavigationBar {
    func toggle() {
        if self.layer.zPosition == -1 {
            self.layer.zPosition = 0
            self.isUserInteractionEnabled = true
        } else {
            self.layer.zPosition = -1
            self.isUserInteractionEnabled = false
        }
    }
}
