//
//  HomeViewController.swift
//  Oishii
//
//  Created by Bentai on 11/29/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedRecipe : Recipe = Recipe()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return YummyData.shared.editors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "EditorsCell", for: indexPath) as! HomeTableViewCell
        YummyData.shared.load(recipeid: YummyData.shared.editors[indexPath.row].recipeid, image: "IMG_COVER_EDITORS", into: cell.recipeImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = YummyData.shared.editors[indexPath.row]
        performSegue(withIdentifier: "homeToRecipe", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToRecipe" {
            let recipeViewController = segue.destination as! RecipeViewController
            recipeViewController.selectedRecipe = selectedRecipe
        }
    }
}
