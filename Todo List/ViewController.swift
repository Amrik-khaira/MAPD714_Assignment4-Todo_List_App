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
        LoadItems()
    }

    //MARK: - Load default data in dictionary Or reset dictionary on cancel tapped
    func LoadItems()  {
 
        TodoArr =  [ToDoList.init(shorTitle: "FFFsdvfvfv", longDesc: "fvfvfv  f fv dd vsv fvffd", isComplete: true, isDueDate: false, Date: ""),ToDoList.init(shorTitle: "vbggnhnhhnh", longDesc: "fvfvfv  f fv dd vsv fvffd", isComplete: false, isDueDate: true, Date: "2018-02-01T19:10:04+00:00"),ToDoList.init(shorTitle: "vbggnhnhhnh", longDesc: "fvfvfv  f fv dd vsv fvffd", isComplete: false, isDueDate: false, Date: "2018-02-01T19:10:04+00:00")]
        
    }
    
    //MARK: - tableView datasource and delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as? TodoCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        let objTodo = TodoArr[indexPath.row]
        if objTodo.isComplete ?? true
        {
            let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: objTodo.shorTitle ?? "gg t tyret rb r y")
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
            cell.lblShortTitle.attributedText = attributeString
            cell.lblLongDes.text = "Compelted"
            cell.SwitchTaskState.setOn(false, animated: false)
        }
        else  if objTodo.isDueDate ?? false
        {
            cell.lblShortTitle.text = objTodo.shorTitle ?? ""
            cell.lblLongDes.text = objTodo.Date  ?? ""
        }
        else
        {
            cell.lblShortTitle.text = objTodo.shorTitle ?? ""
            cell.lblShortTitle.textColor = UIColor.red
            cell.lblLongDes.textColor = UIColor.red
            cell.lblLongDes.text = "Overdue!"
        }
        
        cell.callbackforEditTask = {
            cell in
            self.openEditTodoList(index: indexPath)
            
        }
        return cell
    }

    func openEditTodoList(index:IndexPath)  {
       if let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "EditToDoVC") as? EditToDoVC
        {
        vc.Index = index
        vc.toDoDict = TodoArr[index.row]
        vc.callbackforUpdateTodo = {
           (dict,indexval) in
            guard let updatedTask = dict else { return  }
            self.TodoArr[indexval.row] = updatedTask
            self.tblViwShopList.reloadData()
           
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
