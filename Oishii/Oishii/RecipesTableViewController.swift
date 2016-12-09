//
//  RecipesTableViewController.swift
//  Oishii
//
//  Created by Bentai on 11/27/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit

protocol CustomSearchControllerDelegate {
    func didTapOnSearchButton(searchString : String)
    
}

class RecipesTableViewController: UITableViewController, UISearchBarDelegate {
    
    var selectedRecipe : Recipe = Recipe()
    var searchArray : [Recipe] = [Recipe]()
    var sentSearch = false
    

    var customDelegate : CustomSearchControllerDelegate!
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchbar.delegate = self
        self.searchbar.enablesReturnKeyAutomatically = false
        self.searchbar.showsCancelButton = true
        
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
        if sentSearch {
            return searchArray.count
        } else {
            return YummyData.shared.recipes.count
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as! RecipesTableViewCell
        if sentSearch {
            cell.recipeName.text = searchArray[indexPath.row].name
            cell.recipeDesc.text = searchArray[indexPath.row].shortDescription
        } else {
            cell.recipeName.text = YummyData.shared.recipes[indexPath.row].name
            cell.recipeDesc.text = YummyData.shared.recipes[indexPath.row].shortDescription

        }
        sentSearch = false

        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
        NSLog(searchBar.text!)
        if searchBar.text != nil {
            self.didTapOnSearchButton(searchString: searchBar.text!)
        } else {
            NSLog("String is nil!")
        }
    }
    
    func didTapOnSearchButton(searchString : String) {
        if searchString.characters.count == 1 {
            searchArray.removeAll()
            displayCharacterCountErrorMessage()
        } else if searchString != "" {
            let searchString : String = searchString.lowercased()
            searchArray.removeAll()
            for recipe in YummyData.shared.recipes {
                if recipe.name.lowercased().contains(searchString) {
                    searchArray.append(recipe)
                }
            }
            NSLog(String(searchArray.count))
            if searchArray.count > 0 {
                sentSearch = true
                
            } else {
                displayNoResultsErrorMessage()
            }
        }
        if searchString == "" {
            searchArray.removeAll()
        }
        self.tableView.reloadData()
    }
    
    func displayCharacterCountErrorMessage() {
        let alert = UIAlertController(title: "Search Error!", message: "Please enter more than 1 character when searching", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayNoResultsErrorMessage() {
        let alert = UIAlertController(title: "No Results", message: "Please try searching again", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
        searchbar.text = ""
        searchArray.removeAll()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchArray.count == 0 {
            selectedRecipe = YummyData.shared.recipes[indexPath.row]
        } else {
            NSLog(String(searchArray.count))
            selectedRecipe = searchArray[indexPath.row]
        }
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
}
