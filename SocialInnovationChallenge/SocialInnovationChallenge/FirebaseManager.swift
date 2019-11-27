//
//  FirebaseManager.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 21/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit
import FirebaseFirestore

class FirebaseManager {
    
    var vacancies = [Vacancy]()
    let company = Company(name: "PanoSocial",
                          foundationDate: 2005,
                          region: "Campinas, SP",
                          photo: nil,
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

        var ref: DocumentReference? = nil
        
        ref = db.collection("vacancyTeste").addDocument(data: ["benefits": benefits,
                                                     "description": description ,
        //                                           "company": "/company/\(company)",
                                                     "isActivated": isActivated,
                                                     "name": name ,
                                                     "numberOfVacancies": numberOfVacancies ,
                                                     "region": region,
                                                     "releaseTime": releaseTime,
                                                     "salary": salary ,
                                                     "typeOfWork": typeOfWork,
                                                     "workday": workday]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completion(err, nil)
            } else {
                print("Document added with ID: \(ref!.documentID)")
                completion(nil, ref!.documentID)
            }
        }
    }
    
    func redFirebase() -> [Vacancy]{
        let db = Firestore.firestore()
        
        db.collection("vacancy").getDocuments() { (snapshot,error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                for document in snapshot!.documents {
                    let vacancy = Vacancy(name: "Makoto",
                                          company: self.company,
                                          releaseTime: 0,
                                          description: "",
                                          workday: "",
                                          numberOfVacancies: "",
                                          benefits: "Rápido; Grande",
                                          salary: "")

                    vacancy.name = document.get("name") as! String
                    vacancy.company = self.company
                    vacancy.description = document.get("description") as! String
                    vacancy.benefits = document.get("benefits") as? String
                    vacancy.numberOfVacancies = document.get("numberOfVacancies") as! String
                    vacancy.salary = document.get("salary") as! String
                    vacancy.workday = document.get("workday") as! String


                    self.vacancies.append(vacancy)
                }
            }
        }
        
        return self.vacancies
    }
}

