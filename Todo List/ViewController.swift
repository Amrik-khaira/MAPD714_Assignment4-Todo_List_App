//
//  ViewController.swift
//  Author's name : Amrik Singh
//  StudentID : 301296257
//
//  Todo List app
//
//  Created by Amrik on 12/11/22.
// Version: 1.0


import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    
    @IBOutlet weak var tblViwShopList: UITableView!
    
    //MARK: - Array to store data
    var TodoArr = [ToDoList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    
    //MARK: - tableView datasource and delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        let objTodo = TodoArr[indexPath.row]
        cell.lblShortTitle.text = objTodo.shorTitle ?? "Todo Details Screen should"
        cell.lblLongDes.text = objTodo.longDesc  ?? "Overdue"
      
       
        return cell
    }

}


//MARK: - TableView Cell class
class TodoCell: UITableViewCell {
    //MARK: - connections
    var callbackforEditTask: ((TodoCell) -> Void)?
  
  
    @IBOutlet weak var lblShortTitle: UILabel!
    @IBOutlet weak var lblLongDes: UILabel!
   
    @IBOutlet weak var SwitchTaskState: UISwitch!
    
    //MARK: - Add more item action
    @IBAction func BtnEditTaskAct(_ sender: UIButton) {
        callbackforEditTask?(self)
}
}

//MARK: - Json Structure for handel data Todo List
struct ToDoList:Codable {
    var shorTitle : String?
    var longDesc : String?
    var isComplete : Bool?
    var isDueDate : Bool?
    var Date : String?
}
