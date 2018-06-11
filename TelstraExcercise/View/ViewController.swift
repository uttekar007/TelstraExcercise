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
    
    let tableView : UITableView = {
        let t = UITableView()
        t.estimatedRowHeight = 70 //put as per your cell row  height
        t.rowHeight = UITableViewAutomaticDimension
        t.translatesAutoresizingMaskIntoConstraints = false
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set datasource
        tableView.dataSource = self
        
        // register a defalut cell
        tableView.register(FactCellTableViewCell.self, forCellReuseIdentifier: "cell")
        
        // add subviews and set it's constaints
        self.addSubViewsAndConstraints()
        // call webservices to get facts records
        self.callFactsAPIservice()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addSubViewsAndConstraints() {
        
        self.view.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
    }
    
    //Method to get data from remote server
    func callFactsAPIservice()  {
        factpresenter.getFacts(complete: { (facts) in
            self.fact = facts
            DispatchQueue.main.async {
                self.title = self.fact?.title
                self.tableView.reloadData()
            }
        }) { (error) in
            print(error.localizedDescription)
            
        }
    }
}


// MARK: - Table view data source
extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let fact = self.fact else { return 0 }
        return fact.rows.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as? FactCellTableViewCell else { return UITableViewCell() }
        if let ObjFact = fact?.rows[indexPath.row]
        {
            cell.configureCell(fact: ObjFact,tableView: tableView,indexPath: indexPath as IndexPath)
        }
        return cell
    }
}

