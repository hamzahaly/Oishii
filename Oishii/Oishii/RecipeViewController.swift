//
//  RecipeViewController.swift
//  Oishii
//
//  Created by studentuser on 11/27/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    var selectedRecipe : Recipe = Recipe()
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeLongDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeName.text = selectedRecipe.name
        recipeLongDescription.text = selectedRecipe.longDescription
        // Do any additional setup after loading the view.
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
