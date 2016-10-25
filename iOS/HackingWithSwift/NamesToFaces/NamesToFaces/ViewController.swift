//
//  ViewController.swift
//  NamesToFaces
//
//  Created by David Petrofsky on 10/24/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func collectionView(_ collectionView:
        UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView:
        UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
            let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier:
                    "Person", for: indexPath) as! PersonCell
            return cell
    }
}

