//
//  AnnounceViewController.swift
//  SocialInnovationChallenge
//
//  Created by Isabela Modesto on 06/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import Foundation
import UIKit

class AnnounceViewController: UIViewController {
    

    //MARK: Properties
    var vacancies = [Vacancy]()
    var filteredVacancies = [Vacancy]()
    let searchController = UISearchController(searchResultsController: nil)
    
    let company = Company(name: "PanoSocial",
                          foundationDate: 2005,
                          region: "Campinas, SP",
                          photo: nil,
                          description: "Irá auxiliar no corte e costura, atendendo prazos estabelecidos e zelando pela organizaçao e limpeza dos equipamentos",
                          site: nil,
                          sectors: "Costura; Corte; Limpeza",
                          contact: "(019)3263-6537",
                          vancancies: nil)
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
  
    @IBAction func buttonCreateAnnounce(_ sender: Any) {
         performSegue(withIdentifier: "createAnnounceSegue", sender: self)
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
        
        VacancyServices.getAll { (error, vacancies) in
            
            if let error = error {
                print("Error loading document: \(error.localizedDescription)")
            } else {
                self.vacancies  = vacancies!
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                }
            }
        }
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
        detailViewController.segueIdentifier = "showDetailSegue"
        
        if segue.identifier == "showDetailSegue",
            let vacancyDetails = segue.destination as? DetailViewController {
            vacancyDetails.titleSaveButton = ""
            vacancyDetails.isHiddenSaveButton = true
            
        }
    }
    
    @IBAction func unwindToAnnounce(segue:UIStoryboardSegue) { }
}

//MARK: Extension
extension AnnounceViewController: UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VacancyTableViewCell
        else { //safely unwraps the optional
            fatalError("The dequeued cell is not an instance of VacancyTableViewCell.")
        }
        
        
        // Fetches the appropriate living being for the data source layout.
        if isFiltering() {
            vacancy = filteredVacancies[indexPath.row]
        } else {
            vacancy = vacancies[indexPath.row]
        }
        
        // configuring the cell -> sets each of the views in the table view cell to display the corresponding data
        cell.nameVacancyLabel.text = vacancy.name
        cell.numberOfVacanciesLabel.text = "\(vacancy.numberOfVacancies) vagas"
        cell.timeReleaseLabel.text = "anunciada há \(vacancy.releaseTime) dias"
        
        if !vacancy.isActivated {
            cell.isActivatedLabel.textColor = .red
            cell.isActivatedLabel.text = "Inativo"
            
            cell.ballView.backgroundColor = .red
        } else {
            cell.isActivatedLabel.textColor = .green
            cell.isActivatedLabel.text = "Ativo"
            cell.ballView.backgroundColor = .green
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
        
        self.performSegue(withIdentifier: "showDetailSegue", sender: vacancy)
    }
}

