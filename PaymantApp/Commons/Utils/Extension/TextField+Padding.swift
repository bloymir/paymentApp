//
//  TextField+Padding.swift
//  PaymantApp
//
//  Created by nelson tapia on 24-02-23.
//

import UIKit

extension UITextField {
    func padding(_ withPadding: CGFloat = 10){
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: withPadding, height: 0))
        leftViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: withPadding, height: 0))
        rightViewMode = .always
    }
}
