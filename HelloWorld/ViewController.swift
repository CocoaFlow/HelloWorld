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
        
        let actor = ActOnControlEvents(network)
        let presenter = PresentViewController(network)
        
        network.addConnection(actor.actionPort, presenter.presentPort)
        
        
        // Mark: - Button
        
        let button = UIButton(type: .Custom)
        button.backgroundColor = UIColor.grayColor()
        button.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20)
        button.setTitle("Tap Me", forState: .Normal)
        button.sizeToFit()
        button.center = self.view.center
        self.view.addSubview(button)

        
        // Mark: - Alert Controller
        
        let alertController = UIAlertController(title: "Hello", message: "World", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(okAction)
        
        
        // Mark: - IIPs
        
        actor.controlPort.receive(button)
        actor.eventsPort.receive(.TouchUpInside)
        
        presenter.presentingViewControllerPort.receive(self)
        presenter.viewControllerToPresentPort.receive(alertController)
        presenter.animatedPort.receive(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
