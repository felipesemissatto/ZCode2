//
//  Egress.swift
//  SocialInnovationChallenge
//
//  Created by Isabela Modesto on 06/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import Foundation

class Egress{
    
    //MARK: Properties
    public var contact: [String]
    public var courses: [String]?
    public var dateOfBirth: String
    public var description: String
    public var desires: [String]
    public var experiences: [String]?
    public var experiencesDescription: [String]?
    public var name: String
    public var photo: String
    public var region: String
    public var video: URL?
    public var id: String?
    
    //MARK: Constructors
    init(contact: [String] = [],
         courses: [String]? = nil,
         dateOfBirth: String = "",
         description: String = "",
         desires: [String] = ["", "", ""],
         experiences: [String]? = nil,
         experiencesDescription: [String]? = nil,
         name: String = "",
         photo: String = "",
         region: String = "",
         video: URL? = nil) {
        
            self.name = name
            self.dateOfBirth = dateOfBirth
            self.description = description
            self.region = region
            self.photo = photo
            self.video = video
            self.courses = courses
            self.experiences = experiences
            self.experiencesDescription = experiencesDescription
            self.desires = desires
            self.contact = contact
    }
}
