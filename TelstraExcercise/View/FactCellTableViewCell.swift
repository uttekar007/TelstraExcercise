//
//  FactCellTableViewCell.swift
//  TelstraExcercise
//
//  Created by Mac on 11/06/18.
//  Copyright © 2018 Mac. All rights reserved.
//

import UIKit

class FactCellTableViewCell: UITableViewCell {
    
    //MARK: Subviews
    //Add View Programmatically
    let factImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        //…
        imageView.translatesAutoresizingMaskIntoConstraints = false //Must use
        return imageView
    }()
    
    
    let factTitle: UILabel = {
        let label = UILabel()
        label.text = " Title "
        label.translatesAutoresizingMaskIntoConstraints = false //Must use
        return label
    }()
    
    let factDiscription: UILabel = {
        let label = UILabel()
        label.text = " Discription "
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false //Must use
        return label
    }()
    
    
    // Initialization methods
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViewsAndlayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Method to set constraits for cell's properties
    func addSubViewsAndlayout() {
        contentView.addSubview(factImageView)
        contentView.addSubview(factTitle) //will crash if not added
        contentView.addSubview(factDiscription)
        //let screenwidth = UIScreen.main.bounds.width //get any other properties you need
        
        if #available(iOS 9.0, *) {
            factImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
            factImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10.0).isActive = true
            factImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            factImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            factTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10.0).isActive = true
            factTitle.heightAnchor.constraint(equalToConstant: 22).isActive = true
            factTitle.leftAnchor.constraint(equalTo: self.factImageView.rightAnchor, constant: 10.0).isActive = true
            factTitle.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5.0).isActive = true
            
            factDiscription.topAnchor.constraint(equalTo: self.factTitle.bottomAnchor, constant: 5.0).isActive = true
            factDiscription.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5.0).isActive = true
            factDiscription.leftAnchor.constraint(equalTo: self.factImageView.rightAnchor, constant: 10.0).isActive = true
            factDiscription.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5.0).isActive = true
            
        } else {
            // Fallback on earlier versions
        }
        
        
    }
    
    // Method to set the property of cell
    func configureCell(fact : Fact, tableView : UITableView, indexPath : IndexPath)  {
        
        self.factTitle.text = fact.title
        
        self.factDiscription.text = fact.description
        
        self.factImageView.image = nil
        
        let url = URL(string:(fact.imageHref))
        var task: URLSessionTask? = nil
        if let anUrl = url {
            task = URLSession.shared.dataTask(with: anUrl, completionHandler: { data, response, error in
                if data != nil {
                    var image: UIImage? = nil
                    if let aData = data {
                        image = UIImage(data: aData)
                    }
                    if image != nil {
                        DispatchQueue.main.async(execute: {
                            let updateCell = tableView.cellForRow(at: indexPath as IndexPath) as? FactCellTableViewCell
                            if updateCell != nil {
                                updateCell?.factImageView.image = image
                            }
                        })
                    }
                }
            })
        }
        task?.resume()
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
