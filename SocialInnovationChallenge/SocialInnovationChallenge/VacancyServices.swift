//
//  VacancyServices.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 21/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class VacancyServices {
    
    static func create(vacancy: Vacancy, completion: @escaping (_ error: Error?, _ documentId: Vacancy?) -> (Void)) {
        
        do {
            try VacancyDAO.create(vacancy) { (error, documentID) in
                
                if let err = error {
                    completion(err, nil)
                } else {
                    vacancy.documentID = documentID
                    completion(nil, vacancy)
                }
                
            }
        } catch let error {
            print(error)
        }
    }
    
    static func getAll(_ completion: @escaping ((_ error: Error?, _ vacancies: [Vacancy]?) -> Void)) {
        
        do {
            // save information
            try VacancyDAO.findAll() { (error, vacancies) in
                
                if let error = error {
                    completion(error, nil)
                } else {
                    completion(nil, vacancies)
                }
            }
        }
        catch let error {
            print(error)
        }
    }
    
    static func delete(_ documentID: String, _ completion: @escaping ((_ error: Error?) -> Void)) {
        
        do {
            
            try VacancyDAO.delete(documentID) { (error) in
                
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        }
        catch let error {
            print("Error func delete: ", error)
        }
    }
    
    static func isActivated(_ isActivated: Bool, _ documentId: String, completion: @escaping (_ error: Error?) -> (Void)) {
        
        do {
            
            try VacancyDAO.isActivated(isActivated, documentId) { (error) in
                if let error = error {
                    completion(error)
                } else {
                    completion(nil)
                }
            }
        }
        catch let error {
            print("Error func isActivated: ", error)
        }
    }
    
    static func readWhereField(_ field: String, _ value: String, completion: @escaping (_ error: Error?, _ candidatesList: [String]?, _ nameList: [String]?) -> (Void)) {
        
        do {
            try VacancyDAO.readWhereField(field, value) { (error, candidatesList, nameList) in
                if let error = error {
                    completion(error, nil, nil)
                } else {
                    completion(nil, candidatesList, nameList)
                }
            }
        }
        catch let error {
            print("Error func readWhereField: ", error)
        }
    }
}

