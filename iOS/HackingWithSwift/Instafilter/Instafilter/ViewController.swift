//
//  ViewController.swift
//  Instafilter
//
//  Created by David Petrofsky on 10/26/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var intensity: UISlider!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var filterButton: UIButton!

    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "CISepiaTone"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self,
                                                            action: #selector(importPicture))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerEditedImage] as? UIImage else { return }
        dismiss(animated: true)
        currentImage = image
        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        saveButton.isEnabled = true
        filterButton.isEnabled = true
        intensity.isEnabled = true
    }
    
    func applyProcessing() {
        //set filter values that are supported by the filter (based on the 1 slider)
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey)
        { currentFilter.setValue(intensity.value, forKey:
            kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey)
        { currentFilter.setValue(intensity.value * 200, forKey:
            kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey)
        { currentFilter.setValue(intensity.value * 10, forKey:
            kCIInputScaleKey) }
        if inputKeys.contains(kCIInputCenterKey)
        { currentFilter.setValue(CIVector(x: currentImage.size.width /
            2, y: currentImage.size.height / 2), forKey:
            kCIInputCenterKey) }
        
        //do the rendering
        if let cgimg =
            context.createCGImage(currentFilter.outputImage!, from:
                currentFilter.outputImage!.extent) {
            let processedImage = UIImage(cgImage: cgimg)
            self.imageView.image = processedImage
        }
    }
    
    func setFilter(action: UIAlertAction!) {
        // make sure we have a valid image before continuing!
        guard currentImage != nil else { return }
        currentFilter = CIFilter(name: action.title!)
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        title = action.title!
        applyProcessing()
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message:
                error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message:
                "Your altered image has been saved to your photos.",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @IBAction func changeFilter(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose filter", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "CIBumpDistortion",
                                   style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur",
                                   style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate",
                                   style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone",
                                   style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion",
                                   style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask",
                                   style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette",
                                   style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    @IBAction func save(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @IBAction func intensityChanged(_ sender: UISlider) {
        applyProcessing()
    }
}

