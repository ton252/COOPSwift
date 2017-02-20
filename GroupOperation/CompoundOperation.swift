//
//  CompoundOperation.swift
//  GroupOperation
//
//  Created by Антон Поляков on 08/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

import Foundation

typealias CompoundOperationResultBlock = (Any?, Error?) -> (Void)

class CompoundOperation: AsyncOperation, ChainableOperationDelegate {
    
    // Dependencies
    private let queue: OperationQueue
    private let configurator: OperationChainConfiguratorProtocol
    
    //Configuration
    private var inputData: Any? = nil
    private var chainableOperationsPrototype = [ChainableOperationProtocol]()
    private var resultBlock: CompoundOperationResultBlock? = nil
    
    private var isConfigured = false
    private var outputBuffer: OperationBufferProtocol? = nil
    private var errors: [Error] = []
    
    class var `default`: CompoundOperation {
        get {
            let queue = OperationQueue.coo_suspendedOperationQueueWithMaximumConcurentOperations()
            let configurator = OperationChainConfigurator.default
            return CompoundOperation(operationQueue: queue, configurator: configurator)
        }
    }
    
    init(operationQueue: OperationQueue, configurator: OperationChainConfiguratorProtocol) {
        self.queue = operationQueue
        self.configurator = configurator
        super.init()
    }
    
    func setChainableOperations<T:AsyncOperation>(_ operations: [T]) where T: ChainableOperationProtocol {
        chainableOperationsPrototype = operations
    }
    
    //MARK: - Configurator
    
//    func configure<T: AsyncOperation>(withChainableOperations operations:[T], resultBlock: @escaping CompoundOperationResultBlock) where T: ChainableOperationProtocol {
//        configure(withChainableOperations: operations, inputData: nil, resultBlock: resultBlock)
//    }
    
    func configure<T: AsyncOperation>(withChainableOperations operations:[T], inputData: Any?, resultBlock: @escaping CompoundOperationResultBlock) where T: ChainableOperationProtocol {
        assert(operations.count != 0, "Array of suboperations must not empty")
        self.chainableOperationsPrototype = operations
        self.resultBlock = resultBlock
        self.inputData = inputData
        
        outputBuffer = configurator.configure(operationsChain: operations, withInputData: inputData)
        addSuboperationsToQueue(operations)
        isConfigured = true
    }

    internal func addSuboperationsToQueue<T: AsyncOperation>(_ operations: [T]) where T: ChainableOperationProtocol {
        for operation in operations {
            queue.addOperation(operation)
            operation.delegate = self
        }
    }
    
    
    //MARK: - Execution
    
    override func main() {
        assert(isConfigured == true, "Compound operation must be configured before execution.")
        queue.isSuspended = false
    }
    
    override func cancel() {
        if isFinished && isCancelled {
            super.cancel()
            
            if isExecuting {
                finishCompoundOperationExecution()
            }
        }
    }
    
    //MARK: - <ChainableOperationDelegate>
    
    func didComplete<T: AsyncOperation>(chainableOperation:T, withError error: Error?) where T: ChainableOperationProtocol {
        let data = outputBuffer?.obtainOperationQueueOutputData()
        if (chainableOperation == chainableOperationsPrototype.last as? AsyncOperation) {
            completeOperation(withData: data, error: error)
        }
    }
    
    //MARK: - Private methods
    
    private func completeOperation(withData data: Any?, error: Error?) {
        finishCompoundOperationExecution()
        resultBlock?(data, error)
    }
    
    private func finishCompoundOperationExecution() {
        queue.isSuspended = true
        queue.cancelAllOperations()
        complete()
    }
    


    
}

