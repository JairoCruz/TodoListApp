//
//  ViewController.swift
//  TodoListApp
//
//  Created by MacBook Pro on 7/2/19.
//  Copyright © 2019 MacBook Pro. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    var itemArray = [Item]()
    
    // Use User Default
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Jairo Cruz"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Jairo Cru"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Jairo Cr"
        itemArray.append(newItem2)
        
        //Use UserDefault
        if let items = defaults.array(forKey: "ListArray") as? [Item] {
           itemArray = items
        }
        
    }
    
    //MARK - Table view Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        /*if item.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }*/
        
        // Ternary Operator
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //Create Alert Dialog
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            // Save in UserDefaults
            self.defaults.set(self.itemArray, forKey: "ListArray")
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

