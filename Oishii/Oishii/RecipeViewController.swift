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
    @IBOutlet weak var favoriteButton: UIImageView!
    
    override func viewDidLoad() {
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(RecipeViewController.favoriteRecipe))
        singleTap.numberOfTapsRequired = 1 // you can change this value
        favoriteButton.isUserInteractionEnabled = true
        favoriteButton.addGestureRecognizer(singleTap)
        super.viewDidLoad()
        
        recipeName.text = selectedRecipe.name
        recipeLongDescription.text = selectedRecipe.longDescription
        recipeInFavorites()
    }
    
    func recipeInFavorites() {
        for recipe in YummyData.shared.favoriteRecipes {
            if selectedRecipe.recipeid == recipe.recipeid {
                favoritedRecipe = true
                favoriteIcon.image = UIImage(named: "heart-filled")
                break
            }
        }
    }

    
    //Action
    func favoriteRecipe() {
        if favoritedRecipe { //You want to unfavorite
            YummyData.shared.favoriteRecipes.remove(at: YummyData.shared.favoriteRecipes.index(of: selectedRecipe)!)
            favoriteIcon.image = UIImage(named: "heart")
            favoritedRecipe = false
        } else { //You want to favorite
            YummyData.shared.favoriteRecipes.append(selectedRecipe)
            favoriteIcon.image = UIImage(named: "heart-filled")
            favoritedRecipe = true
        }
        //save to local
        
        
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
