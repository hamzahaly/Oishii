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
    
    func setup(){
        FIRApp.configure()
        FIRDatabase.init()
        ref = FIRDatabase.database().reference()
    }
}
