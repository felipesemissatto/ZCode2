//
//  CompanyNotificationViewController.swift
//  SocialInnovationChallenge
//
//  Created by Isabela Modesto on 06/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//
//  Problema com sincronia dos dados obtidos para pegar a lista de candidatos que se candidataram a alguma vaga a minha emrpesa
import UIKit
import FirebaseFirestore

class CompanyNotificationViewController: UIViewController {
    
    var testeVacancies = [Vacancy]()
    var testeListCandidates: [String] = []
    var testeListVacancy: [String] = []
    
    //MARK: Properties
    var vacancies = [Vacancy]()
    var egress = [Egress]()
    var oldEgress = [Egress]()
    var egressSelected: Egress?
    var filteredEgress = [Egress]()
    var currentUserUid: String?
    var listCandidates: [String] = []
    var listVacancy: [String] = []
    
    let company = Company(name: "PanoSocial",
                          foundationDate: 2005,
                          region: "Campinas, SP",
                          photo: "",
                          description: "Irá auxiliar no corte e costura, atendendo prazos estabelecidos e zelando pela organizaçao e limpeza dos equipamentos",
                          site: nil,
                          sectors: "Costura; Corte; Limpeza",
                          contact: "(019)3263-6537",
                          vancancies: nil)
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBAction func unwindToNotification(segue: UIStoryboardSegue){}
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var shadowView: UIView!
    //MARK: Views
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadEgress()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        if #available(iOS 13.0, *) {
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
    
    //MARK: Functions
    private func loadEgress(){
        
        var listCandidateUID = [String]()

        canditates() { (error, listCandidate) in
            if let error = error {
                print("Error loading document: \(error.localizedDescription)")
            } else {
                self.egress = []
                listCandidateUID = listCandidate!
                self.activityIndicator.startAnimating()
                for candidateUID in listCandidateUID {
                    EgressServices.getOne(candidateUID) { (error, egress) in
                        if let error = error {
                            print("Error loading document: \(error.localizedDescription)")
                        } else {
                            self.egress.append(egress!)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                self.activityIndicator.stopAnimating()
                                self.activityIndicator.isHidden = true
                                self.shadowView.isHidden = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func loadVacancies(completion: @escaping (_ error: Error?, _ vacancies: [Vacancy]?) -> (Void)) {
        
        var vacancy: Vacancy! = nil
        let db = Firestore.firestore()
        
        VacancyServices.getAll { (error, vacancies) in

            if let error = error {
                completion(error, nil)
                print("Error loading document: \(error.localizedDescription)")
            } else {
//                completion(nil, vacancies)
                
                db.collection("vacancy").whereField("UID", isEqualTo: "EewYKz1BY9YB4n1wWnZVZL4u5nL2")
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            self.testeVacancies = []
                            
                            for document in querySnapshot!.documents {
                                print("\(document.documentID) => \(document.data())")
                                let name = document.get("name") as! String
                                let company = self.company
                                let releaseTime = document.get("releaseTime") as! Int
                                let description = document.get("description") as! String
                                let workday = document.get("workday") as! String
                                let numberOfVacancies = document.get("numberOfVacancies") as! String
                                let benefits = document.get("benefits") as? String
                                let salary = document.get("salary") as! String
                                let region = document.get("region") as! String
                                let typeOfWork = document.get("typeOfWork") as! String
                                let startWork = document.get("startWork") as! String
                                let isActivated = document.get("isActivated") as! Bool
                                let ID = document.documentID
                                let uid = document.get("UID") as! String
                                let candidateList = document.get("candidatesList") as! [String]
                                
                                vacancy = Vacancy(name: name,
                                                  company: company,
                                                  releaseTime: releaseTime,
                                                  description: description,
                                                  workday: workday,
                                                  numberOfVacancies: numberOfVacancies,
                                                  benefits: benefits,
                                                  salary: salary,
                                                  region: region,
                                                  typeOfWork: typeOfWork,
                                                  isActivated: isActivated,
                                                  candidateList: candidateList,
                                                  startWork: startWork)
                                vacancy.ID = ID
                                vacancy.UID = uid
                                
                                self.testeVacancies.append(vacancy)
                            }
                            completion(nil, self.testeVacancies)
                            print(self.testeVacancies)
                        }
                }
            }
        }
    }
    
    func canditates(completion: @escaping (_ error: Error?, _ listCandidate: [String]?) -> (Void)) {
        
        getCurrentUserId() { (currentUserId) in
            if currentUserId == nil {
                print("Func candidates: Not found current user id")
            } else {
                self.currentUserUid = currentUserId
            }
        }

        loadVacancies() { (error, vacancies) in
            if let error = error {
                print("Error loading document: \(error.localizedDescription)")
                completion(error, nil)
            } else {
                self.listCandidates = []
                self.listVacancy = []
                for vacancy in vacancies! {
                    if vacancy.UID == self.currentUserUid {
                        for candidate in vacancy.candidateList {
                            self.listCandidates.append(candidate)
                            self.listVacancy.append(vacancy.name)
                        }
                    }
                }
//                completion(nil, self.listCandidates)
                self.testeListCandidates = []
                self.testeListVacancy = []
                
                if self.testeVacancies.isEmpty == false {
                    for vacancy in self.testeVacancies {
                        if vacancy.candidateList.isEmpty == false {
                            for candidate in vacancy.candidateList {
                                self.testeListCandidates.append(candidate)
                                self.testeListVacancy.append(vacancy.name)
                            }
                        }
                    }
                }
                completion(nil, self.testeListCandidates)
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
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "CandidateDetail"{
            let candidateDetail = segue.destination as! CandidateDetailViewController
            
            if egressSelected != nil{
                candidateDetail.egress = egressSelected
                candidateDetail.segueIdentifier = "unwindToNotications"
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
        
        let boldText2  = "\(String(describing: self.listVacancy[indexPath.row]))"
        let boldString2 = NSMutableAttributedString(string: boldText2, attributes:attrs)
        attributedString1.append(boldString2)
        
        cell.nameLabel.attributedText = attributedString1
        cell.nameRegion?.text = "" //(company.vancancies?[0].releaseTime) d
        
        // Add photo  profile
        if egressSelected.photo != "" {
            let profileImageUrl = egressSelected.photo
            let url = NSURL(string: profileImageUrl)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
                
                if error != nil {
                    print("Erro carregmento foto notificacao: \(String(describing: error))")
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
