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
        if recipeInFavorites() {
            favoriteIcon.image = UIImage(named: "heart-filled")
        } else {
            favoriteIcon.image = UIImage(named: "heart")
        }
        // Do any additional setup after loading the view.
    }
    
    func recipeInFavorites() -> Bool {
        for recipe in YummyData.shared.favoriteRecipes {
            if selectedRecipe.recipeid == recipe.recipeid {
                return true
            }
        }
        return false
    }
    
    //Action
    func favoriteRecipe() {
        var recipeCount : Int = 0
        var foundRecipe = false
        for recipe in YummyData.shared.favoriteRecipes {
            if selectedRecipe.recipeid == recipe.recipeid {
                foundRecipe = true
                break
            }
            recipeCount+=1
        }
        if foundRecipe { //You want to unfavorite
            YummyData.shared.favoriteRecipes.remove(at: recipeCount)
            NSLog("\(selectedRecipe.name) # \(recipeCount) was unfavorited")
            favoriteIcon.image = UIImage(named: "heart")
        } else { //You want to favorite
            YummyData.shared.favoriteRecipes.append(selectedRecipe)
            NSLog("\(selectedRecipe.name) # \(recipeCount) was favorited")
            favoriteIcon.image = UIImage(named: "heart-filled")
        }
        
        
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
