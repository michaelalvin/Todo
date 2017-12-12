//
//  Post.swift
//  Classpage
//
//  Created by Michael Alvin on 7/12/16.
//  Copyright © 2016 Make School. All rights reserved.
//

import Foundation
import Firebase

struct Post {
    
    let note: String!
    let ref: DatabaseReference?
    let modificationTime: NSDate
//    let modificationTime: String!
    
    init(note: String, time: NSDate) {
        self.note = note
        // self.modificationTime = time
        self.modificationTime = time
        self.ref = nil
    }
    
//    
//    init(snapshot: FIRDataSnapshot) {
//        note = snapshot.value!["note"] as! String
//        ref = snapshot.ref
//        // modificationTime = NSDate()
//        modificationTime = snapshot.value!["modificationTime"] as! String
//        ups = snapshot.value!["ups"] as! String
//    }
//    
//    func toAnyObject() -> [String:AnyObject] {
//        return [
//            "note": note,
//            "comment" : comment!,
//            "ups": ups,
//            "modificationTime": modificationTime
//        ]
//    }
    
}
