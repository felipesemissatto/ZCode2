//
//  VacancyTableViewCell.swift
//  SocialInnovationChallenge
//
//  Created by Felipe Semissatto on 08/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class VacancyTableViewCell: UITableViewCell {
    //MARK: Outlets
    
    @IBOutlet weak var nameVacancyLabel: UILabel!
    @IBOutlet weak var numberOfVacanciesLabel: UILabel!
    @IBOutlet weak var isActivatedLabel: UILabel!
    @IBOutlet weak var timeReleaseLabel: UILabel!
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var ballView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let shadowColor = UIColor(displayP3Red: 128/255, green: 152/255, blue: 213/255, alpha: 0.07)
        self.viewCard.layer.shadowColor = shadowColor.cgColor
        self.viewCard.layer.masksToBounds = false
        self.viewCard.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.viewCard.layer.shadowRadius = 4
        self.viewCard.layer.shadowOpacity = 0.8
        self.viewCard.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
