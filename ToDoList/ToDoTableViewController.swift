//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Amirmohamad on 12/7/19.
//  Copyright © 2019 Antarctica. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    var items = [ToDo]()

    
    //Normal functions
    override func viewDidLoad() {
        super.viewDidLoad()

        if let saveToDos = ToDo.loadTodos() {
            items = saveToDos
        } else {
            items = ToDo.loadSamples()!
        }
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    //Prepare function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("PREPARE PRESSED.")
        if segue.identifier == "EditTodo",
            let navController = segue.destination as? UINavigationController,
            let todoDetailController = navController.topViewController as? ToDoDetailTableViewController {
            print("PREPARE PASSED")
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedToDo = items[indexPath.row]
            todoDetailController.toDo = selectedToDo
        }
    }
    
    //Unwind Functions
    @IBAction func unwindToToDo(segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveToDo" else {return}
        let sourceViewController = segue.source as! ToDoDetailTableViewController
        
        
        if let todo = sourceViewController.toDo {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                items[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .bottom)
            } else {
                let newIndexPath = IndexPath(row: items.count, section: 0)
                items.append(todo)
                tableView.insertRows(at: [newIndexPath], with: .bottom)
            }
        }
        
    }

    // MARK: - Table view data source
    //Table View Functions

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)

        // Configure the cell...
        let theTodo = items[indexPath.row]
        cell.textLabel?.text = theTodo.title
        cell.detailTextLabel?.text = theTodo.note
        
        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
