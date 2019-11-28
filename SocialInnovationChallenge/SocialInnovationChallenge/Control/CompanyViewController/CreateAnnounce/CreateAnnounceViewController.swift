//
//  CreateAnnounceViewController.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 07/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class CreateAnnounceViewController: UIViewController {
    
    //MARK: Properties
    
    let company = Company(name: "PanoSocial",
                          foundationDate: 2005,
                          region: "Campinas, SP",
                          photo: nil,
                          description: "Irá auxiliar no corte e costura, atendendo prazos estabelecidos e zelando pela organizaçao e limpeza dos equipamentos",
                          site: nil,
                          sectors: "Costura; Corte; Limpeza",
                          contact: "(019)3263-6537",
                          vancancies: nil)
    
    var vacancy: Vacancy?
    
    var createDataPicker: CreateDataPicker = CreateDataPicker()
    var dataPicker: [String] = [String]()
    var selecteData: String?
    
    // MARK: Outlet
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var numberOfVacanciesTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var typeOfWorkTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var workdayTextField: UITextField!
    @IBOutlet weak var benefitsTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        self.nameTextField.customTextField()
        self.regionTextField.customTextField()
        self.numberOfVacanciesTextField.customTextField()
        self.descriptionTextField.customTextField()
        self.typeOfWorkTextField.customTextField()
        self.salaryTextField.customTextField()
        self.workdayTextField.customTextField()
        self.benefitsTextField.customTextField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNotifications()
        
        hideKeyboardWhenTappedAround()
      
        createDataPicker.createPicker(category: workdayTextField, delegate: self)
        createDataPicker.createToolBar(category: workdayTextField, viewController: self)
        dataPicker = ["Integral", "Noturno"]
        
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let selected =  sender as? Vacancy else {
            return
        }
        
        guard let detailViewController = segue.destination as? DetailViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }

        detailViewController.vacancy = selected
        detailViewController.segueIdentifier = "visualizeDetailSegue"

    }
    
    @IBAction func visualize(_ sender: Any) {
        if self.nameTextField.text?.isEmpty ?? false ||
           self.regionTextField.text?.isEmpty ?? false ||
           self.numberOfVacanciesTextField.text?.isEmpty ?? false ||
           self.descriptionTextField.text?.isEmpty ?? false ||
           self.typeOfWorkTextField.text?.isEmpty ?? false ||
           self.salaryTextField.text?.isEmpty ?? false ||
           self.workdayTextField.text?.isEmpty ?? false ||
           self.benefitsTextField.text?.isEmpty ?? false {
        
           fillAlert()
        } else {
            
            self.vacancy = Vacancy(company: company)
            self.vacancy?.name = self.nameTextField.text!
            self.vacancy?.region = self.regionTextField.text!
            self.vacancy?.numberOfVacancies = self.numberOfVacanciesTextField.text!
            self.vacancy?.description = self.descriptionTextField.text!
            self.vacancy?.typeOfWork = self.typeOfWorkTextField.text!
            self.vacancy?.salary = self.salaryTextField.text!
            self.vacancy?.workday = self.workdayTextField.text!
            self.vacancy?.benefits = self.benefitsTextField.text!
            
            self.performSegue(withIdentifier: "visualizeDetailSegue", sender: self.vacancy)
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        
        self.dismissKeyboard()
        
        if self.nameTextField.text == "" &&
           self.regionTextField.text == "" &&
           self.numberOfVacanciesTextField.text == "" &&
           self.descriptionTextField.text == "" &&
           self.typeOfWorkTextField.text == "" &&
           self.salaryTextField.text == "" &&
           self.workdayTextField.text == "" &&
           self.benefitsTextField.text == "" {
        
           self.performSegue(withIdentifier: "unwindSegueToAnnounce", sender: self)
        } else {
            cancelAlert()
        }
    }
    
    //MARK: Alert
    func fillAlert() {
        let alert = UIAlertController(title: nil,
                                      message: "Por favor, preencha todos os campos!",
                                      preferredStyle: .alert)
        let buttonAdd = UIAlertAction(title: "Ok", style: .cancel) { (action) in
            print("ok")
        }
        alert.addAction(buttonAdd)
        present(alert, animated: true, completion: nil)
    }
    
    func cancelAlert () {
        let alert = UIAlertController(title: nil,
                                      message: "Tem certeza de que deseja descartar esta nova vaga?",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Continuar Editando", style: .cancel) { (action) in })
        alert.addAction(UIAlertAction(title: "Ignorar Alterações", style: .destructive) { (action) in
            self.performSegue(withIdentifier: "unwindSegueToAnnounce", sender: self)
        })
        present(alert, animated: true, completion: nil)
    }
}

extension UITextField {
    func customTextField() {
        self.layer.cornerRadius = 10.0
        self.layer.borderWidth = 0.7
        self.layer.borderColor = UIColor(red: 230/255, green: 232/255, blue: 241/255, alpha: 1.0).cgColor
        self.layer.masksToBounds = true
    }
}

extension CreateAnnounceViewController {
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        guard let keyboardFrame = notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        scrollView.contentInset.bottom = view.convert(keyboardFrame.cgRectValue, from: nil).size.height
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        scrollView.contentInset.bottom = 0
    }
}

