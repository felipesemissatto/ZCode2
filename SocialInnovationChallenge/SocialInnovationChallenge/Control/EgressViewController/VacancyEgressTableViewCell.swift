//
//  VacancyEgressTableViewCell.swift
//  SocialInnovationChallenge
//
//  Created by Felipe Semissatto on 25/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class VacancyEgressTableViewCell: UITableViewCell {

    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var imageCompany: UIImageView!
    @IBOutlet weak var nameVacancyLabel: UILabel!
    @IBOutlet weak var nameCompanyLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var workdayLabel: UILabel!
    @IBOutlet weak var timeReleaseLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let shadowColor = UIColor(displayP3Red: 0/255, green: 0/255, blue: 0/255, alpha: 0.14)
        self.viewCard.layer.shadowColor = shadowColor.cgColor
        self.viewCard.layer.masksToBounds = false
        self.viewCard.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.viewCard.layer.shadowRadius = 4
        self.viewCard.layer.shadowOpacity = 0.8
        self.viewCard.layer.cornerRadius = 10
        
        self.imageCompany.layer.shadowColor = shadowColor.cgColor
        self.imageCompany.layer.masksToBounds = false
        self.imageCompany.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.imageCompany.layer.shadowRadius = 4
        self.imageCompany.layer.shadowOpacity = 0.8
        self.imageCompany.layer.cornerRadius = 4
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
