//
//  Facts.swift
//  TelstraExcercise
//
//  Created by Mac on 11/06/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

struct Fact
{
    var title : String
    var description : String
    var imageHref : String
    
    init(dict : Dictionary<String,AnyObject>) {
        self.title = dict["title"] as? String ?? "No Title Available"
        self.description = dict["description"] as? String ?? "No Description Available"
        self.imageHref = dict["imageHref"] as? String ?? ""
    }
}


struct Facts {
    var title : String
    var rows : [Fact]
    
    init(dict : Dictionary<String,AnyObject>) {
        self.title = dict["title"] as? String ?? "";
        let arrayOfRows = dict["rows"] as? [[String:AnyObject]] ?? []
        self.rows = arrayOfRows.map(Fact.init)
        
    }
}
