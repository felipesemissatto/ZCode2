//
//  VacancyDetailsTableViewController2.swift
//  SocialInnovationChallenge
//
//  Created by Felipe Semissatto on 01/12/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit
import FirebaseFirestore

class VacancyDetailsTableViewController2: UITableViewController {

    //MARK: Properties
    var vacancy: Vacancy?
    
    //MARK: Outlets
    //cell1
    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var activatedSwitch: UISwitch!
    
    //cell2
    @IBOutlet weak var nameVacancyLabel: UILabel!
    @IBOutlet weak var nameCompanyLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var buttonApplyNow: UIButton!
    @IBOutlet weak var viewLine: UIView!
    
    //cell3
    @IBOutlet weak var releaseTimeLabel: UILabel!
    @IBOutlet weak var workdayLabel: UILabel!
    
    //cell4
    @IBOutlet weak var benefitsLabel: UILabel!
    
    //cell5
    @IBOutlet weak var startWorkLabel: UILabel!
    
    //cell6
    @IBOutlet weak var descriptionLabel: UILabel!
        
    //cell7
    @IBOutlet weak var typeOfWorkLabel: UILabel!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

//        activatedSwitch
        nameVacancyLabel.text = vacancy?.name
//        nameCompanyLabel.text = vacancy?.company.name
        regionLabel.text = vacancy?.company.region
        salaryLabel.text = vacancy?.salary
//        viewLine.isHidden = true or false
        releaseTimeLabel.text = "há \(vacancy?.releaseTime) dias atrás"
        workdayLabel.text = vacancy?.workday
        benefitsLabel.text = vacancy?.benefits
//        startWorkLabel.text = vacancy?.startWork
        descriptionLabel.text = vacancy?.description
        typeOfWorkLabel.text = vacancy?.typeOfWork
        
        tableView.estimatedRowHeight = 150
        
       // cellDescription.frame.size.height = descriptionLabel.frame.size.height + 16
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        activated()
    }
    
    //MARK: Actions
    @IBAction func tapApplyNow(_ sender: Any) {
        
    }
    
    //MARK: Functions
    func activated() {
        let db = Firestore.firestore()
        
        if self.activatedSwitch.isOn {
            // Adicionar um completion
        db.collection("vacancy").document("7sbbqrWigesWGF7Tha4R").updateData(["isActivated": true])
        } else {
            db.collection("vacancy").document("7sbbqrWigesWGF7Tha4R").updateData(["isActivated": false])
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
