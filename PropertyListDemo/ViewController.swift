//
//  ViewController.swift
//  PropertyListDemo
//
//  Created by Mohamed Sobhi  Fouda on 4/6/18.
//  Copyright © 2018 Mohamed Sobhi Fouda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let plistUrl = Bundle.main.url(forResource: "People", withExtension: "plist")
    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var plistFormat = PropertyListSerialization.PropertyListFormat.xml
        
        do {
            let plistData = try Data(contentsOf: plistUrl!)
            let people = try PropertyListSerialization.propertyList(from: plistData, options: [], format: &plistFormat) as! [Dictionary<String, Any>]
            
            for person in people {
                print("First Name: \(String(describing: person["First Name"])), Last Name: \(String(describing: person["Last Name"])), Age: \(String(describing: person["Age"]))")
            }
        } catch {
            print("Error")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

