//
//  DetailViewController.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 18/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class DetailViewController: UIViewController {

    var vacancy: Vacancy?
    var segueIdentifier: String?
    
    var titleSaveButton: String = "Publicar"
    var isHiddenSaveButton: Bool = false
    
    var db = Firestore.firestore()
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let uid = (Auth.auth().currentUser?.uid)!
        let docRef = db.collection("company").document(uid)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let name = document.get("name") as! String
                self.title = name
            } else {
                print("Document does not exist")
            }
        }
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
        
        //Changing status bar color
        navigationController?.navigationBar.prefersLargeTitles = false
        UIApplication.shared.statusBarStyle = .darkContent

        if #available(iOS 13.0, *) {
            
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "tableViewShowDetailSegue" {
            if let vacancyDetailsVC = segue.destination as? VacancyDetailsViewController {
                //Some property on ChildVC that needs to be set
                vacancyDetailsVC.vacancy = self.vacancy
                if segueIdentifier == "showDetailSegue" {
                    vacancyDetailsVC.segueIdentifier = segueIdentifier
                }
            }
//        }
    }
    
    //Func for write in Firebase
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
    
    //MARK: Alert
    func errorAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Desculpa, não foi possível cadastrar.",
                                      preferredStyle: .alert)
        let buttonAdd = UIAlertAction(title: "OK", style: .cancel) { (action) in

        }
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
}
