//
//  VacancyViewController.swift
//  SocialInnovationChallenge
//
//  Created by Isabela Modesto on 06/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

class VacancyViewController: UIViewController {
    
    //MARK: Properties
    var vacancies = [Vacancy]()
    var filteredVacancies = [Vacancy]()
    let searchController = UISearchController(searchResultsController: nil)
    
    let company = Company(name: "PanoSocial",
                          foundationDate: 2005,
                          region: "Campinas, SP",
                          photo: "",
                          description: "Irá auxiliar no corte e costura, atendendo prazos estabelecidos e zelando pela organizaçao e limpeza dos equipamentos",
                          site: nil,
                          sectors: "Costura; Corte; Limpeza",
                          contact: "(019)3263-6537",
                          vancancies: nil)
    
    let db = Firestore.firestore()
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = true
        
        //Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Busque uma vaga aqui"
        searchController.searchBar.searchTextField.backgroundColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //Changing status bar color
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            navBarAppearance.backgroundColor = UIColor(displayP3Red: 1/255, green: 196/255, blue: 89/255, alpha: 1)
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadVacancies()
                
//        VacancyServices.getAllVacancy { (error, vacancies) in
//            self.vacancies  = vacancies!
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
    }
    
    //MARK: Search Controller's Methods
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredVacancies = vacancies.filter({( vacancy : Vacancy) -> Bool in
            return vacancy.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    //MARK: Functions
    private func loadVacancies() {
        indicatorActivity.startAnimating()
        VacancyServices.getAll { (error, vacancies) in
            
            if let error = error {
                print("Error loading document: \(error.localizedDescription)")
            } else if let vacancies = vacancies {
                self.vacancies = vacancies.filter({ (vacancy) -> Bool in
                    return vacancy.isActivated
                })
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.indicatorActivity.stopAnimating()
                        self.shadowView.isHidden = true
                        self.indicatorActivity.isHidden = true
                }
            }
        }
    }

    
    
    private func loadSampleVacancies(){
//        let vacancy1 = Vacancy(name: "Operador de Máquinas")
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard let selected =  sender as? Vacancy else {
            return
        }

        guard let livingBeingDetailViewController = segue.destination as? VacancyDetailsTableViewController2 else {
            fatalError("Unexpected destination: \(segue.destination)")
        }

        livingBeingDetailViewController.vacancy = selected
        livingBeingDetailViewController.screenBefore = true

        if segue.identifier == "segueDetailsVacancy",
            let vacancyDetails = segue.destination as? DetailViewController {
            vacancyDetails.titleSaveButton = ""
            vacancyDetails.isHiddenSaveButton = true
        }
    }

}

//MARK: Extension
extension VacancyViewController: UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    // MARK: Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        if isFiltering() {
            count = filteredVacancies.count
        } else {
            count = vacancies.count
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TableViewCell"
        var vacancy: Vacancy
        
        // Downcast
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VacancyEgressTableViewCell
        else { //safely unwraps the optional
            fatalError("The dequeued cell is not an instance of VacancyEgressTableViewCell.")
        }
        
        
        // Fetches the appropriate living being for the data source layout.
        if isFiltering() {
            vacancy = filteredVacancies[indexPath.row]
        } else {
            vacancy = vacancies[indexPath.row]
        }
        
        // configuring the cell -> sets each of the views in the table view cell to display the corresponding data
        if let filePath = Bundle.main.path(forResource: "imageName", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
            cell.imageCompany.contentMode = .scaleAspectFit
            cell.imageCompany.image = image
        }
        cell.nameVacancyLabel.text = vacancy.name
        cell.nameCompanyLabel.text = vacancy.company.name
        cell.regionLabel.text = vacancy.region
        cell.workdayLabel.text = vacancy.workday
        cell.timeReleaseLabel.text = "há \(vacancy.releaseTime) dias atrás"
        
        // Add photo  profile
        if vacancy.company.photo != "" {
            let imageUrl = vacancy.company.photo
            let url = NSURL(string: imageUrl)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in

                if error != nil {
                    print(error)
                    return
                }
                
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        cell.imageCompany?.contentMode = .scaleAspectFit
                        cell.imageCompany?.image = UIImage(data: data!)
                    }
                }
            }).resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var vacancy: Vacancy

        // Fetches the appropriate living being for the data source layout.
        if isFiltering() {
            vacancy = filteredVacancies[indexPath.row]
        } else {
            vacancy = vacancies[indexPath.row]
        }

        self.performSegue(withIdentifier: "segueDetailsVacancy", sender: vacancy)
    }
}

