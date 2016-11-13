//
//  ViewController.swift
//  LocalNotifications
//
//  Created by David Petrofsky on 11/12/16.
//  Copyright © 2016 David Petrofsky. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:
            "Register", style: .plain, target: self, action:
            #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title:
            "Schedule", style: .plain, target: self, action:
            #selector(scheduleLocal))
    }

    func registerLocal() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    func scheduleLocal() {
    }
}

