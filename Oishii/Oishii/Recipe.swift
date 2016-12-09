//
//  Recipe.swift
//  Oishii
//
//  Created by Bentai on 12/6/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import Foundation

class Recipe: NSObject, NSCoding {
    var recipeid: String = ""
    var name: String = ""
    var shortDescription: String = ""
    var longDescription: String = ""
    var ingredients: [String] = []
    var procedure: [String] = []
    var categories: [String] = []
    var editors: Bool = false
    
    override init(){
        super.init()
    }
    
    required init (coder aDecoder: NSCoder) {
        super.init()
        self.recipeid = aDecoder.decodeObject(forKey: "recipeid") as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.shortDescription = aDecoder.decodeObject(forKey: "short_description") as! String
        self.longDescription = aDecoder.decodeObject(forKey: "long_description") as! String
        self.ingredients = aDecoder.decodeObject(forKey: "ingredients") as! [String]
        self.procedure = aDecoder.decodeObject(forKey: "procedure") as! [String]
        self.categories = aDecoder.decodeObject(forKey: "categories") as! [String]
        self.editors = aDecoder.decodeBool(forKey: "editors")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(recipeid, forKey:"recipeid")
        aCoder.encode(name, forKey:"name")
        aCoder.encode(shortDescription, forKey:"short_description")
        aCoder.encode(longDescription, forKey:"long_description")
        aCoder.encode(ingredients, forKey:"ingredients")
        aCoder.encode(procedure, forKey:"procedure")
        aCoder.encode(categories, forKey:"categories")
        aCoder.encode(editors, forKey:"editors")
    }
}
