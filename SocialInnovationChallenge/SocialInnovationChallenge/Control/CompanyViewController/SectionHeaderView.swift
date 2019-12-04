//
//  XibViewController.swift
//  SocialInnovationChallenge
//
//  Created by Isabela Modesto on 03/12/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import Foundation
import UIKit

class SectionHeaderView : UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    private var contentView : UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    func initialize(){
        guard let view = loadViewFromNib() else {return}
        view.frame = self.bounds
        self.addSubview(view)
        
        contentView = view
        self.backgroundColor = .clear
    }
    
    func loadViewFromNib() -> UIView?{
        let nib = UINib(nibName: "SectionHeaderCandidateDetail", bundle: Bundle.main)
        
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}