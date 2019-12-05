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
    public var photo: String
    public var description: String
    public var site: URL?
    public var sectors: String
    public var contact: String
    public var vancancies: [Vacancy]?
    
    //MARK: Constructors
    init(name: String = "",
        foundationDate: Int = 0,
        region: String = "",
        photo: String = "https://firebasestorage.googleapis.com/v0/b/zcode-348d6.appspot.com/o/News%20Logo.png?alt=media&token=cb6d3dd4-c113-4b35-af93-2ab8847f451d",
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
