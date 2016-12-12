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
        recipeName.text = selectedRecipe.name
        recipeLongDescription.text = selectedRecipe.longDescription
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(RecipeViewController.favoriteRecipe))
        singleTap.numberOfTapsRequired = 1
        favoriteButton.isUserInteractionEnabled = true
        favoriteButton.addGestureRecognizer(singleTap)
        
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
