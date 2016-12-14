//
//  RecipeViewController.swift
//  Oishii
//
//  Created by Bentai on 11/27/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit
import MessageUI

class RecipeViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    var selectedRecipe : Recipe = Recipe()
    var favoritedRecipe : Bool = false
    
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeLongDescription: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ingredImage: UIImageView!
    @IBOutlet weak var finalImage: UIImageView!
    @IBOutlet weak var ingredList: UILabel!
    @IBOutlet weak var recipeInstructions: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(favoriteRecipe))
        singleTap.numberOfTapsRequired = 1
        favoriteIcon.isUserInteractionEnabled = true
        favoriteIcon.addGestureRecognizer(singleTap)
        
        recipeName.text = selectedRecipe.name
        var cats = "\nGood for: "
        for cat in selectedRecipe.categories{
            cats += cat
            if(cat != selectedRecipe.categories[selectedRecipe.categories.count - 1]){
                cats += ", "
            }
        }
        recipeLongDescription.text = "\(selectedRecipe.longDescription)\n\(cats)"
        
        var buffer = ""
        for ingredient in selectedRecipe.ingredients {
            buffer += "- "
            buffer += ingredient
            buffer += "\n"
        }
        ingredList.text = buffer
        buffer = ""
        for index in 0 ..< selectedRecipe.procedure.count {
            buffer += "\(index+1). "
            buffer += selectedRecipe.procedure[index]
            if(index != selectedRecipe.procedure.count - 1){
                buffer += "\n\n"
            }
        }
        recipeInstructions.text = buffer
        
        YummyData.shared.load(recipeid: selectedRecipe.recipeid, image: "IMG_COVER", into: recipeImage)
        YummyData.shared.load(recipeid: selectedRecipe.recipeid, image: "IMG_INGRED", into: ingredImage)
        YummyData.shared.load(recipeid: selectedRecipe.recipeid, image: "IMG_FINISH", into: finalImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if YummyData.shared.favoriteRecipes.contains(where: {$0.recipeid == selectedRecipe.recipeid}) {
            favoritedRecipe = true
            favoriteIcon.image = UIImage(named: "heart-filled")
        } else {
            favoritedRecipe = false
            favoriteIcon.image = UIImage(named: "heart-unfilled")
        }
    
    }
    
    //Favorite Recipe
    func favoriteRecipe() {
        if favoritedRecipe { //You want to unfavorite
            if let index = YummyData.shared.favoriteRecipes.index(where: {$0.recipeid == selectedRecipe.recipeid}) {
                YummyData.shared.favoriteRecipes.remove(at: index)
            }
            
            favoriteIcon.image = UIImage(named: "heart-unfilled")
            favoritedRecipe = false
        } else { //You want to favorite
            YummyData.shared.favoriteRecipes.append(selectedRecipe)
            favoriteIcon.image = UIImage(named: "heart-filled")
            favoritedRecipe = true
            YummyData.shared.favoriteRecipes.sort { $0.name < $1.name }
        }
        
        //save favorites to local storage
        YummyData.shared.saveFavorites()
    }

    @IBAction func emailRecipe(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setSubject("Recipe for \(selectedRecipe.name)")
        mailComposerVC.addAttachmentData(UIImagePNGRepresentation(recipeImage.image!)!, mimeType: "image/png", fileName:  "\(selectedRecipe.name).png")
        mailComposerVC.setMessageBody("\(recipeLongDescription.text!)\n\n\(ingredList.text!)\n\(recipeInstructions.text!)\n\nRecipe from Oishii", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: UIAlertControllerStyle.alert)
        sendMailErrorAlert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    @IBAction func textRecipe(_ sender: Any) {
        if MFMessageComposeViewController.canSendText() {
            let controller = MFMessageComposeViewController()
            controller.body = "Check out Oishii to find a recipe for \(selectedRecipe.name)!"
            controller.messageComposeDelegate = self
            if MFMessageComposeViewController.canSendAttachments() {
                controller.addAttachmentData(UIImagePNGRepresentation(recipeImage.image!)!, typeIdentifier: "image/png", filename:"\(selectedRecipe.name).png")
            }
            self.present(controller, animated: true, completion: nil)
        } else {
            let sendTextErrorAlert = UIAlertController(title: "Could Not Send Text", message: "Your device could not send text.  Please check texting configuration and try again.", preferredStyle: UIAlertControllerStyle.alert)
            sendTextErrorAlert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(sendTextErrorAlert, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
