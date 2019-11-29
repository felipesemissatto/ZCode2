//
//  VacancyServices.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 21/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class VacancyServices {
    
    var vacancies: [Vacancy] = []
    
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
    
//    static func getAllVacancy(_ completion: @escaping ((_ error: Error?, _ vacancies: [Vacancy]?) -> Void)) {
//        
//        do {
//            // save information
//            self.vacancies = try VacancyDAO.findAll() { (error, vacancies) in
//                
//                if let err = error {
//                    completion(err, nil)
//                } else {
//                    completion(nil, self.vacancies)
//                }
//                
//            }
//        }
//        catch let error {
//            print(error)
//        }
//    }
}

//static func createSeason(season: Season, _ completion: ((_ error: Error?) -> Void)?) {
//
//let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
//
//
//    do {
//        // save information
//        try SeasonDAO.create(season)
//    }
//    catch let error {
//        raisedError = error
//    }
//
//static func getAllSeasons(_ completion: ((_ error: Error?, _ seasons: [Season]?) -> Void)?)
//let blockForExecutionInBackground: BlockOperation = BlockOperation(block: {
//
//    var seasons: [Season]?
//
//    do {
//        // save information
//        seasons = try SeasonDAO.findAll()
//    }
//    catch let error {
//        raisedError = error
//    }
