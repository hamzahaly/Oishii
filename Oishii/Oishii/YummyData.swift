//
//  YummyData.swift
//  Oishii
//
//  Created by Thomas on 12/4/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class YummyData: NSObject {
    static let shared = YummyData()
    private static let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "questions"
    var ref: FIRDatabaseReference!
    var recipes: [Recipe] = [Recipe]()
    var favoriteRecipes: [Recipe] = [Recipe]()
    var editors: [Recipe] = [Recipe]()
    
    func setup(){
        FIRApp.configure()
        ref = FIRDatabase.database().reference()
        //loadOffline()
        ref.child("recipes").observeSingleEvent(of: .value, with: { (snapshot) in
            
            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let data = child.value as! [String:Any]
                let recipe = Recipe()
                recipe.name = data["name"] as! String
                recipe.recipeid = data["recipeid"] as! String
                recipe.shortDescription = data["short_description"] as! String
                recipe.ingredients = data["ingredients"] as! [String]
                recipe.procedure = data["procedure"] as! [String]
                recipe.categories = data["categories"] as! [String]
                recipe.editors = data["editors"] as! Bool
                self.recipes.append(recipe)
                if(recipe.editors){
                    self.editors.append(recipe)
                }
            }
            self.save()
            NSLog("\(self.recipes)")
        })
    }
    
    func save(){
        (self.editors as NSArray).write(toFile: YummyData.filePath, atomically:true)
        (self.favoriteRecipes as NSArray).write(toFile: YummyData.filePath, atomically:true)
    }
    
    func loadOffline(){
        editors = NSArray(contentsOfFile:YummyData.filePath) as! [Recipe]
    }
}
