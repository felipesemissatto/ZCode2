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
    @IBOutlet weak var egressButton: UIButton!
    @IBOutlet weak var companyButton: UIButton!
    
    //MARK: Outlets
    @IBOutlet weak var segmentControlUser: UISegmentedControl!
    
    //MARK: Views
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        if let option = defaults.object(forKey: "option") as? String {
        //            if option == "egress" {
        //                performSegue(withIdentifier: "egressSegue", sender: self)
        //            } else {
        //                performSegue(withIdentifier: "companySegue", sender: self)
        //            }
        //        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        egressButton.layer.cornerRadius = 10
        companyButton.layer.cornerRadius = 10
        
        
        if let option = defaults.object(forKey: "option") as? String {
            
            var vc : UIViewController? = nil
            
            if option == "egress" {
                let storyboard = UIStoryboard(name: "RootEgress", bundle: nil)
                
                vc = storyboard.instantiateViewController(identifier: "HomeEgress")
                
            } else {
                
                let storyboard = UIStoryboard(name: "RootCompany", bundle: nil)
                
                vc = storyboard.instantiateViewController(identifier: "HomeCompany")
                
                
            }
            
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = vc
                window.makeKeyAndVisible()
            }
        }
        
        
    }
    
    
    //MARK: Actions
    
    @IBAction func tapEgressButton(_ sender: Any) {
        self.email = "egresso@gmail.com"
        self.password = "egresso"
        self.identifierSegue = "egressSegue"
        self.type = "egress"
        
        self.defaults.set(self.type!, forKey: "option")
        self.performSegue(withIdentifier: self.identifierSegue!, sender: self)
    }
    
    
    @IBAction func tapCompanyButton(_ sender: Any) {
        self.email = "empresa@gmail.com"
        self.password = "empresa"
        self.identifierSegue = "companySegue"
        self.type = "company"
        
        self.defaults.set(self.type!, forKey: "option")
        self.performSegue(withIdentifier: self.identifierSegue!, sender: self)
        
    }
    
    //não sei se posso apagar essa parte
    //    @IBAction func tapEnter(_ sender: Any) {
    //
    //        segmentControl()
    //
    //        let emailAuth = self.email?.trimmingCharacters(in: .whitespacesAndNewlines)
    //        let passwordAuth = self.password?.trimmingCharacters(in: .whitespacesAndNewlines)
    //
    //        Auth.auth().signIn(withEmail: emailAuth!, password: passwordAuth!) { (result, error) in
    //            if error != nil {
    //                print("Senha incorreta")
    //            } else {
    //                self.defaults.set(self.type!, forKey: "option")
    //                self.performSegue(withIdentifier: self.identifierSegue!, sender: self)
    //            }
    //        }
    //    }
    
    //MARK: Functions
    
    func addGradientLayer(){
        let layer = CAGradientLayer()
        layer.frame = self.view.bounds
        layer.colors = [UIColor.yellow.cgColor, UIColor.green.cgColor]
        
        layer.startPoint = CGPoint(x: 0,y: 0)
        layer.endPoint = CGPoint(x: 1,y: 1)
        
        view.layer.addSublayer(layer)
    }
    
    
    
    //    let userID = Auth.auth().currentUser!.uid
    //    override func viewDidDisappear(_ animated: Bool) {
    //        print("ID: \(userID)")
    //    }
}

