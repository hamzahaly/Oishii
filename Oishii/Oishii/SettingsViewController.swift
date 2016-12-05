//
//  SettingsViewController.swift
//  Oishii
//
//  Created by iGuest on 11/29/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    var sourceScreen = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToHome(_ sender: UIButton) {
        if sourceScreen == "Home" {
            performSegue(withIdentifier: "settingsToHome", sender: self)
        } else if sourceScreen == "Recipes" {
            performSegue(withIdentifier: "settingsToRecipes", sender: self)
        } else if sourceScreen == "Favorites" {
            performSegue(withIdentifier: "settingsToFavorites", sender: self)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settingsToHome" {
            let homeViewController = segue.destination as! HomeViewController
            //Variables go here
        } else if segue.identifier == "settingsToRecipes" {
            let recipesViewController = segue.destination as! RecipesTableViewController
            //Variables go here
        } else if segue.identifier == "settingsToFavorites" {
            let favoritesViewController = segue.destination as! FavoritesTableViewController
        }
    }
}
