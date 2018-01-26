//
//  ParseOperationQueues.swift
//  ATParse
//
//  Created by Nicolas Landa on 21/12/16.
//  Copyright © 2016 Nicolas Landa. All rights reserved.
//

import Foundation

/// Colas disponibles para las operaciones:
public struct OperationQueues {
	
    /// Cola para las operaciones relacionadas con el servidor Parse
    public static var parse: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.machukas.ATParse.ParseOperationsQueue"
        NSLog("Created \(queue.description) operation queue")
        return queue
    }()
}
