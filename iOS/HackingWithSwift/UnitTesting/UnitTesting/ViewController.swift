//
//  ViewController.swift
//  UnitTesting
//
//  Created by David Petrofsky on 11/24/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var playData = PlayData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self,
                                                            action: #selector(filter))
        
        playData.filter("mad")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playData.filteredWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let word = playData.filteredWords[indexPath.row]
        cell.textLabel!.text = word
        cell.detailTextLabel!.text = "\(playData.uniqueWords.count(for: word))"
        return cell
    }
    
    func filter() {
        let ac = UIAlertController(title: "Filter", message: "Please provide filter text",
                                   preferredStyle: .alert)
        ac.addTextField()
        ac.textFields?[0].text = playData.filter
        ac.addAction(UIAlertAction(title: "OK", style: .default) { action in
            self.playData.filter((ac.textFields?[0].text)!)
            self.tableView.reloadData()
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
}

