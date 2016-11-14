//
//  ViewController.swift
//  SecretSwift
//
//  Created by David Petrofsky on 11/13/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import LocalAuthentication
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var secret: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard),
                                       name: Notification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard),
                                       name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage),
                                       name: Notification.Name.UIApplicationWillResignActive, object: nil)
        
        title = "Nothing to see here"
    }
    
    func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        if notification.name == NSNotification.Name.UIKeyboardWillHide {
            secret.contentInset = UIEdgeInsets.zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        secret.scrollIndicatorInsets = secret.contentInset
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    //unhide text box and set its contents to the encrypted text in the keychain
    func unlockSecretMessage() {
        secret.isHidden = false
        title = "Secret stuff!"
        if let text = KeychainWrapper.standardKeychainAccess().string(forKey: "SecretMessage") {
            secret.text = text
        }
    }
    
    //hide text box and write its contents to the encrypted text in the keychain
    func saveSecretMessage() {
        if !secret.isHidden {
            _ = KeychainWrapper.standardKeychainAccess().setString(secret.text, forKey: "SecretMessage")
            secret.resignFirstResponder()
            secret.isHidden = true
            title = "Nothing to see here"
        }
    }
    
    @IBAction func authenticateUser(_ sender: UIButton) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself!"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [unowned self] (success, authenticationError) in
                DispatchQueue.main.async {
                    if success {
                        self.unlockSecretMessage()
                    } else {
                        let ac = UIAlertController(title: "Authentication failed",
                                                   message: "Your fingerprint could not be verified; please try again.", preferredStyle: .alert)
                            ac.addAction(UIAlertAction(title: "OK", style: .default))
                            self.present(ac, animated: true)
                    }
                }
            }
        } else {
            let ac = UIAlertController(title: "Touch ID not available",
                                       message: "Your device is not configured for Touch ID.",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    }
}

