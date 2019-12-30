//
//  EgressDAO.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 29/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class CandidateDAO: DAO {
    
    static func findAll(completion: @escaping (_ error: Error?, _ egress: [Egress]?) -> (Void)) throws {
        
        FirebaseManager.sharedInstance.readCandidatesFirebase { (error, egress) in
            if let err = error {
                completion(err, nil)
            } else {
                completion(nil, egress)
            }
        }
    }
    
    static func findOne(_ documentId: String, completion: @escaping (_ error: Error?, _ egress: Egress?) -> (Void)) throws {
        
        FirebaseManager.sharedInstance.readOneCandidateFirebase(documentId) { (error, egress) in
            if let err = error {
                completion(err, nil)
            } else {
                completion(nil, egress)
            }
        }
    }
    
    static func candidateApply(_ vacancyDocumentID: String, _ candidateUserID: [String], completion: @escaping (_ error: Error?, _ applySuccess: Bool?) -> (Void)) throws {
        
        FirebaseManager.sharedInstance.candidateApplyFirebase(vacancyDocumentID, candidateUserID) { (error, applySuccess) in
            if let error = error {
                completion(error, nil)
            } else {
                completion(nil, applySuccess)
            }
        }
    }
}
