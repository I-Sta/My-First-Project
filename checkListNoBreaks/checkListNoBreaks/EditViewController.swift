//
//  EditViewController.swift
//  checkListNoBreaks
//
//  Created by Field Employee on 4/10/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//


import UIKit

class EditViewController: UITableViewController {
    
    //Made publlic from internal
    
    internal var todoItems = [ToDoItem]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Edit List"

               NotificationCenter.default.addObserver(
                   self,
                   selector: #selector(UIApplicationDelegate.applicationDidEnterBackground(_:)),
                   name: UIApplication.didEnterBackgroundNotification,
                   object: nil)

               do
               {
                   // Try to load from persistence
                   self.todoItems = try [ToDoItem].readFromPersistence()
               }
               catch let error as NSError
               {
                   if error.domain == NSCocoaErrorDomain && error.code == NSFileReadNoSuchFileError
                   {
                       NSLog("No persistence file found, not necesserially an error...")
                   }
                   else
                   {
                       let alert = UIAlertController(
                           title: "Error",
                           message: "Could not load the to-do items!",
                           preferredStyle: .alert)

                       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                       self.present(alert, animated: true, completion: nil)

                       NSLog("Error loading from persistence: \(error)")
                   }
               }
    }
   

       override func numberOfSections(in tableView: UITableView) -> Int
       {
           return 1
       }

      

       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_toedit", for: indexPath)

               if indexPath.row < todoItems.count
               {
                   let item = todoItems[indexPath.row]
                   cell.textLabel?.text = item.title

                let accessory: UITableViewCell.AccessoryType = item.done ? .checkmark : .none
                   cell.accessoryType = accessory
               }
        
        return cell
        
       }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
          {
           
              return todoItems.count
          }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
       {
           tableView.deselectRow(at: indexPath, animated: true)

           if indexPath.row < todoItems.count
           {
               let item = todoItems[indexPath.row]
               item.done = !item.done

               tableView.reloadRows(at: [indexPath], with: .automatic)
           }
       }


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
          {
              if indexPath.row < todoItems.count
              {
                  todoItems.remove(at: indexPath.row)
                  tableView.deleteRows(at: [indexPath], with: .top)
              }
          }

    @objc
       public func applicationDidEnterBackground(_ notification: NSNotification)
       {
           do
           {
               try todoItems.writeToPersistence()
           }
           catch let error
           {
               NSLog("Error writing to persistence: \(error)")
           }
       }

}
