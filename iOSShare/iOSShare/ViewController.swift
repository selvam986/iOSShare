//
//  ViewController.swift
//  iOSShare
//
//  Created by MLS Discovery on 4/18/18.
//  Copyright © 2018 GodShare. All rights reserved.
//

import UIKit
import Swinject

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let semaphore: SemaphoreClass = SemaphoreClass()
        semaphore.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

