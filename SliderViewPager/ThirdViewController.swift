//
//  ThirdViewController.swift
//  SliderViewPager
//
//  Created by Neeraj kumar on 23/07/19.
//  Copyright © 2019 prolifics. All rights reserved.
//

import UIKit
import CoreData

class ThirdViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var educationTextField: UITextField!
    @IBOutlet weak var fetchDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.retrieveData()
    }

    @IBAction func insertData(_ sender: Any) {
        guard let name = nameTextField.text else{
            return
        }
        guard let education = educationTextField.text else{
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "UserData", in: managedContext)!
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(name, forKey: "name")
        user.setValue(education, forKey: "education")
        
        do{
            try managedContext.save()
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
            print(paths[0])
        }catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    
    func retrieveData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserData")
        do{
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                self.fetchDataLabel.text = "\(data.value(forKey: "name") as! String)  \(data.value(forKey: "education") as! String)."
                print(data.value(forKey: "name") as! String)
                print(data.value(forKey: "education") as! String)
            }
        }catch{
            print("failed...")
        }
    }
    
}
