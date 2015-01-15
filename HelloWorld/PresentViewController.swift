//
//  PresentViewController.swift
//  HelloWorld
//
//  Created by Paul Young on 12/31/14.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

import UIKit
import Engine

final public class PresentViewController: Engine.Component {
    
    public let network: Network
    
    public init(_ network: Network) {
        self.network = network
    }
    

    // Mark: - Presenting
    
    private var presentingViewController: UIViewController?
    private var viewControllerToPresent: UIViewController?
    private var animated: Bool?
    private var present: Void?
    
    private func attemptToPresent() {
        if let present: Void = self.present {
            if let presentingViewController = self.presentingViewController {
                if let viewControllerToPresent = self.viewControllerToPresent {
                    if let animated = self.animated {
                        self.present(presentingViewController, viewControllerToPresent, animated)
                    }
                }
            }
        }
    }
    
    private func present(presentingViewController: UIViewController, _ viewControllerToPresent: UIViewController, _ animated: Bool) {
        presentingViewController.presentViewController(viewControllerToPresent, animated: animated) {
            self.network.send(self.completionPort, ())
        }
    }
    
    
    // Mark: - Ports

    lazy var presentingViewControllerPort: InPort<UIViewController> = InPort(self) { packet in
        self.presentingViewController = packet
        self.attemptToPresent()
    }
    
    lazy var viewControllerToPresentPort: InPort<UIViewController> = InPort(self) { packet in
        self.viewControllerToPresent = packet
        self.attemptToPresent()
    }
    
    lazy var animatedPort: InPort<Bool> = InPort(self) { packet in
        self.animated = packet
        self.attemptToPresent()
    }
    
    lazy var presentPort: InPort<Void> = InPort(self) { packet in
        self.present = packet
        self.attemptToPresent()
    }
    
    lazy var completionPort: OutPort<Void> = OutPort(self)
}
