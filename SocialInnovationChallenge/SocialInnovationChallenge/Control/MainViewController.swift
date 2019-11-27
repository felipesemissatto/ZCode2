//
//  ViewController.swift
//  SocialInnovationChallenge
//
//  Created by Felipe Semissatto on 04/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    
    //MARK: Properties
    let defaults = UserDefaults.standard
    var email: String?
    var password: String?
    var identifierSegue: String?
    var type: String?
    
    //MARK: Outlets
    @IBOutlet weak var segmentControlUser: UISegmentedControl!
    
    //MARK: Views
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let option = defaults.object(forKey: "option") as? String {
            if option == "egress" {
                performSegue(withIdentifier: "egressSegue", sender: self)
            } else {
                performSegue(withIdentifier: "companySegue", sender: self)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        segmentControl()
    }
    
    //MARK: Actions
    @IBAction func tapEnter(_ sender: Any) {
        
        segmentControl()
        
        let emailAuth = self.email?.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordAuth = self.password?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: emailAuth!, password: passwordAuth!) { (result, error) in
            if error != nil {
                print("Senha incorreta")
            } else {
                self.defaults.set(self.type!, forKey: "option")
                self.performSegue(withIdentifier: self.identifierSegue!, sender: self)
            }
        }
    }
    
    //Define informações do login e fluxo (egresso ou compania)
    func segmentControl () {
        switch segmentControlUser.selectedSegmentIndex{
        case 0:
            self.email = "egresso@gmail.com"
            self.password = "egresso"
            self.identifierSegue = "egressSegue"
            self.type = "egress"
        case 1:
            self.email = "empresa@gmail.com"
            self.password = "empresa"
            self.identifierSegue = "companySegue"
            self.type = "company"
        default:
            break;
        }
    }
    
//    let userID = Auth.auth().currentUser!.uid
//    override func viewDidDisappear(_ animated: Bool) {
//        print("ID: \(userID)")
//    }
}

