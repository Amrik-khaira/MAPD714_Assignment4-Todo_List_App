//
//  ViewController.swift
//  Author's name : Amrik Singh(301296257) and Hafiz Shaikh(301282061)
//  StudentID :
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
        LoadItems()
    }

    //MARK: - Load default data in dictionary
    func LoadItems()  {
 
        TodoArr =  [ToDoList.init(shorTitle: "Task Name", longDesc: "", isComplete: true, isDueDate: false, Date: ""),ToDoList.init(shorTitle: "Another Task Name", longDesc: "", isComplete: false, isDueDate: false, Date: ""),ToDoList.init(shorTitle: "Yet Another Task Name", longDesc: "", isComplete: false, isDueDate: true, Date: "Sunday, November 20,2022")]
        
    }
    
    //MARK: - tableView datasource and delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        let objTodo = TodoArr[indexPath.row]
        
        if objTodo.isComplete ?? false
        {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: objTodo.shorTitle ?? "")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            cell.lblShortTitle.attributedText = attributeString
            cell.lblLongDes.text = "Completed"
            cell.SwitchTaskState.setOn(false, animated: false)
            cell.lblShortTitle.textColor = UIColor.black
            cell.lblLongDes.textColor = UIColor.black
        }
        else if objTodo.isDueDate ?? false
        {
            cell.lblShortTitle.attributedText = NSAttributedString(string: objTodo.shorTitle ?? "")
            cell.lblLongDes.text = objTodo.Date  ?? ""
            cell.SwitchTaskState.setOn(true, animated: false)
            cell.lblShortTitle.textColor = UIColor.black
            cell.lblLongDes.textColor = UIColor.black
        }
        else
        {
            cell.lblShortTitle.attributedText = NSAttributedString(string: objTodo.shorTitle ?? "")
            cell.lblShortTitle.textColor = UIColor.red
            cell.lblLongDes.textColor = UIColor.red
            cell.lblLongDes.text = "Overdue!"
            cell.SwitchTaskState.setOn(true, animated: false)
        }
        
        cell.callbackforEditTask = {
            cell in
            self.openEditTodoList(index: indexPath)
            
        }
        return cell
    }
    //MARK: - open Edit Todo List
    func openEditTodoList(index:IndexPath)  {
       if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditToDoVC") as? EditToDoVC
        {
        vc.Index = index
        vc.toDoDict = TodoArr[index.row]
        vc.callbackforUpdateTodo = {
           (dict,indexval, isdelete) in
            if isdelete
            {
                self.TodoArr.remove(at: indexval.row)
                self.tblViwShopList.reloadData()
            }
            else
            {
            guard let updatedTask = dict else { return  }
            self.TodoArr[indexval.row] = updatedTask
            self.tblViwShopList.reloadData()
            }
        }
           
           
        self.navigationController?.pushViewController(vc, animated: true)
       }
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
