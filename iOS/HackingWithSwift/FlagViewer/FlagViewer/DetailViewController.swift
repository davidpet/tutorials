//
//  DetailViewController.swift
//  FlagViewer
//
//  Created by David Petrofsky on 10/7/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var flagImage: UIImageView!
    var flagName: String!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        title = flagName
        flagImage.image = UIImage(named: flagName)
        flagImage.layer.borderWidth = 1
        flagImage.layer.borderColor = UIColor.darkGray.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.hidesBarsOnTap = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
