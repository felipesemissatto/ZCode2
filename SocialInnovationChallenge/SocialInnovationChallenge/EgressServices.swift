//
//  EgressServices.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 29/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class EgressServices {
    
    static func getAll(_ completion: @escaping ((_ error: Error?, _ egress: [Egress]?) -> Void)) {
        
        do {
            // save information
            try EgressDAO.findAll() { (error, egress) in
                
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
            try EgressDAO.findOne(documentId) { (error, egress) in
                
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
}
