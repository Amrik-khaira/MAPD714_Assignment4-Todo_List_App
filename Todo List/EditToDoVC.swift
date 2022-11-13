//
//  EditToDoVC.swift
//  Author's name : Amrik Singh
//  StudentID : 301296257
//
//  Todo List app
//
//  Created by Amrik on 13/11/22.
// Version: 1.1

import UIKit

class EditToDoVC: UIViewController {
  var Index = IndexPath()
  var toDoDict = ToDoList()
  var callbackforUpdateTodo:((ToDoList?,IndexPath) -> Void)?
    @IBOutlet weak var PickerSelectDate: UIDatePicker!
    
    @IBOutlet weak var ViwPicker: UIView!
    @IBOutlet weak var txtFieldTaskName: UITextField!
    @IBOutlet weak var TxtViewLongDesc: UITextView!
    @IBOutlet weak var SwitchDueDate: UISwitch!
    @IBOutlet weak var SwitchIsCompleted: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

   
    
    @IBAction func PickerChangeDateAct(_ sender: UIDatePicker) {
        
    }
    
    
    @IBAction func BtnBackAct(_ sender: Any) {
        callbackforUpdateTodo?(toDoDict,Index)
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - keyboard done button tapped
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       
            textField.resignFirstResponder()
        
       return true
    }

}
