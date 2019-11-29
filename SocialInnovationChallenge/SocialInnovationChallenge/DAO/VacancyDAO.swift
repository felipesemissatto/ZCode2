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
        
        FirebaseManager.sharedInstance.writeFirebase(objectToBeSaved) { (error, documentID) in
            if let err = error {
                completion(err, nil)
            } else {
                completion(nil, documentID)
            }
        }
        
    }
    
//    static func findAll(completion: @escaping (_ error: Error?, _ vacancies: [Vacancy]?) -> (Void)) throws -> [Vacancy] {
//        // list of seasons to be returned
//        var vacancyList:[Vacancy]
//        
//        do {
//            // perform search
//            vacancyList = try FirebaseManager.sharedInstance.readFirebase(completion: (error?, vacancies?) -> [Vacancy])
//        }
//        catch let error {
//            print(error)
//        }
//        
//        return vacancyList
//    }
}

//static func create(_ objectToBeSaved: Season) throws {
//    do {
//        // add object to be saved to the context
//        CoreDataManager.sharedInstance.persistentContainer.viewContext.insert(objectToBeSaved)
//        
//        // persist changes at the context
//        try CoreDataManager.sharedInstance.persistentContainer.viewContext.save()
//    }
//    catch {
//        throw Errors.DatabaseFailure
//    }
//}
//static func findAll() throws -> [Season] {
//    // list of seasons to be returned
//    var seasonList:[Season]
//
//    do {
//        // creating fetch request
//        let request:NSFetchRequest<Season> = fetchRequest()
//
//        // perform search
//        seasonList = try CoreDataManager.sharedInstance.persistentContainer.viewContext.fetch(request)
//    }
//    catch {
//        throw Errors.DatabaseFailure
//    }
//
//    return seasonList
