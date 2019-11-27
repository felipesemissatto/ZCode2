//
//  ViewController + HideKeyboard.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 08/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
