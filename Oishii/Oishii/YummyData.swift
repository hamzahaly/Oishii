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
    override init() {
        super.init()
        FIRApp.configure()
        ref = FIRDatabase.database().reference()
        load()
    }
    
    func load() {
        ref.child("recipes").observe(FIRDataEventType.value, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            print(strongSelf)
        })
    }
    
    func save(_ content:NSData){
        
    }
}
