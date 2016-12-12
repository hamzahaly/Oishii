//
//  FavoritesTableViewController.swift
//  Oishii
//
//  Created by Bentai on 11/29/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController, UISearchBarDelegate {
    
    var recipeList = YummyData.shared.recipes
    var selectedRecipe : Recipe = Recipe()
    var filteredRecipes : [Recipe] = [Recipe]()
    var sentSearch = false
    var loopCounter = 0

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.searchBar.enablesReturnKeyAutomatically = false
        self.searchBar.showsCancelButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if searchBar.text == "" {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if sentSearch {
            return filteredRecipes.count
        } else {
            return YummyData.shared.favoriteRecipes.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FavoritesCell", for: indexPath) as! FavoritesTableViewCell
        
        if sentSearch {
            cell.recipeName.text = filteredRecipes[indexPath.row].name
            cell.recipeDesc.text = filteredRecipes[indexPath.row].shortDescription
        } else {
            cell.recipeName.text = YummyData.shared.favoriteRecipes[indexPath.row].name
            cell.recipeDesc.text = YummyData.shared.favoriteRecipes[indexPath.row].shortDescription
        }
        
        if loopCounter == filteredRecipes.count {
            sentSearch = false
            loopCounter = 0
        }
        sentSearch = false
        
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text != nil {
            self.didTapOnSearchButton(searchString: searchBar.text!)
        } else {
            NSLog("String is nil!")
        }
    }
    
    func didTapOnSearchButton(searchString : String) {
        enableCancelButton(bool: false)
        if searchString.characters.count == 1 {
            filteredRecipes.removeAll()
            displayCharacterCountErrorMessage()
        } else if searchString != "" {
            let searchString : String = searchString.lowercased()
            filteredRecipes.removeAll()
            for recipe in YummyData.shared.favoriteRecipes {
                if recipe.name.lowercased().contains(searchString) {
                    filteredRecipes.append(recipe)
                }
            }
            
            if filteredRecipes.count > 0 {
                sentSearch = true
                enableCancelButton(bool: true)
            } else {
                displayNoResultsErrorMessage()
            }
        }
        if searchString == "" {
            filteredRecipes.removeAll()
        }
        self.tableView.reloadData()
    }
    
    func displayCharacterCountErrorMessage() {
        let alert = UIAlertController(title: "Search Error!", message: "Please enter more than 1 character when searching", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: {(_: UIAlertAction!) -> Void in self.searchBar.text = ""}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayNoResultsErrorMessage() {
        let alert = UIAlertController(title: "No Results", message: "Please try searching again", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: {(_: UIAlertAction!) -> Void in self.searchBar.text = ""}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        filteredRecipes.removeAll()
        enableCancelButton(bool: false)
        self.tableView.reloadData()
    }
    
    func enableCancelButton(bool: Bool) {
        for subView in searchBar.subviews {
            for possibleButton in subView.subviews {
                if possibleButton is UIButton {
                    if let cancelButton = possibleButton as? UIButton {
                        cancelButton.isEnabled = bool
                        break;
                    }
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if filteredRecipes.count == 0 {
            selectedRecipe = YummyData.shared.favoriteRecipes[indexPath.row]
        } else {
            selectedRecipe = filteredRecipes[indexPath.row]
        }
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
