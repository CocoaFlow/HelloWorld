//
//  ActOnControlEvents.swift
//  HelloWorld
//
//  Created by Paul Young on 12/30/14.
//  Copyright (c) 2014 CocoaFlow. All rights reserved.
//

import UIKit
import Engine

final public class ActOnControlEvents: Component {
    
    public let network: Network
    
    init(_ network: Network) {
        self.network = network
    }
    
    
    // Mark: - Actions
    
    private var control: UIControl?
    private var events: UIControlEvents?
    
    private func addAction(control: UIControl, _ events: UIControlEvents) {
        control.addTarget(self, action: "sendAction:", forControlEvents: events)
    }
    
    @objc internal func sendAction(sender: UIControl!) {
        network.send(actionPort, ())
    }
    
    
    // MARK: - Ports
    
    lazy var controlPort: InPort<UIControl> = InPort(self) { packet in
        if let events = self.events {
            self.addAction(packet, events)
        }
        else {
            self.control = packet
        }
    }
    
    lazy var eventsPort: InPort<UIControlEvents> = InPort(self) { packet in
        if let control = self.control {
            self.addAction(control, packet)
        }
        else {
            self.events = packet
        }
    }
    
    lazy var actionPort: OutPort<Void> = OutPort(self)
}
