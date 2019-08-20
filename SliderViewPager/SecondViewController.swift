//
//  SecondViewController.swift
//  SliderViewPager
//
//  Created by Neeraj kumar on 23/07/19.
//  Copyright © 2019 prolifics. All rights reserved.
//

import UIKit

struct cellData {
    
    var opened = Bool()
    var title = String()
    var one = String()
    var two = String()
    var three = String()
    
//    let cell: Int!
//    let buttonText: String!
//    let textF: String!
//    let oneText: String!
//    let twoText: String!
//    let threeText: String!
    
}

class SecondViewController: UIViewController {
    var arrayofCellData = [cellData]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayofCellData = [
        cellData(opened: false, title: "Click", one: "OneValue", two: "SecondValue", three: "ThirdValue"),
        cellData(opened: false, title: "Click", one: "OneValue", two: "SecondValue", three: "ThirdValue"),
        cellData(opened: false, title: "Click", one: "OneValue", two: "SecondValue", three: "ThirdValue")
        ]
        
//        arrayofCellData = [cellData(cell: 1, buttonText: "Click", textF: "8", oneText: "one", twoText: "two", threeText: "hello"),
//        cellData(cell: 2, buttonText: "Click", textF: "8", oneText: "one", twoText: "two", threeText: "hello"),
//        cellData(cell: 3, buttonText: "Click", textF: "8", oneText: "one", twoText: "two", threeText: "hello")]

    }
    
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrayofCellData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayofCellData[section].opened == true{
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            
            let cell = Bundle.main.loadNibNamed("HeaderTableViewCell", owner: self, options: nil)?.first as! HeaderTableViewCell
            cell.button.titleLabel?.text = arrayofCellData[indexPath.row].title
            cell.textField.text = arrayofCellData[indexPath.row].title
            return cell
            
        }else{
            
            let cell = Bundle.main.loadNibNamed("ValueTableViewCell", owner: self, options: nil)?.first as! ValueTableViewCell
            cell.oneLabel.text = self.arrayofCellData[indexPath.row].one
            cell.twoLabel.text = self.arrayofCellData[indexPath.row].two
            cell.threeLabel.text = self.arrayofCellData[indexPath.row].three
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arrayofCellData[indexPath.section].opened == true{
            arrayofCellData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }else{
            arrayofCellData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
        }
        
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if arrayofCellData[indexPath.row].cell == 1{
//           return 60
//        }else if arrayofCellData[indexPath.row].cell == 2{
//           return 80
//        }else{
//            return 60
//        }
//    }
 
}
