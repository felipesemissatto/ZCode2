//
//  CandidateDetailViewController.swift
//  SocialInnovationChallenge
//
//  Created by Isabela Modesto on 26/11/19.
//  Copyright © 2019 Felipe Semissatto. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import Contacts

class CandidateDetailViewController : UIViewController, MFMailComposeViewControllerDelegate{
    //MARK: Properties
    
    var egress : Egress?
    //MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var inviteButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var contentViewHeightConstrant: NSLayoutConstraint!
    
    @IBOutlet weak var coursesLabel: UILabel!
    @IBOutlet weak var experiencesLabel: UILabel!
    @IBOutlet weak var experiencesLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var dreamsLabel: UILabel!
    @IBOutlet weak var dreamsLabelConstraint: NSLayoutConstraint!
    
    
    //MARK: Views
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inviteButton.layer.cornerRadius = 4
        nameLabel.text = egress!.name
        descriptionTextView.text = egress!.description
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if egress!.courses != nil{
            var index : CGFloat = 1
            for course in egress!.courses!{
                createAtributeLabel(index, content: course, yPosition: coursesLabel.frame.origin.y, nextLabelVerticalSpacing: experiencesLabelConstraint)
                index += 1
            }
            contentView.layoutIfNeeded()
        }
        if egress!.experiences != nil{
            var index : CGFloat = 1
            for experience in egress!.experiences!{
                createAtributeLabel(index, content: experience, yPosition: experiencesLabel.frame.origin.y, nextLabelVerticalSpacing: dreamsLabelConstraint)
                index += 1
            }
            print(experiencesLabel.frame.origin.y)
            contentView.layoutIfNeeded()
        }
        if !egress!.desires.isEmpty{
            var index : CGFloat = 1
            for desire in egress!.desires{
                createAtributeLabel(index, content: desire, yPosition: dreamsLabel.frame.origin.y, nextLabelVerticalSpacing: nil)
                index += 1
            }
            print(dreamsLabel.frame.origin.y)
            contentView.layoutIfNeeded()
        }
        
            
        downloadImage()
    }

    
    //MARK: Actions
    @IBAction func inviteTapped(_ sender: Any) {
        showSimpleActionSheet(controller: self)
    }
    
    @IBAction func backTapped(_ sender: Any) {
         performSegue(withIdentifier: "unwindToCandidates", sender: nil)
    }
    
    
    //MARK: Functions
    
    func sendAWhatsappMessage(number : String) {
        if let url = URL(string: "https://api.whatsapp.com/send?phone=\(number)"),
            UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
        }
        else {
            let alert = UIAlertController(title: "Não foi possível abrir o Whatsapp", message: "", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func call(number : String){
        if let phoneCallURL:URL = URL(string: "tel:\(number)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                UIApplication.shared.open(phoneCallURL)
            }
        }
    }
    
    func sendAnEmail(adress : String){
        // Check the result or perform other tasks.
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
             
            // Configure the fields of the interface.
            composeVC.setToRecipients([adress])
             
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Não foi possível abrir o Mail", message: "", preferredStyle: UIAlertController.Style.alert)

            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
                //Cancel Action
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }


    func showSimpleActionSheet(controller: UIViewController) {
        let alert = UIAlertController(title: "Como deseja entrar em contato?", message: "Selecione uma opção", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Ligar", style: .default, handler: { (_) in
            self.call(number : self.egress!.contact[0])
        }))

        alert.addAction(UIAlertAction(title: "Enviar email", style: .default, handler: { (_) in
            self.sendAnEmail(adress : self.egress!.contact[1])
        }))
        
        alert.addAction(UIAlertAction(title: "Enviar mensagem via Whatsapp", style: .default, handler: { (_) in
            self.sendAWhatsappMessage(number: self.egress!.contact[0]) //número pra teste
        }))

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (_) in
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    func createLabel(text : String, rect : CGRect){
        let label = UILabel(frame: rect)
        label.text = text
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        self.contentView.addSubview(label)
    }
    
    func createAtributeLabel(_ index : CGFloat, content : String, yPosition : CGFloat, nextLabelVerticalSpacing : NSLayoutConstraint?){
        
        var increase : CGFloat
        var verticalSapacing : CGFloat = 0
        
        if index == 1{
            increase = 35
            verticalSapacing += 35
        }
        else{
            increase = 35 + 25 * (index - 1)
            verticalSapacing += 25
        }
        
        let rect = CGRect(x: 24, y: yPosition + increase, width: 360, height: 18)
        createLabel(text: content, rect: rect)
        
        contentViewHeightConstrant.constant += verticalSapacing
//        if nextLabelVerticalSpacing != nil{
//            nextLabelVerticalSpacing!.constant += verticalSapacing
//        }
    }
    func downloadImage() {
        // Add photo  profile
        if egress!.photo != "" {
            let profileImageUrl = egress!.photo
            let url = NSURL(string: profileImageUrl)
            URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in

                if error != nil {
                    print(error)
                    return
                }
                
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        self.profileImage.image = UIImage(data: data!)
                    }
                }
            }).resume()
        }
    }
//    link bom que ensina a criar alertas: https://medium.com/swift-india/uialertcontroller-in-swift-22f3c5b1dd68
}
