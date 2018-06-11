//
//  ViewController.swift
//  TelstraExcercise
//
//  Created by Mac on 11/06/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var fact : Facts?
    var factpresenter = FactPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call webservices to get facts records
        self.callFactsAPIservice()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Method to get data from remote server
    func callFactsAPIservice()  {
        factpresenter.getFacts(complete: { (facts) in
            print(facts);
            
        }) { (error) in
            print(error.localizedDescription)
            
        }
    }
}

