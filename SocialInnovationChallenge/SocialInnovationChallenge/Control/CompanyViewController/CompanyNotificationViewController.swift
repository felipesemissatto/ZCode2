//
//  CompanyNotificationViewController.swift
//  SocialInnovationChallenge
//
//  Created by Isabela Modesto on 06/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseFirestore

class CompanyNotificationViewController: UIViewController {
    
    //MARK: Properties
    var vacancies = [Vacancy]()
    var egress = [Egress]()
    var egressSelected: Egress?
    var filteredEgress = [Egress]()
    var myUID: String?
    
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
    
    //MARK: Views
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadEgress()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        myUID = Auth.auth().currentUser?.uid
    }
    
    //MARK: Functions
    private func loadEgress(){
        
        var listCandidateUID = [String]()
        let db = Firestore.firestore()
        var egress:  Egress! = nil
        
//        canditates() { (error, listCandidate) in
//            if let error = error {
//                print("Error loading document: \(error.localizedDescription)")
//            } else {
//                listCandidateUID = listCandidate!
//
//                for candidateUID in listCandidateUID {
//                    db.collection("egress").whereField("documentID", isEqualTo: candidateUID).getDocuments() {
//                        (querySnapshot, err) in
//                        if let err = err {
//                            print("Error getting documents: \(err)")
//                        } else {
//                            print(candidateUID)
//                            print(querySnapshot?.documents)
//                            for document in querySnapshot!.documents {
//                                let name = document.get("name") as! String
//                                let region = document.get("region") as! String
//                                let description = document.get("description") as! String
//                                let contact = document.get("contact") as! [String]
//                                let desires = document.get("dreams") as! [String]
//                                let photo = document.get("photo") as! String
//                                let courses = document.get("courses") as! [String]
//                                let experiences = document.get("experiences") as! [String]
//
//                                egress = Egress(name: name,
//                                                dateOfBirth: "",
//                                                description: description,
//                                                region: region,
//                                                photo: photo,
//                                                video: nil,
//                                                courses: courses,
//                                                experiences: experiences,
//                                                skills: nil,
//                                                desires: desires,
//                                                contact: contact)
//
//                                self.egress.append(egress)
//                            }
//                            DispatchQueue.main.async {
//                                self.tableView.reloadData()
//                            }
//                        }
//                    }
//                }
//            }
//        }
        canditates() { (error, listCandidate) in
            if let error = error {
                print("Error loading document: \(error.localizedDescription)")
            } else {
                listCandidateUID = listCandidate!
                db.collection("egress").getDocuments() { (snapshot, err) in
                    if let error = err {
                        print("Error getting documents: \(error)")
                    } else {
                        self.egress = []

                        for document in snapshot!.documents {

                            let name = document.get("name") as! String
                            let region = document.get("region") as! String
                            let description = document.get("description") as! String
                            let contact = document.get("contact") as! [String]
                            let desires = document.get("dreams") as! [String]
                            let photo = document.get("photo") as! String
                            let courses = document.get("courses") as! [String]
                            let experiences = document.get("experiences") as! [String]

                            egress = Egress(name: name,
                                            dateOfBirth: "",
                                            description: description,
                                            region: region,
                                            photo: photo,
                                            video: nil,
                                            courses: courses,
                                            experiences: experiences,
                                            skills: nil,
                                            desires: desires,
                                            contact: contact)

                            self.egress.append(egress)
                        }

                        for egress in self.egress {
                            for uid in listCandidateUID {
                                if uid == egress.documentID{

                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func loadVacancies(completion: @escaping (_ error: Error?, _ vacancies: [Vacancy]?) -> (Void)) {
        
        VacancyServices.getAll { (error, vacancies) in
            
            if let error = error {
                completion(error, nil)
                print("Error loading document: \(error.localizedDescription)")
            } else {
                completion(nil, vacancies)
            }
        }
    }
    
    func canditates(completion: @escaping (_ error: Error?, _ listCandidate: [String]?) -> (Void)) {

        var listCandidates: [String] = []
        
        loadVacancies() { (error, vacancies) in
            if let error = error {
                print("Error loading document: \(error.localizedDescription)")
                completion(error, nil)
            } else {
                for vacancy in vacancies! {
                    if vacancy.UID == self.myUID {
                        listCandidates = listCandidates + vacancy.candidateList
                    }
                }

                completion(nil, listCandidates.removingDuplicates())
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
extension CompanyNotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return egress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //            tableView.register(CandidateTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "TableViewCell"
        var egressSelected: Egress
        
        // Downcast
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CandidateTableViewCell
            else { //safely unwraps the optional
                fatalError("The dequeued cell is not an instance of CandidateTableViewCell.")
        }
        
        
        // Fetches the appropriate living being for the data source layout.
        egressSelected = egress[indexPath.row]
        
        // configuring the cell -> sets each of the views in the table view cell to display the corresponding data
        if let filePath = Bundle.main.path(forResource: "imageName", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
            cell.imageEgress?.contentMode = .scaleAspectFit
            cell.imageEgress?.image = image
        }
        let normalText1 = "O candidato "
        let attributedString1 = NSMutableAttributedString(string:normalText1)
        
        let boldText1  = "\(egressSelected.name)"
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        let boldString1 = NSMutableAttributedString(string: boldText1, attributes:attrs)
        attributedString1.append(boldString1)
        
        let normalText2 = " possui interesse na vaga "
        let attributedString2 = NSMutableAttributedString(string:normalText2)
        attributedString1.append(attributedString2)
        
        let boldText2  = "\(String(describing: company.vancancies?[0].name))"
        let boldString2 = NSMutableAttributedString(string: boldText2, attributes:attrs)
        attributedString1.append(boldString2)
        
        cell.nameLabel.attributedText = attributedString1
        cell.nameRegion?.text = "\(company.vancancies?[0].releaseTime) d"
        
        // Add photo  profile
        if egressSelected.photo != "" {
            let profileImageUrl = egressSelected.photo
            let url = NSURL(string: profileImageUrl)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print(error)
                    return
                }
                
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        cell.imageEgress?.contentMode = .scaleAspectFit
                        cell.imageEgress?.image = UIImage(data: data!)
                    }
                }
            }).resume()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Fetches the appropriate living being for the data source layout.
        egressSelected = egress[indexPath.row]
        
        self.performSegue(withIdentifier: "CandidateDetail", sender: egressSelected)
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
