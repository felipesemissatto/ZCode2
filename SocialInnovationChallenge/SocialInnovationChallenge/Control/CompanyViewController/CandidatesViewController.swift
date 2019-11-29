//
//  CandidatesViewController.swift
//  SocialInnovationChallenge
//
//  Created by Isabela Modesto on 06/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore

class CandidatesViewController: UIViewController {
    
    //MARK: Properties
    var egress = [Egress]()
    var egressSelected: Egress?
    var filteredEgress = [Egress]()
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
    
    let db = Firestore.firestore()
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Views
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.tabBarController?.tabBar.isHidden = false
//        self.tabBarController?.tabBar.layer.zPosition = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadEgress()
        
        //Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Busque um candidato aqui"
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

    //MARK: Actions
    
    @IBAction func unwindToCandidates(segue : UIStoryboardSegue){}

    
    //MARK: Search Controller's Methods
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredEgress = egress.filter({( egress : Egress) -> Bool in
            return egress.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    //MARK: Functions
    private func loadEgress(){

        EgressServices.getAll { (error, egress) in
            
            if let error = error {
                print("Error loading document: \(error.localizedDescription)")
            } else {
                self.egress = egress!
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "CandidateDetail"{
            let candidateDetail = segue.destination as! CandidateDetailViewController
            
            if egressSelected != nil{
                candidateDetail.egress = egressSelected
            }
        }
    }
    
}

//MARK: Extension
extension CandidatesViewController: UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    // MARK: Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        
        if isFiltering() {
            count = filteredEgress.count
        } else {
            count = egress.count
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TableViewCell"
        var egressSelected: Egress
        
        // Downcast
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CandidateTableViewCell
        else { //safely unwraps the optional
            fatalError("The dequeued cell is not an instance of CandidateTableViewCell.")
        }
        
        
        // Fetches the appropriate living being for the data source layout.
        if isFiltering() {
            egressSelected = filteredEgress[indexPath.row]
        } else {
            egressSelected = egress[indexPath.row]
        }
        
        // configuring the cell -> sets each of the views in the table view cell to display the corresponding data
        if let filePath = Bundle.main.path(forResource: "imageName", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
            cell.imageEgress?.contentMode = .scaleAspectFit
            cell.imageEgress?.image = image
        }
        cell.nameLabel.text = egressSelected.name
        cell.nameRegion?.text = egressSelected.region
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Fetches the appropriate living being for the data source layout.
        if isFiltering() {
            egressSelected = filteredEgress[indexPath.row]
        } else {
            egressSelected = egress[indexPath.row]
        }

        self.performSegue(withIdentifier: "CandidateDetail", sender: egressSelected)
    }
}
