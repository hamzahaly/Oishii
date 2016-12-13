//
//  RecipesTableViewController.swift
//  Oishii
//
//  Created by Bentai on 11/27/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit
import SDWebImage

protocol CustomRecipeSearchControllerDelegate {
    func didTapOnSearchButton(searchString : String)
    
}

class RecipesTableViewController: UITableViewController, UISearchBarDelegate {
    
    var selectedRecipe : Recipe = Recipe()
    var filteredRecipes : [Recipe] = [Recipe]()
    var sentSearch = false
    var loopCounter = 0

    var customDelegate : CustomRecipeSearchControllerDelegate!
    
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
            return filteredRecipes.count
        } else {
            if YummyData.shared.recipes.count == 0 {
                let alert = UIAlertController(title: "No Recipes", message: "Could not retrieve recipes", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }

            return YummyData.shared.recipes.count
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as! RecipesTableViewCell
        
        if sentSearch {
            let recipeImageRef = YummyData.shared.storageRef.child("\(filteredRecipes[indexPath.row].recipeid)/IMG_ICON.png")
            cell.recipeName.text = filteredRecipes[indexPath.row].name
            cell.recipeDesc.text = filteredRecipes[indexPath.row].shortDescription
            recipeImageRef.downloadURL { (URL, error) -> Void in
                if (error != nil) {
                    // Handle any errors
                } else {
                    // Get the download URL for 'images/stars.jpg'
                    cell.recipeImage.sd_setImage(with: URL)
                }
            }
            loopCounter+=1
        } else {
            let recipeImageRef = YummyData.shared.storageRef.child("\(YummyData.shared.recipes[indexPath.row].recipeid)/IMG_ICON.png")
            cell.recipeName.text = YummyData.shared.recipes[indexPath.row].name
            cell.recipeDesc.text = YummyData.shared.recipes[indexPath.row].shortDescription
            recipeImageRef.downloadURL { (URL, error) -> Void in
                if (error != nil) {
                    // Handle any errors
                    NSLog("\(error)")
                } else {
                    // Get the download URL for 'images/stars.jpg'
                    cell.recipeImage.sd_setImage(with: URL)
                }
            }
        }
        if loopCounter == filteredRecipes.count {
            sentSearch = false
            loopCounter = 0
        }
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
        
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
            for recipe in YummyData.shared.recipes {
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
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: {(_: UIAlertAction!) -> Void in self.searchbar.text = ""}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayNoResultsErrorMessage() {
        let alert = UIAlertController(title: "No Results", message: "Please try searching again", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: {(_: UIAlertAction!) -> Void in self.searchbar.text = ""}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
        searchbar.text = ""
        filteredRecipes.removeAll()
        enableCancelButton(bool: false)
        self.tableView.reloadData()
    }
    
    func enableCancelButton(bool: Bool) {
        for subView in searchbar.subviews {
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
            selectedRecipe = YummyData.shared.recipes[indexPath.row]
        } else {
            NSLog(String(filteredRecipes.count))
            selectedRecipe = filteredRecipes[indexPath.row]
        }
        performSegue(withIdentifier: "recipesToRecipe", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "recipesToRecipe" {
            let recipeViewController = segue.destination as! RecipeViewController
            recipeViewController.selectedRecipe = selectedRecipe
            //Variables go here
        }
    }
}
