//
//  VacancyDetailsViewController.swift
//  SocialInnovationChallenge
//
//  Created by Felipe Semissatto on 08/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit
import FirebaseFirestore

class VacancyDetailsViewController: UITableViewController {

    //MARK: Properties
    var vacancy: Vacancy?
    var segueIdentifier: String = ""
    //MARK: Outlets
    
    @IBOutlet weak var vacancyNameLabel: UILabel!
    @IBOutlet weak var numberOfVacanciesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var typeOfWorkLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!
    @IBOutlet weak var workdayLabel: UILabel!
    @IBOutlet weak var benefitsLabel: UILabel!
    @IBOutlet weak var cellDescription: UITableViewCell!
    @IBOutlet weak var activatedSwitch: UISwitch!
    

    
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = vacancy?.company.name
        
        vacancyNameLabel.text = vacancy?.name
        numberOfVacanciesLabel.text = vacancy?.numberOfVacancies
        descriptionLabel.text = vacancy?.description
        regionLabel.text = vacancy?.company.region
        typeOfWorkLabel.text = vacancy?.typeOfWork
        salaryLabel.text = vacancy?.salary
        workdayLabel.text = vacancy?.workday
        benefitsLabel.text = vacancy?.benefits
        
        tableView.estimatedRowHeight = 150
        
       // cellDescription.frame.size.height = descriptionLabel.frame.size.height + 16
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.vacancy?.isActivated ?? true {
            self.activatedSwitch.isOn = true
        } else {
            self.activatedSwitch.isOn = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if segueIdentifier == "visualizeDetailSegue"{
            activated()
        }
    }
    
    func activated() {
        let db = Firestore.firestore()
        
        if self.activatedSwitch.isOn {
            // Adicionar um completion
            db.collection("vacancy").document(self.vacancy!.ID!).updateData(["isActivated": true])
        } else {
            db.collection("vacancy").document(self.vacancy!.ID!).updateData(["isActivated": false])
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}
