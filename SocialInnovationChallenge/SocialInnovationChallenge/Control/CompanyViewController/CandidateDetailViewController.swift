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
    @IBOutlet weak var dreamLabel0: UILabel!
    @IBOutlet weak var dreamLabel1: UILabel!
    @IBOutlet weak var dreamLabel2: UILabel!
    
    //MARK: Views
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        inviteButton.layer.cornerRadius = 4
        nameLabel.text = egress!.name
        descriptionTextView.text = egress!.description
        dreamLabel0.text! = egress!.desires[0]
        dreamLabel1.text! = egress!.desires[1]
        dreamLabel2.text! = egress!.desires[2]

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
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
    
    func saveAContact(){
        let contact = CNMutableContact()
         
        contact.givenName = "John"
        contact.familyName = "Appleseed"

        //não funciona por algum motivo x
//        let homeEmail = CNLabeledValue(label: CNLabelHome, value:"john@example.com")
//        let workEmail = CNLabeledValue(label:CNLabelWork, value:"j.appleseed@icloud.com")
//        contact.emailAddresses = [homeEmail, workEmail]
         
        contact.phoneNumbers = [CNLabeledValue(
            label:CNLabelPhoneNumberiPhone,
            value:CNPhoneNumber(stringValue:"(408) 555-0126"))]
         
         
         
        // Saving the newly created contact
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier:nil)
        try! store.execute(saveRequest)
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
        
//        alert.addAction(UIAlertAction(title: "Salvar em Meu Contatos", style: .default, handler: { (_) in
//            self.saveAContact()
//        }))

        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (_) in
        }))

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
//    link bom que ensina a criar alertas: https://medium.com/swift-india/uialertcontroller-in-swift-22f3c5b1dd68
}
