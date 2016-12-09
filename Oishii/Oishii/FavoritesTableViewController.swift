//
//  FavoritesTableViewController.swift
//  Oishii
//
//  Created by Bentai on 11/29/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    var recipeList = YummyData.shared.recipes
    var selectedRecipe : Recipe = Recipe()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        NSLog("Test")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return YummyData.shared.favoriteRecipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as! FavoritesTableViewCell
        cell.recipeName.text = YummyData.shared.favoriteRecipes[indexPath.row].name
        cell.recipeDesc.text = YummyData.shared.favoriteRecipes[indexPath.row].shortDescription
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = YummyData.shared.recipes[indexPath.row]
        performSegue(withIdentifier: "favoritesToRecipe", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoritesToRecipe" {
            let recipeViewController = segue.destination as! RecipeViewController
            recipeViewController.selectedRecipe = selectedRecipe
            //Variables go here
        }
        
    }
}
