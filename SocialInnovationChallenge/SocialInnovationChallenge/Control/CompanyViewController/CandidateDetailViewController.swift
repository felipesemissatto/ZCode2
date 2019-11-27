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
    @IBOutlet weak var dreamLabel0: UILabel!
    @IBOutlet weak var dreamLabel1: UILabel!
    @IBOutlet weak var dreamLabel2: UILabel!
    
    //MARK: Views
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inviteButton.layer.cornerRadius = 4
        nameLabel.text = egress!.name
        descriptionTextView.text = egress!.description
        dreamLabel0.text! = egress!.desires![0]
        dreamLabel1.text! = egress!.desires![1]
        dreamLabel2.text! = egress!.desires![2]

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    //MARK: Actions
    @IBAction func inviteTapped(_ sender: Any) {
        dialNumber(number: "5519993085702") //número pra teste
    }
    
    @IBAction func backTapped(_ sender: Any) {
         performSegue(withIdentifier: "unwindToCandidates", sender: nil)
    }
    //MARK: Functions
    
    func dialNumber(number : String) {
        if let url = URL(string: "https://api.whatsapp.com/send?phone=\(number)&text=teste"),
            UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
        }
        else {
                // add error message here
        }
    }
    
//    link bom que ensina a criar alertas: https://medium.com/swift-india/uialertcontroller-in-swift-22f3c5b1dd68
}
