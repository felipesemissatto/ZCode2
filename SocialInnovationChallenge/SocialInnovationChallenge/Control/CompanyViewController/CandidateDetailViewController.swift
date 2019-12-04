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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stackView: UIStackView!
    
    //MARK: Views
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inviteButton.layer.cornerRadius = 4
        nameLabel.text = egress!.name
        descriptionTextView.text = egress!.description
        createExperienceView(index : 1)
        createExperienceView(index: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "SectionHeaderView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "SectionHeaderView")
        
            
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
    
    func createExperienceView(index : Int){
        let contentView = ExperiencesView(frame: CGRect(x: 235 * CGFloat(index - 1), y: 0, width: 230, height: 145))
        
        if index > 1{
            stackViewHeightConstraint.constant += 235
        }
        
        contentView.subtitleLabel.text = "nanananana"
        
        
        stackView.addSubview(contentView)
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
    
}



//MARK: Invite actions
extension CandidateDetailViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView(frame: .zero)
          
        switch section {
            case 0:
                view.titleLabel.text = "Cursos"
            case 1:
                view.titleLabel.text = "Objetivos e Sonhos"
            default:
                title = ""
        }
        return view
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if egress!.courses != nil{
                return egress!.courses!.count
            }
            else{
                return 0
            }
        case 1:
            return egress!.desires.count
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        
        switch indexPath.section {
        case 0:
            if egress!.courses != nil{
                cell.textLabel!.text = egress!.courses![indexPath.row]
                tableViewHeightConstraint.constant += 30
                contentViewHeightConstraint.constant += 30
            }
        case 1:
            cell.textLabel!.text = egress!.desires[indexPath.row]
            tableViewHeightConstraint.constant += 30
            contentViewHeightConstraint.constant += 30
        default:
            print("")
        }
        
        return cell
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
//                        self.profileImage.image = UIImage(data: data!)
                    }
                }
            }).resume()
        }
    }
//    link bom que ensina a criar alertas: https://medium.com/swift-india/uialertcontroller-in-swift-22f3c5b1dd68
}
