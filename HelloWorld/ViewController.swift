//
//  ViewController.swift
//  HelloWorld
//
//  Created by Paul Young on 12/30/14.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

import UIKit
import Engine

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let network = Network()
        
        let actOnControlEvents = ActOnControlEvents(network)
        let presentViewController = PresentViewController(network)
        
        network.addEdge(actOnControlEvents.actionPort, presentViewController.presentPort)
        
        
        // Mark: - Button
        
        let button = UIButton.buttonWithType(.Custom) as UIButton
        button.frame = CGRectMake(50, 50, 100, 50)
        button.backgroundColor = UIColor.grayColor()
        button.setTitle("Tap Me", forState: .Normal)
        self.view.addSubview(button)

        
        // Mark: - Alert Controller
        
        let alertController = UIAlertController(title: "Hello", message: "World", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        
        
        // Mark: - IIPs
        
        actOnControlEvents.controlPort.receive(button)
        actOnControlEvents.eventsPort.receive(.TouchUpInside)
        
        presentViewController.presentingViewControllerPort.receive(self)
        presentViewController.viewControllerToPresentPort.receive(alertController)
        presentViewController.animatedPort.receive(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
