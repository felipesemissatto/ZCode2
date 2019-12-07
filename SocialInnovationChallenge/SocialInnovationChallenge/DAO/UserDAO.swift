//
//  UserDAO.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 06/12/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class UserDAO: DAO {
    
    static func findId(completion: @escaping (_ currentUserId: String?) -> (Void)) {
        
        FirebaseManager.sharedInstance.readCurrentUserIdFirebase { (currentUserId) in
            if currentUserId == nil {
                print("Not found current user id")
                completion(nil)
            } else {
                completion(currentUserId)
            }
        }
    }
}
