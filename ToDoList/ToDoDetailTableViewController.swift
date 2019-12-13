//
//  ToDoDetailTableViewController.swift
//  ToDoList
//
//  Created by Amirmohamad on 12/8/19.
//  Copyright © 2019 Antarctica. All rights reserved.
//

import UIKit

class ToDoDetailTableViewController: UITableViewController {

    //Variable
    var toDo: ToDo?
    
    var isPickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesTextIndexPath = IndexPath(row: 0, section: 2)
    
    let normalCellHeight = 44.0
    let largeCellHeight = 200
    
    
    //# Outlets
    //Bar Button Items
    @IBOutlet weak var saveButton: UIBarButtonItem!
    //Section 1
    @IBOutlet weak var toDoTitleTextView: UITextField!
    @IBOutlet weak var toDoCheckmarkButton: UIButton!
    
    //Section 2
    @IBOutlet weak var shortDateLabel: UILabel!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    //Section 3
    @IBOutlet weak var notesText: UITextView!
    
    
    //Functions
    
    //Actions
    @IBAction func textEditingChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    @IBAction func toDoButtonPrimary(_ sender: UITextField) {
        toDoTitleTextView.resignFirstResponder()
    }
    @IBAction func toDoCheckmarkTapped(_ sender: UIButton) {
        toDoCheckmarkButton.isSelected = !toDoCheckmarkButton.isSelected
    }
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateShortDate(date: dueDatePicker.date)
    }
    
    func updateShortDate(date: Date) {
        shortDateLabel.text = ToDo.dueDateFormatter.string(from: date)
    }
    
    func updateSaveButtonState() {
        let text = toDoTitleTextView.text ?? ""
        saveButton.isEnabled = !(text.isEmpty)
    }
    
    //View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = toDo {
            print("TODO ITEM CREATED.")
            navigationItem.title = "To-Do"
            toDoTitleTextView.text = todo.title
            toDoCheckmarkButton.isSelected = todo.isComplete
            dueDatePicker.date = todo.dueDate
            notesText.text = todo.note
        } else {
            dueDatePicker.date = Date().addingTimeInterval(86400)
        }
        
        updateSaveButtonState()
        updateShortDate(date: dueDatePicker.date)
    }
    
    //TableView methods
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            print("HEIGHT FOR ROW AT \(indexPath)")
            return isPickerHidden ? 0 : 216
            
        case notesTextIndexPath:
            return CGFloat(largeCellHeight)
        default:
            return CGFloat(normalCellHeight)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row) was tapped.")
        print("\(indexPath.section) was tapped.")
        if indexPath == IndexPath(row: 0, section: 1) {
            print("Tapped.")
            isPickerHidden = !isPickerHidden
            print(isPickerHidden)
            shortDateLabel.textColor = isPickerHidden ? .black :
            tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "SaveToDo" else {return}
        
        let title = toDoTitleTextView.text!
        let isComplete = toDoCheckmarkButton.isSelected
        let dueDate = dueDatePicker.date
        let notes = notesText.text
        toDo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, note: notes)
        
    }
}
