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
    var screenBefore: Bool? // true -> Vacancy; false ->
    
    //MARK: Outlets
    //cell1
    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var activatedSwitch: UISwitch!
    
    //cell2
    @IBOutlet weak var cell2: UITableViewCell!
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

        //Button corner radius
        self.buttonApplyNow.layer.cornerRadius = 6

//        activatedSwitch
        nameVacancyLabel.text = vacancy?.name
//        nameCompanyLabel.text = vacancy?.company.name
        regionLabel.text = vacancy?.region
        salaryLabel.text = vacancy?.salary
//        viewLine.isHidden = true or false
        releaseTimeLabel.text = "há \(vacancy?.releaseTime) dias atrás"
        workdayLabel.text = vacancy?.workday
        benefitsLabel.text = vacancy?.benefits
//        startWorkLabel.text = vacancy?.startWork
        descriptionLabel.text = vacancy?.description
        typeOfWorkLabel.text = vacancy?.typeOfWork
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
            db.collection("vacancy").document(self.vacancy!.ID!).updateData(["isActivated": true])
        } else {
            db.collection("vacancy").document(self.vacancy!.ID!).updateData(["isActivated": false])
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight:CGFloat = 0.0
        
        if indexPath.row == 0 && screenBefore == true{
            cell1.isHidden = true
            rowHeight = 0.0
        } else if indexPath.row == 1 && screenBefore == false{
            cell2.isHidden = true
            rowHeight = 0.0
        } else{
            rowHeight = UITableView.automaticDimension
        }
        return rowHeight
    }
}
