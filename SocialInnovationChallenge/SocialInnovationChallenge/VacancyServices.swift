//
//  VacancyServices.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 21/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class VacancyServices {
    
    static func createVacancy(vacancy: Vacancy, completion: @escaping (_ error: Error?, _ documentId: Vacancy?) -> (Void)) {
        
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
    
    static func getAllVacancy(_ completion: ((_ error: Error?, _ vacancies: [Vacancy]?) -> Void)?) {
        // error to be returned in case of failure
        var raisedError: Error? = nil
        var vacancies: [Vacancy]?
        
        do {
            // save information
            vacancies = try VacancyDAO.findAll()
        }
        catch let error {
            raisedError = error
        }
    }
}
