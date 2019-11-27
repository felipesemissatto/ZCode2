//
//  Company.swift
//  SocialInnovationChallenge
//
//  Created by Isabela Modesto on 06/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import Foundation

struct Company{
    
    //MARK: Properties
    public var name: String
    public var foundationDate: Int
    public var region: String
    public var photo: URL?
    public var description: String
    public var site: URL?
    public var sectors: String
    public var contact: String
    public var vancancies: [Vacancy]?
    
    //MARK: Constructors
    init(name: String = "",
        foundationDate: Int = 0,
        region: String = "",
        photo: URL? = nil,
        description: String = "",
        site: URL? = nil,
        sectors: String = "",
        contact: String = "",
        vancancies: [Vacancy]? = nil){
            self.name = name
            self.foundationDate = foundationDate
            self.region = region
            self.photo = photo
            self.description = description
            self.site = site
            self.sectors = sectors
            self.contact = contact
            self.vancancies = vancancies
    }
}
