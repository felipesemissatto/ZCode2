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
    var type: String?
    
    
    //MARK: Outlets
    
    @IBOutlet weak var egressButton: UIButton!
    @IBOutlet weak var companyButton: UIButton!

    
    //MARK: Views

    override func viewDidLoad() {
        super.viewDidLoad()
        
        egressButton.layer.cornerRadius = 10
        companyButton.layer.cornerRadius = 10
        
        
        if let option = defaults.object(forKey: "option") as? String {
            
            var vc : UIViewController? = nil
            
            if option == "egress" {
                let storyboard = UIStoryboard(name: "RootEgress", bundle: nil)
                
                //select the RootCompany view controller
                vc = storyboard.instantiateViewController(identifier: "HomeEgress")
                
            }
            else {
                let storyboard = UIStoryboard(name: "RootCompany", bundle: nil)
                
                //select the RootEgress view controller
                vc = storyboard.instantiateViewController(identifier: "HomeCompany")
            }
            
            //present the selected view controller
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = vc
                window.makeKeyAndVisible()
            }
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func tapEgressButton(_ sender: Any) {
        self.type = "egress"
        
        self.defaults.set(self.type!, forKey: "option")
        self.performSegue(withIdentifier: "egressSegue", sender: self)
    }
    
    
    @IBAction func tapCompanyButton(_ sender: Any) {
        self.type = "company"
        
        self.defaults.set(self.type!, forKey: "option")
        self.performSegue(withIdentifier: "companySegue", sender: self)
        
    }
    
    //MARK: Functions
    
    //add a gradient layer as background - NÃO FUNCIONA AINDA
    func addGradientLayer(){
        let layer = CAGradientLayer()
        layer.frame = self.view.bounds
        layer.colors = [UIColor.yellow.cgColor, UIColor.green.cgColor]
        
        layer.startPoint = CGPoint(x: 0,y: 0)
        layer.endPoint = CGPoint(x: 1,y: 1)
        
        view.layer.addSublayer(layer)
    }
}

