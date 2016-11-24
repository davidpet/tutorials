//
//  ViewController.swift
//  GitHubCommits
//
//  Created by David Petrofsky on 11/23/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    var container: NSPersistentContainer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let container = NSPersistentContainer(name: "Project38")
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        
        performSelector(inBackground: #selector(fetchCommits), with: nil)
    }
    
    func fetchCommits() {
        if let data = try? Data(contentsOf: URL(string: "https://api.github.com/repos/apple/swift/commits?per_page=100")!){
            let jsonCommits = JSON(data: data)
            let jsonCommitArray = jsonCommits.arrayValue
            print("Received \(jsonCommitArray.count) new commits.")
            DispatchQueue.main.async { [unowned self] in
                for jsonCommit in jsonCommitArray {
                    // the following three lines are new
                    let commit = Commit(context: self.container.viewContext)
                    self.configure(commit: commit, usingJSON: jsonCommit)
                }
                self.saveContext()
            }
        }
    }

    func configure(commit: Commit, usingJSON json: JSON) {
        commit.sha = json["sha"].stringValue
        commit.message = json["commit"]["message"].stringValue
        commit.url = json["html_url"].stringValue
        
        let formatter = ISO8601DateFormatter()
        commit.date = formatter.date(from: json["commit"]["committer"]["date"].stringValue) ?? Date()
    }
    
    func saveContext() {
        if container.viewContext.hasChanges {
            do {
                try container.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
}
