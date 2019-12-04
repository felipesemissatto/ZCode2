//
//  CandidateTableViewCell.swift
//  SocialInnovationChallenge
//
//  Created by Felipe Semissatto on 21/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import UIKit

class CandidateTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var viewCard: UIView!
    @IBOutlet weak var imageEgress: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameRegion: UILabel!
    
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
        
        self.imageEgress.layer.shadowColor = shadowColor.cgColor
        self.imageEgress.layer.masksToBounds = true
        self.imageEgress.layer.shadowOffset = CGSize(width: 2, height: 4)
        self.imageEgress.layer.shadowRadius = 4
        self.imageEgress.layer.shadowOpacity = 0.8
        self.imageEgress.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
