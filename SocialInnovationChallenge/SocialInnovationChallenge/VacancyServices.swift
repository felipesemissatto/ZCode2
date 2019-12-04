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
                    vacancy.ID = documentID
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
    
//    static func getNotification(uid: String, _ completion: @escaping ((_ error: Error?, _ listCandidate: [String]?) -> Void)) {
//        
//        do {
//            // save information
//            try VacancyDAO.findNotification(uid) { (error, listCandidate) in
//                
//                if let error = error {
//                    completion(error, nil)
//                } else {
//                    completion(nil, listCandidate)
//                }
//            }
//        }
//        catch let error {
//            print(error)
//        }
//    }
}

