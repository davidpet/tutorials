//
//  ViewController.swift
//  ShoppingList
//
//  Created by David Petrofsky on 10/13/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:
                                                            #selector(addItem))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = shoppingList[indexPath.row]
        
        return cell
    }
    
    func addItem() {
        let ac = UIAlertController(title: "Add Item", message: "Please type an item to add.",
                                   preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "OK", style: .default ) { (UIAlertAction) -> Void in
            self.addItemText(ac.textFields?[0].text)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func addItemText(_ text: String?) {
        if let realText = text?.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) {
            if realText.isEmpty {
                return
            }
            shoppingList.append(realText)
            tableView.insertRows(at: [IndexPath(row: shoppingList.count - 1, section: 0)], with: .automatic)
        }
    }
}

