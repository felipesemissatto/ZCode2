//
//  EgressServices.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 29/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class CandidateServices {
    
    static func getAll(_ completion: @escaping ((_ error: Error?, _ egress: [Egress]?) -> Void)) {
        
        do {
            // save information
            try CandidateDAO.findAll() { (error, egress) in
                
                if let error = error {
                    completion(error, nil)
                } else {
                    completion(nil, egress)
                }
            }
        }
        catch let error {
            print(error)
        }
    }
    
    static func getOne(_ documentId: String, _ completion: @escaping ((_ error: Error?, _ egress: Egress?) -> Void)) {
        
        do {
            // save information
            try CandidateDAO.findOne(documentId) { (error, egress) in
                
                if let error = error {
                    completion(error, nil)
                } else {
                    completion(nil, egress)
                }
            }
        }
        catch let error {
            print("Erro func getone: \(error)")
        }
    }
    
    static func apply(_ vacancyDocumentID: String, _ candidateUserID: [String], completion: @escaping (_ error: Error?, _ applySuccess: Bool?) -> (Void)) {
        
        do {
            
            try CandidateDAO.candidateApply(vacancyDocumentID, candidateUserID) { (error, applySuccess) in
                
                if let error = error {
                    completion(error, nil)
                } else {
                    completion(nil, applySuccess)
                }
            }
        }
        catch let error {
            print("Erro func apply: \(error)")
        }
    }
}
