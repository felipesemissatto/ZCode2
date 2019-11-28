//
//  DetailViewController.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 18/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var vacancy: Vacancy?
    var segueIdentifier: String = ""
    
    var titleSaveButton: String = "Publicar"
    var isHiddenSaveButton: Bool = false
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.title = vacancy?.company.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Setup the Announce Button
        self.saveButton.setTitle(titleSaveButton, for: .normal)
        self.saveButton.isHidden = self.isHiddenSaveButton
        saveButton.layer.cornerRadius = 4
        saveButton.layer.zPosition = 10
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableViewShowDetailSegue" {
            if let vacancyDetailsVC = segue.destination as? VacancyDetailsViewController {
                //Some property on ChildVC that needs to be set
                vacancyDetailsVC.vacancy = self.vacancy
            }
        }
    }
    
    //Func for write in Firebase
    @IBAction func writeFirebase(_ sender: Any) {
        
        VacancyServices.createVacancy(vacancy: self.vacancy!) { (error, vacancy ) in
            
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
    

    
    //MARK: Alert
    func errorAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Desculpa, não foi possível cadastrar.",
                                      preferredStyle: .alert)
        let buttonAdd = UIAlertAction(title: "Ok", style: .cancel) { (action) in

        }
        alert.addAction(buttonAdd)
        present(alert, animated: true, completion: nil)
    }
    
    func successAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Parabéns! Sua vaga foi anunciada com sucesso.",
                                      preferredStyle: .alert)
        let buttonAdd = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            self.performSegue(withIdentifier: "unwindSegueToAnnounce", sender: self)
        }
        alert.addAction(buttonAdd)
        present(alert, animated: true, completion: nil)
    }
}
