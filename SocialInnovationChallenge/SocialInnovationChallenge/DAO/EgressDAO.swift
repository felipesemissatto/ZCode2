//
//  EgressDAO.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 29/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class EgressDAO: DAO {
    
    static func findAll(completion: @escaping (_ error: Error?, _ egress: [Egress]?) -> (Void)) throws {
        
        FirebaseManager.sharedInstance.readEgressFirebase { (error, egress) in
            if let err = error {
                completion(err, nil)
            } else {
                completion(nil, egress)
            }
        }
    }
    
    static func findOne(_ documentId: String, completion: @escaping (_ error: Error?, _ egress: Egress?) -> (Void)) throws {
        
        FirebaseManager.sharedInstance.readOneEgressFirebase(documentId) { (error, egress) in
            if let err = error {
                completion(err, nil)
            } else {
                completion(nil, egress)
            }
        }
    }
}
