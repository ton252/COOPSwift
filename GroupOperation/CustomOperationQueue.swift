//
//  CustomOperationQueue.swift
//  GroupOperation
//
//  Created by Антон Поляков on 08/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

import UIKit

class CustomOperationQueue: Operation {

}

extension OperationQueue {
    
    class func coo_suspendedOperationQueueWithMaximumConcurentOperations() -> OperationQueue {
        return self.coo_operationQueue(withMaximumConcurentOperationsAndSuspendedState: true)
    }
    
    class func coo_operationQueueWithMaximumConcurentOperations() -> OperationQueue {
        return self.coo_operationQueue(withMaximumConcurentOperationsAndSuspendedState: false)
    }
    // MARK: - Private methods
    
    class func coo_operationQueue(withMaximumConcurentOperationsAndSuspendedState isSuspended: Bool) -> OperationQueue {
        let queue = OperationQueue()
        queue.setUniqueQueueName()
        queue.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
        queue.isSuspended = isSuspended
        return queue
    }
    
    // MARK: - Helpers
    static let coo_uniqueQueueNameFormat: String = "%@.%@-%@.queue <%@>"
    
    func setUniqueQueueName() {
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? "unknown_identifier"
        let className = String(describing: OperationQueue.self)
        let uuid: String = UUID().uuidString
        let objectAddress: String = "\(self)"
        self.name = String(format: OperationQueue.coo_uniqueQueueNameFormat, bundleIdentifier, className, uuid, objectAddress)
    }
}
