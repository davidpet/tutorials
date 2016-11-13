//
//  ViewController.swift
//  SelfieShare
//
//  Created by David Petrofsky on 11/12/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var images = [UIImage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Selfie Share"
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showConnectionPrompt))
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(importPicture))
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->
        UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageView", for: indexPath)
            if let imageView = cell.viewWithTag(1000) as? UIImageView {
                imageView.image = images[indexPath.item]
            }
            return cell
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        dismiss(animated: true)
        images.insert(image, at: 0)
        collectionView?.reloadData()
    }
    
    func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func startHosting(alertAction: UIAlertAction) {
        print("Host")
    }
    
    func joinSession(alertAction: UIAlertAction) {
        print("Join")
    }
}
