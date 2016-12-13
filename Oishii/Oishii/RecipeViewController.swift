//
//  RecipeViewController.swift
//  Oishii
//
//  Created by Bentai on 11/27/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    var selectedRecipe : Recipe = Recipe()
    var favoritedRecipe : Bool = false
    
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeLongDescription: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(favoriteRecipe))
        singleTap.numberOfTapsRequired = 1
        favoriteIcon.isUserInteractionEnabled = true
        favoriteIcon.addGestureRecognizer(singleTap)
        
        recipeName.text = selectedRecipe.name
        recipeLongDescription.text = selectedRecipe.longDescription
        
        let recipeImageRef = YummyData.shared.storageRef.child("\(selectedRecipe.recipeid)/IMG_COVER.png")
        recipeImageRef.downloadURL { (URL, error) -> Void in
            if (error != nil) {
                // Handle any errors
                NSLog("\(error)")
            } else {
                // Get the download URL for 'images/stars.jpg'
                self.recipeImage.sd_setImage(with: URL)
            }
        }
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
    
    //Action
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
