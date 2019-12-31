//
//  Vacancy.swift
//  SocialInnovationChallenge
//
//  Created by Isabela Modesto on 06/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.

import Foundation

class Vacancy {
    
    //MARK: Properties
    public var benefits: String?
    public var campanyID: String?
    public var candidateList: [String]
    public var companyName: String
    public var companyPhoto: String
    public var description: String
    public var documentID: String?
    public var isActivated: Bool
    public var name: String
    public var numberOfVacancies: String
    public var region: String
    public var releaseTime: Int //days, weeks or months
    public var salary: String
    public var startWork: String
    public var typeOfWork: String
    public var workday: String

    //MARK: Contructors
    init(name: String = "",
         companyName: String = "",
         companyPhoto: String = "",
         releaseTime: Int = 0,
         description: String =  "",
         workday: String =  "",
         numberOfVacancies: String = "",
         benefits: String? =  "",
         salary: String =  "",
         region: String = "",
         typeOfWork: String = "",
         isActivated: Bool = true,
         candidateList: [String] = [],
         startWork: String = ""){
            self.name = name
            self.companyName = companyName
            self.companyPhoto = companyPhoto
            self.releaseTime = releaseTime
            self.description = description
            self.workday = workday
            self.numberOfVacancies = numberOfVacancies
            self.benefits = benefits
            self.salary = salary
            self.region = region
            self.typeOfWork = typeOfWork
            self.isActivated = isActivated
            self.candidateList = candidateList
            self.startWork = startWork
    }
}
