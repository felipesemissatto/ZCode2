//
//  JsonCandidates.swift
//  SocialInnovationChallenge
//
//  Created by Rodrigo Takumi on 18/12/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//
import UIKit
import FirebaseFirestore

class Json {

var candidates = """
                [
                    {
                        "id": "1",
                        "firstName": "Kristin",
                        "lastName": "Smith",
                        "occupation": "Teacher",
                        "reviewCount": "6",
                        "reviewScore": "5",
                    },
                    {
                        "id": "2",
                        "firstName": "Olivia",
                        "lastName": "Parker",
                        "occupation": "Teacher",
                        "reviewCount": "11",
                        "reviewScore": "5",
                    },
                    {
                        "id": "3",
                        "firstName": "Jimmy",
                        "lastName": "Robinson",
                        "occupation": "Teacher",
                        "reviewCount": "9",
                        "reviewScore": "4",
                    },
                    {
                        "id": "4",
                        "firstName": "Zack",
                        "lastName": "Carter",
                        "occupation": "Teacher",
                        "reviewCount": "4",
                        "reviewScore": "5",
                    },
                    {
                        "id": "5",
                        "firstName": "Brad",
                        "lastName": "Rayburn",
                        "occupation": "Teacher",
                        "reviewCount": "2",
                        "reviewScore": "4",
                    }
                ]
"""

    func writeJson() {
        
        do {
            let json = try JSONSerialization.jsonObject(with:candidates.data(using:.utf8)!, options: []) as! [[String: Any]]
            for i in 0...json.count - 1
            {
                Firestore.firestore().collection("candidates").document().setData(json[i])
            }
        } catch  {
            print(error)
        }
    }
}
