//
//  VacancyDAO.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 21/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class VacancyDAO: DAO {
    
    static func create(_ objectToBeSaved: Vacancy, completion: @escaping (_ error: Error?, _ documentId: String?) -> (Void)) throws {
        
        FirebaseManager.sharedInstance.writeVacancyFirebase(objectToBeSaved) { (error, documentID) in
            if let err = error {
                completion(err, nil)
            } else {
                completion(nil, documentID)
            }
        }
        
    }
    
    static func findAll(completion: @escaping (_ error: Error?, _ vacancies: [Vacancy]?) -> (Void)) throws {
        
        FirebaseManager.sharedInstance.readVacanciesFirebase { (error, vacancies) in
            if let err = error {
                completion(err, nil)
            } else {
                completion(nil, vacancies)
            }
        }
    }
    
    static func delete(_ documentID: String, completion: @escaping (_ error: Error?) -> (Void)) throws {
        
        FirebaseManager.sharedInstance.deleteVacancyFirebase(documentID) { (error) in
            if let err = error {
                completion(err)
            } else {
                completion(nil)
            }
        }
    }
    
//    static func findNotification(_ uid: String, completion: @escaping (_ error: Error?, _ listCandidate: [String]?) -> (Void)) throws {
//        
//        var listCandidate: [String] = []
//        
//        FirebaseManager.sharedInstance.readVacanciesFirebase { (error, vacancies) in
//            if let err = error {
//                completion(err, nil)
//            } else {
//                for vacancy in vacancies! {
//                    if vacancy.UID == uid {
//                        listCandidate = listCandidate + vacancy.candidateList
//                    }
//                }
//                let newListCandidate = listCandidate.removingDuplicates()
//                completion(nil, newListCandidate)
//            }
//        }
//    }
}
