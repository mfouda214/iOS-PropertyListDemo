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
    var people: [Dictionary<String, Any>]?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        var plistFormat = PropertyListSerialization.PropertyListFormat.xml
//
//        do {
//            let plistData = try Data(contentsOf: plistUrl!)
//            let people = try PropertyListSerialization.propertyList(from: plistData, options: [], format: &plistFormat) as! [Dictionary<String, Any>]
//
//            for person in people {
//                print("First Name: \(String(describing: person["First Name"])), Last Name: \(String(describing: person["Last Name"])), Age: \(String(describing: person["Age"]))")
//            }
//
//            // Unwrapped Example
//            if let fName = people[0]["First Name"] {
//                print("First Name for first person: \(fName)")
//            }
//        } catch {
//            print("Error")
//        }
        
        if fileExistsInDocumentsDirectory() == false {
            seedDataToDocumentsDirectory()
        }
        
        var plistFormat = PropertyListSerialization.PropertyListFormat.xml
        
        do {
            let plistData = try Data(contentsOf: documentsDirectoryFileURL()!)
            people = try PropertyListSerialization.propertyList(from: plistData, options: [], format: &plistFormat) as? [Dictionary<String, Any>]
            
            if var people = people {
                for person in people {
                    print("First Name: \(String(describing: person["First Name"])), Last Name: \(String(describing: person["Last Name"])), Age: \(String(describing: person["Age"]))")
                }
                
                let anotherPerson = ["First Name" : "Mike", "Last Name" : "Holt", "Age" : 35] as [String : Any]
                let yetAnotherPerson = ["First Name" : "Meg", "Last Name" : "Holt", "Age" : 35] as [String : Any]
                people.append(anotherPerson)
                people.append(yetAnotherPerson)
                
                let serializedData = try PropertyListSerialization.data(fromPropertyList: people, format: PropertyListSerialization.PropertyListFormat.xml, options: 0)
                if let file = documentsDirectoryFileURL() {
                    try serializedData.write(to: file)
                    print(file)
                }
            }
        } catch {
            print("Error")
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func documentsDirectoryFileURL() -> URL? {
        do {
            let document = try fileManager.url(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask, appropriateFor: nil, create: false)
            let file = document.appendingPathComponent("People.plist")
            return file
        } catch {
            print("Error getting file path.")
            return nil
        }
    }
    
    func fileExistsInDocumentsDirectory() -> Bool {
        if let file = documentsDirectoryFileURL() {
            let fileExists = FileManager().fileExists(atPath: file.path)
            return fileExists
        }
        
        return false
    }
    
    func seedDataToDocumentsDirectory() {
        do {
            let plistData = try Data(contentsOf: plistUrl!)
            
            if let file = documentsDirectoryFileURL() {
                try plistData.write(to: file)
            }
        } catch {
            print("Error writing file.")
        }
    }

}

