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
    public var name: String
    public var dateOfBirth: String
    public var description: String
    public var region: String
    public var photos: [URL]?
    public var video: URL?
    public var courses: [String]?
    public var experiences: [String]?
    public var skills: [String]?
    public var desires: [String]
    public var contact: [String]
    
    //MARK: Constructors
    init(name: String = "",
        dateOfBirth: String = "",
        description: String = "",
        region: String = "",
        photos: [URL]? = nil,
        video: URL? = nil,
        courses: [String]? = nil,
        experiences: [String]? = nil,
        skills: [String]? = nil,
        desires: [String] = ["", "", ""],
        contact: [String] = []){
        
            self.name = name
            self.dateOfBirth = dateOfBirth
            self.description = description
            self.region = region
            self.photos = photos
            self.video = video
            self.courses = courses
            self.experiences = experiences
            self.skills = skills
            self.desires = desires
            self.contact = contact
    }
}
