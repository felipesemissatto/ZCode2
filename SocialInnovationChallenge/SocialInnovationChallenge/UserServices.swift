//
//  UserServices.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 06/12/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class UserServices {
    
    static func getCurrentUserId(_ completion: @escaping (_ currentUserId: String?) -> Void) {
        
        UserDAO.findId() { (currentUserId) in
            if currentUserId == nil {
                print("Func getCurrentUserId: Not found current user id")
                completion(nil)
            } else {
                completion(currentUserId)
            }
        }
    }
}
