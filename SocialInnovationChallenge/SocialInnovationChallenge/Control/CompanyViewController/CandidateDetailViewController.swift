//
//  CandidateDetailViewController.swift
//  SocialInnovationChallenge
//
//  Created by Isabela Modesto on 26/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import Foundation
import UIKit

class CandidateDetailViewController : UIViewController{
    //MARK: Properties
    
    var egress : Egress?
    //MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var inviteButton: UIButton!
    
    //MARK: Views
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inviteButton.layer.cornerRadius = 4
        nameLabel.text = egress!.name
        descriptionTextView.text = egress!.description
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.layer.zPosition = -1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.layer.zPosition = 0
    }

    
    //MARK: Actions
    @IBAction func inviteTapped(_ sender: Any) {
    }
    
    @IBAction func backTapped(_ sender: Any) {
         performSegue(withIdentifier: "unwindToCandidates", sender: nil)
    }
    //MARK: Functions
}
