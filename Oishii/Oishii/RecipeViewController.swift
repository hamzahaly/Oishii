//
//  RecipeViewController.swift
//  Oishii
//
//  Created by studentuser on 11/27/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    var selectedRecipe : Recipe = Recipe()
    
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
        // Do any additional setup after loading the view.
    }
    
    //Action
    func favoriteRecipe() {
        var recipeCount : Int = 0
        for recipe in YummyData.shared.recipes {
            if selectedRecipe.recipeid == recipe.recipeid {
                break
            }
            recipeCount+=1
        }
        YummyData.shared.recipes[recipeCount].favorite = true
        NSLog("\(selectedRecipe.name) # \(recipeCount) was favorited/unfavorited")
        
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
