//
//  ViewController.swift
//  FlagViewer
//
//  Created by David Petrofsky on 10/7/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var flags: [String] = ["estonia", "france", "germany", "ireland", "italy", "monaco",
                           "nigeria", "poland", "russia", "spain", "uk", "us"]
                            //had to hard-code because I decided to add flags to xcassets (mistake)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag")
        cell?.imageView?.image = UIImage(named: flags[indexPath.row])
        cell?.textLabel?.text = flags[indexPath.row]
        return cell!
    }
}

