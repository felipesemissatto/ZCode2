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
    
    static func isActivated(_ isActivated: Bool, _ documentId: String, completion: @escaping (_ error: Error?) -> (Void)) throws {
        
        FirebaseManager.sharedInstance.activateVacancyFirebase(isActivated, documentId) { (error) in
            if let err = error {
                completion(err)
            } else {
                completion(nil)
            }
        }
    }
    
    static func readWhereField(_ field: String, _ value: String, completion: @escaping (_ error: Error?, _ candidatesList: [String]?, _ nameList: [String]?) -> (Void)) throws {
        
        FirebaseManager.sharedInstance.readWhereFieldFirebase(field, value) { (error, candidatesList, nameList) in
            if let error = error {
                completion(error, nil, nil)
            } else {
                completion(nil, candidatesList, nameList)
            }
        }
    }
}
