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
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(loadEditors(notification:)), name:NSNotification.Name(rawValue: "loadEditors"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(failedLoad(notification:)), name:NSNotification.Name(rawValue: "failedLoad"), object: nil)
        
        self.tableView.reloadData()
    }
    
    func loadEditors(notification: NSNotification) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failedLoad(notification: NSNotification) {
        let alert = UIAlertController(title: "Failure", message: "Invalid JSON, failed to load", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
