//
//  FirebaseManager.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 21/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FirebaseManager {
    
    var vacancies: [Vacancy] = []
    var egress: [Egress] = []
    let company = Company(name: "PanoSocial",
                          foundationDate: 2005,
                          region: "Campinas, SP",
                          photo: "",
                          description: "Irá auxiliar no corte e costura, atendendo prazos estabelecidos e zelando pela organizaçao e limpeza dos equipamentos",
                          site: nil,
                          sectors: "Costura; Corte; Limpeza",
                          contact: "(019)3263-6537",
                          vancancies: nil)
    
    //Empty initializer to avoid external instantiation
    private init() {
        
    }
    
    // Database manager singleton
    static let sharedInstance = FirebaseManager()
    
    
    //Write in firebase if all textFiels filled
    func writeFirebase (_ vacancy: Vacancy, completion: @escaping (_ error: Error?, _ documentId: String?) -> (Void)) {
        let db = Firestore.firestore()
        
        let name = vacancy.name
        let region = vacancy.region
        let releaseTime = vacancy.releaseTime
        let description = vacancy.description
        let workday = vacancy.workday
        let numberOfVacancies = vacancy.numberOfVacancies
        let benefits: String = vacancy.benefits!
        let salary = vacancy.salary
        let typeOfWork: String = vacancy.typeOfWork
        let isActivated = vacancy.isActivated
        let candidateList = vacancy.candidateList
        let uid = Auth.auth().currentUser!.uid
        
        var ref: DocumentReference? = nil
        
        ref = db.collection("vacancy").addDocument(data: ["benefits": benefits,
                                                               "description": description ,
//                                                             "company": "/company/\(company)",
                                                                "isActivated": isActivated,
                                                                "candidatesList": candidateList,
                                                                "name": name ,
                                                                "numberOfVacancies": numberOfVacancies ,
                                                                "region": region,
                                                                "releaseTime": releaseTime,
                                                                "salary": salary ,
                                                                "typeOfWork": typeOfWork,
                                                                "workday": workday,
                                                                "UID": uid]) { err in
                                                                    if let err = err {
                                                                        print("Error adding document: \(err)")
                                                                        completion(err, nil)
                                                                    } else {
                                                                        print("Document added with ID: \(ref!.documentID)")
                                                                        completion(nil, ref!.documentID)
                                                                    }
        }
    }
    
    func readVacanciesFirebase(completion: @escaping (_ error: Error?, _ vacancies: [Vacancy]?) -> (Void)) {
        let db = Firestore.firestore()
        var vacancy: Vacancy! = nil
        
        db.collection("vacancy").getDocuments() { (snapshot, err) in
            if let error = err {
                print("Error getting documents: \(error)")
                completion(error, nil)
            } else {
                self.vacancies = []
                
                for document in snapshot!.documents {
                    
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
                                      candidateList: candidateList)
                    vacancy.ID = ID
                    vacancy.UID = uid
                    
                    self.vacancies.append(vacancy)
                }
                
                completion(nil, self.vacancies)
            }
        }
    }
    
    func readEgressFirebase(completion: @escaping (_ error: Error?, _ egress: [Egress]?) -> (Void)) {
        let db = Firestore.firestore()
        var egress:  Egress! = nil
        
        db.collection("egress").getDocuments() { (snapshot, err) in
            if let error = err {
                print("Error getting documents: \(error)")
                completion(error, nil)
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
                    let experiencesDescription = document.get("experiencesDescription") as! [String]
                    let uid = document.get("documentID") as! String
                    
                    egress = Egress(name: name,
                                    dateOfBirth: "",
                                    description: description,
                                    region: region,
                                    photo: photo,
                                    video: nil,
                                    courses: courses,
                                    experiences: experiences,
                                    experiencesDescription: experiencesDescription,
                                    skills: nil,
                                    desires: desires,
                                    contact: contact)
                    egress.uid = uid
                    
                    self.egress.append(egress)
                }
                
                completion(nil, self.egress)
            }
        }
    }
}


