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
import FirebaseStorage

class YummyData: NSObject {
    static let shared = YummyData()
    private static let recipesSave = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    private static let recipesSavePath = recipesSave.appendingPathComponent("recipes")
    
    private static let editorsSave = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    private static let editorsSavePath = editorsSave.appendingPathComponent("editors")
    
    private static let favSave = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
    private static let faveSavePath = favSave.appendingPathComponent("favorites")
    var ref: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    var recipes: [Recipe] = [Recipe]()
    var favoriteRecipes: [Recipe] = [Recipe]()
    var editors: [Recipe] = [Recipe]()
    //var theme : Bool = false
    
    func setup(){
        // configure Firebase
        FIRApp.configure()
        
        // get Firebase references
        ref = FIRDatabase.database().reference()
        let storage = FIRStorage.storage()
        storageRef = storage.reference(forURL: "gs://oishii-5ce2e.appspot.com")
        
        // start loading offline data
        loadOffline()
        NSLog("\(editors)")
        NSLog("\(favoriteRecipes)")
        
        // get online data
        ref.child("recipes").observeSingleEvent(of: .value, with: { (snapshot) in
            self.recipes = [Recipe]()
            self.editors = [Recipe]()
            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let data = child.value as! [String:Any]
                let recipe = Recipe()
                recipe.name = data["name"] as! String
                recipe.recipeid = data["recipeid"] as! String
                recipe.shortDescription = data["short_description"] as! String
                recipe.longDescription = data["long_description"] as! String
                recipe.ingredients = data["ingredients"] as! [String]
                recipe.procedure = data["procedure"] as! [String]
                recipe.categories = data["categories"] as! [String]
                recipe.editors = data["editors"] as! Bool
                self.recipes.append(recipe)
                if(recipe.editors){
                    self.editors.append(recipe)
                }
            }
            
            // save to offline
            self.save()
        })
    }
    
    func save(){
        NSKeyedArchiver.archiveRootObject(recipes, toFile: YummyData.recipesSavePath)
        NSKeyedArchiver.archiveRootObject(editors, toFile: YummyData.editorsSavePath)
        saveFavorites()
    }
    
    func saveFavorites() {
        NSKeyedArchiver.archiveRootObject(favoriteRecipes, toFile: YummyData.faveSavePath)
    }
    
    func loadOffline(){
        if let loadArr: [Recipe] = NSKeyedUnarchiver.unarchiveObject(withFile: YummyData.recipesSavePath) as? [Recipe] {
            recipes = loadArr
        }
        
        if let loadArr: [Recipe] = NSKeyedUnarchiver.unarchiveObject(withFile: YummyData.editorsSavePath) as? [Recipe] {
            editors = loadArr
        }
        if let loadArr: [Recipe] = NSKeyedUnarchiver.unarchiveObject(withFile: YummyData.faveSavePath) as? [Recipe] {
            favoriteRecipes = loadArr
        }
    }
    
    func load(recipeid: String, image: String, into: UIImageView){
        let recipeImageRef = storageRef.child("\(recipeid)/\(image).png")
        recipeImageRef.downloadURL { (URL, error) -> Void in
            if (error != nil) {
                // Handle any errors
            } else {
                // Get the download URL for 'images/stars.jpg'
                into.sd_setImage(with: URL)
            }
        }
    }
}
