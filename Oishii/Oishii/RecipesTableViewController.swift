//
//  RecipesTableViewController.swift
//  Oishii
//
//  Created by studentuser on 11/27/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {
    
    var selectedRecipe : Recipe = Recipe()
    
    var filteredRecipes = YummyData.shared.recipes
    
    @IBOutlet weak var searchbar: UISearchBar!
    
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
        return YummyData.shared.recipes.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as! RecipesTableViewCell
        cell.recipeName.text = YummyData.shared.recipes[indexPath.row].name
        cell.recipeDesc.text = YummyData.shared.recipes[indexPath.row].shortDescription
        
         //Configure the cell...
        

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = YummyData.shared.recipes[indexPath.row]
        performSegue(withIdentifier: "recipesToRecipe", sender: self)
    }
    
    @IBAction func goToSettings(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "recipesToSettings", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipesToRecipe" {
            let recipeViewController = segue.destination as! RecipeViewController
            recipeViewController.selectedRecipe = selectedRecipe
            //Variables go here
        } else if segue.identifier == "recipesToSettings" {
            let settingsViewController = segue.destination as! SettingsViewController
            //Variables go here
            settingsViewController.sourceScreen = "Recipes"
        }

    }
    
    func filterContentForSearchText(SearchText: String) {
        
    }
}
