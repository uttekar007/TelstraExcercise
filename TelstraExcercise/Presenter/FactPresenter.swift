//
//  FactPresenter.swift
//  TelstraExcercise
//
//  Created by Mac on 11/06/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import Foundation

class FactPresenter {
    
    //get fact data from remote server
    func getFacts(complete : @escaping (Facts)->(), error : @escaping (Error)->()) {
        let apiServices = APIServices()
        
        apiServices.queryToFactsJson { (isComplete, facts, errors) in
            if let err = errors
            {
                error(err)
            }
            if let fact = facts
            {
                complete(fact)
            }
        }
    }
}
