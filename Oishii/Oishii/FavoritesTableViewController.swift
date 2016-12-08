//
//  FavoritesTableViewController.swift
//  Oishii
//
//  Created by iGuest on 11/29/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    let model = ["Sushi", "Noodles"]
    let desc = ["Sushi", "Noodles"]
    var recipeList = YummyData.shared.recipes
    var selectedRecipe : Recipe = Recipe()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countNumberOfFavoites()
    }
    
    func countNumberOfFavoites() -> Int {
        var count : Int = 0
        for recipe in YummyData.shared.recipes {
            if recipe.favorite {
                count+=1
            }
        }
        return count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as! FavoritesTableViewCell
        if YummyData.shared.recipes[indexPath.row].favorite == true {
            cell.recipeName.text = YummyData.shared.recipes[indexPath.row].name
            cell.recipeDesc.text = YummyData.shared.recipes[indexPath.row].shortDescription
        }
        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = YummyData.shared.recipes[indexPath.row]
        performSegue(withIdentifier: "favoritesToRecipe", sender: self)
    }
    
 
    @IBAction func goToSettings(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "favoritesToSettings", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoritesToRecipe" {
            let recipeViewController = segue.destination as! RecipeViewController
            recipeViewController.selectedRecipe = selectedRecipe
            //Variables go here
        } else if segue.identifier == "favoritesToSettings" {
            let settingsViewController = segue.destination as! SettingsViewController
            //Variables go here
            settingsViewController.sourceScreen = "Favorites"
        }
        
    }
}
