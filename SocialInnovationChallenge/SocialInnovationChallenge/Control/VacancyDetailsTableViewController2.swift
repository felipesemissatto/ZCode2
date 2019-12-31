//
//  VacancyDetailsTableViewController2.swift
//  SocialInnovationChallenge
//
//  Created by Felipe Semissatto on 01/12/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class VacancyDetailsTableViewController2: UITableViewController {

    //MARK: Properties
    var vacancy: Vacancy?
    var screenBefore: Bool? // true -> Vacancy; false -> Company
    var segueIdentifier: String?
    var isHiddenSaveButton: Bool = false
//    var currentUserID: String?
    
    //MARK: Outlets
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var applyButton: UIButton!
    
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
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
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
        nameCompanyLabel.text = vacancy?.companyName
        regionLabel.text = vacancy?.region
        salaryLabel.text = vacancy?.salary
        releaseTimeLabel.text = "há \(vacancy!.releaseTime) dias atrás"
        workdayLabel.text = vacancy?.workday
        benefitsLabel.text = vacancy?.benefits
        startWorkLabel.text = vacancy?.startWork
        descriptionLabel.text = vacancy?.description
        typeOfWorkLabel.text = vacancy?.typeOfWork
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Setup the Announce Button
        if !self.isHiddenSaveButton {
            self.saveButton.isEnabled = true
            self.saveButton.title = "Publicar"
        } else {
            
            self.saveButton.isEnabled = false
            self.saveButton.title = ""
        }
        
        if self.vacancy?.isActivated ?? true {
            self.activatedSwitch.isOn = true
        } else {
            self.activatedSwitch.isOn = false
        }
        
        settingApplyButton()
    }
    
    func settingApplyButton() {
        var candidate: String?
        
        getCurrentUserId() { (currentUserID) in
            if currentUserID == nil {
                print("Func candidates: Not found current user id")
            } else {
                candidate = currentUserID!
            }
        }
        
        for item in self.vacancy!.candidateList {
            if candidate == item {
                applyButton.setTitle("Você já se candidatou!",for: .normal)
                applyButton.setTitleColor(UIColor(displayP3Red: 129/255, green: 129/255, blue: 129/255, alpha: 1), for: .normal)
                applyButton.backgroundColor = UIColor(displayP3Red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
                applyButton.isEnabled = false
            } else {
                applyButton.setTitle("Quero me candidatar",for: .normal)
                applyButton.setTitleColor(UIColor(displayP3Red: 251/255, green: 251/255, blue: 251/255, alpha: 1), for: .normal)
                applyButton.backgroundColor = UIColor(displayP3Red: 1/255, green: 196/255, blue: 89/255, alpha: 1)
                applyButton.isEnabled = true
            }
        }
    }
    
    func getCurrentUserId(completion: @escaping (_ currentUserId: String?) -> (Void)) {
        
        UserServices.getCurrentUserId { (currentUserId) in
            if currentUserId == nil {
                print("Func getCurrentUserId: Not found current user id")
                completion(nil)
            } else {
                completion(currentUserId)
            }
        }
    }
    
    //MARK: Actions
    @IBAction func tapApplyNow(_ sender: Any) {
        
        getCurrentUserId() { (currentUserID) in
            if currentUserID == nil {
                print("Func candidates: Not found current user id")
            } else {
                self.vacancy?.candidateList.append(currentUserID!)
            }
        }
        
        CandidateServices.apply(self.vacancy!.documentID!, self.vacancy!.candidateList) { (error, applySuccess) in
            if applySuccess == false {
                print("Func tapApplyNow")
                self.errorAlert()
            } else {
                self.applyAlert()
            }
        }
    }
    
    @IBAction func writeFirebase(_ sender: Any) {
        VacancyServices.create(vacancy: self.vacancy!) { (error, vacancy ) in
            
            if let err = error {
                print("Error adding document: \(err.localizedDescription)")
                self.errorAlert()
            } else {
                self.vacancy = vacancy
                print("Sucesso")
                self.successAlert()
            }
        }
    }
    
    @IBAction func isActivatedVacancy(_ sender: Any) {
        
        let isActivated = self.activatedSwitch.isOn
        let documentId = self.vacancy!.documentID!
        
        if isActivated {
            VacancyServices.isActivated(isActivated, documentId) { (error) in
                    if let err = error {
                        print("Error adding document: \(err.localizedDescription)")
                    } else {
                        print("Sucesso")
                    }
            }
        } else {
            VacancyServices.isActivated(isActivated, self.vacancy!.documentID!) { (error) in
                    if let err = error {
                        print("Error adding document: \(err.localizedDescription)")
                    } else {
                        print("Sucesso")
                    }
            }
        }
    }
    
    //MARK: Alert
    func errorAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Desculpa, não foi possível cadastrar.",
                                      preferredStyle: .alert)
        let buttonAdd = UIAlertAction(title: "OK", style: .cancel) //{ (action) in

       // }
        alert.addAction(buttonAdd)
        present(alert, animated: true, completion: nil)
    }
    
    func successAlert() {
        let alert = UIAlertController(title: "Parabéns!",
                                      message: "Sua vaga foi anunciada.\nAgora é só aguardar os candidatos.",
                                      preferredStyle: .alert)
        let buttonAdd = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.performSegue(withIdentifier: "unwindSegueToAnnounce", sender: self)
        }
        alert.addAction(buttonAdd)
        present(alert, animated: true, completion: nil)
    }
    
    func applyAlert() {
        let alert = UIAlertController(title: "Parabéns!",
                                      message: "Você acabou a se candidatar a vaga. Agora é só aguardar o retorno.",
                                      preferredStyle: .alert)
        let buttonAdd = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.applyButton.setTitle("Você já se candidatou!",for: .normal)
            self.applyButton.setTitleColor(UIColor(displayP3Red: 129/255, green: 129/255, blue: 129/255, alpha: 1), for: .normal)
            self.applyButton.backgroundColor = UIColor(displayP3Red: 222/255, green: 222/255, blue: 222/255, alpha: 1)
            self.applyButton.isEnabled = false
        }
        alert.addAction(buttonAdd)
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight:CGFloat = 0.0
        
        if indexPath.row == 0 && screenBefore == true{
            self.saveButton.isEnabled = false
            self.saveButton.title = ""
            self.cell1.isHidden = true
            rowHeight = 0.0
        } else if indexPath.row == 1 && screenBefore == false{
            buttonApplyNow.isHidden = true
            viewLine.isHidden = true
            topConstraint.constant = 0
            bottomConstraint.isActive = false
            rowHeight = UITableView.automaticDimension
        } else{
            rowHeight = UITableView.automaticDimension
        }
        return rowHeight
    }
}
