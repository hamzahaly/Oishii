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
    static let path = Bundle.main.path(forResource: "data", ofType: "txt")!
    var ref: FIRDatabaseReference!
    var recipes: [Recipe] = [Recipe]()
    
    func setup(){
        FIRApp.configure()
        ref = FIRDatabase.database().reference()
        ref.child("recipes").observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children.allObjects as! [FIRDataSnapshot] {
                let data = child.value as! [String:Any]
                let recipe = Recipe()
                recipe.name = data["name"] as! String
                recipe.recipeid = data["recipeid"] as! String
//                recipe.shortDescription = data["short_description"] as! String
//                recipe.longDescription = data["long_description"] as! String
                recipe.ingredients = data["ingredients"] as! [String]
                recipe.procedure = data["procedure"] as! [String]
                recipe.categories = data["categories"] as! [String]
                recipe.editors = data["editors"] as! Bool
                self.recipes.append(recipe)
            }
            print("\(self.recipes)")
        })
    }
}
