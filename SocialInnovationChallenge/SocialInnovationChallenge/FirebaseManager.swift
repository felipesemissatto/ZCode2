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
    
    let db = Firestore.firestore()
    
    var vacancies: [Vacancy] = []
    var egress: [Egress] = []
    let company = Company(name: "Pano Social",
                          foundationDate: 2005,
                          region: "Campinas, SP",
                          photo: "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/News%20Logo.png?alt=media&token=cb6d3dd4-c113-4b35-af93-2ab8847f451d",
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
        let startWork = vacancy.startWork
        
        var ref: DocumentReference? = nil
        
        ref = self.db.collection("vacancy").addDocument(data: ["benefits": benefits,
                                                               "description": description ,
                                                                "isActivated": isActivated,
                                                                "candidatesList": candidateList,
                                                                "name": name ,
                                                                "numberOfVacancies": numberOfVacancies ,
                                                                "region": region,
                                                                "releaseTime": releaseTime,
                                                                "salary": salary ,
                                                                "typeOfWork": typeOfWork,
                                                                "workday": workday,
                                                                "UID": uid,
                                                                "startWork": startWork]){ err in
                                                                    if let err = err {
                                                                        print("Error adding document: \(err)")
                                                                        completion(err, nil)
                                                                    } else {
                                                                        print("Document added with ID: \(ref!.documentID)")
                                                                        completion(nil, ref!.documentID)
                                                                    }
        }
    }
    
    //Read all vacancies of firebase
    func readVacanciesFirebase(completion: @escaping (_ error: Error?, _ vacancies: [Vacancy]?) -> (Void)) {
        var vacancy: Vacancy! = nil
        
        self.db.collection("vacancy").getDocuments() { (snapshot, err) in
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
                    
                    self.vacancies.append(vacancy)
                }
                
                completion(nil, self.vacancies)
            }
        }
    }
    
    //Read one candidate of firebase
    func readOneCandidateFirebase(_ documentId: String, completion: @escaping (_ error: Error?, _ egress: Egress?) -> (Void)) {
        var egress:  Egress! = nil
        let docRef = self.db.collection("candidates").document(documentId)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let name = document.get("name") as! String
                let region = document.get("region") as! String
                let description = document.get("description") as! String
                let contact = document.get("contact") as! [String]
                let desires = document.get("desires") as! [String]
                let photo = document.get("photo") as! String
                let courses = document.get("courses") as! [String]
                let experiences = document.get("experiences") as! [String]
                let experiencesDescription = document.get("experiencesDescription") as! [String]
//                let uid = document.get("documentID") as! String
                let id = document.documentID
                
                egress = Egress(contact: contact,
                                courses: courses,
                                dateOfBirth: "",
                                description: description,
                                desires: desires,
                                experiences: experiences,
                                experiencesDescription: experiencesDescription,
                                name: name,
                                photo: photo,
                                region: region,
                                video: nil)
                egress.id = id
                
                completion(nil, egress)
            } else {
                let error = error 
                print("Erro na func readOneEgressFirebase: \(String(describing: error))")
                completion(error, nil)
            }
        }
    }
    
    //Read all candidates of firebase
    func readCandidatesFirebase(completion: @escaping (_ error: Error?, _ egress: [Egress]?) -> (Void)) {
        var egress:  Egress! = nil
        
        self.db.collection("candidates").getDocuments() { (snapshot, err) in
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
                    let desires = document.get("desires") as! [String]
                    let photo = document.get("photo") as! String
                    let courses = document.get("courses") as! [String]
                    let experiences = document.get("experiences") as! [String]
                    let experiencesDescription = document.get("experiencesDescription") as! [String]
                    let id = document.documentID
                    
                    egress = Egress(contact: contact,
                                    courses: courses,
                                    dateOfBirth: "",
                                    description: description,
                                    desires: desires,
                                    experiences: experiences,
                                    experiencesDescription: experiencesDescription,
                                    name: name,
                                    photo: photo,
                                    region: region,
                                    video: nil)
                    egress.id = id
                    
                    self.egress.append(egress)
                }
                
                completion(nil, self.egress)
            }
        }
    }
    
    func readCurrentUserIdFirebase(completion: @escaping (_ currentUserId: String?) -> (Void)) {
        var currentUserUid: String?
        
        if Auth.auth().currentUser == nil {
            print("Func readCurrentUserIdFirebase: Not found current user id")
            completion(nil)
        } else {
            currentUserUid = Auth.auth().currentUser?.uid
            completion(currentUserUid)
        }
    }
}

