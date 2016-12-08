//
//  Recipe.swift
//  Oishii
//
//  Created by Bentai on 12/6/16.
//  Copyright © 2016 Bentai. All rights reserved.
//

import Foundation

class Recipe: NSObject {
    var recipeid: String = ""
    var name: String = ""
    var shortDescription: String = ""
    var longDescription: String = ""
    var ingredients: [String] = []
    var procedure: [String] = []
    var categories: [String] = []
    var editors: Bool = false
}
