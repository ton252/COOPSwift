//
//  OperationChainConfigurator.swift
//  GroupOperation
//
//  Created by Антон Поляков on 08/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

class OperationChainConfigurator: OperationChainConfiguratorProtocol {
    
    private let bufferFactory: OperationBufferFactoryProtocol
    private let chainer: OperationChainerProtocol
    
    class var `default`: OperationChainConfiguratorProtocol {
        get {
            let defaultBufferFactory = OperationBufferFactory()
            let defaultChainerFactory = OperationChainerFactory()
            let defaultChainer = defaultChainerFactory.createDataFlowOperationChainer()
            
            return OperationChainConfigurator(operationChainer: defaultChainer, operationBufferFactory: defaultBufferFactory)
        }
    }
    
    init(operationChainer: OperationChainerProtocol, operationBufferFactory: OperationBufferFactoryProtocol) {
        self.chainer = operationChainer
        self.bufferFactory = operationBufferFactory
    }
    
    //MARK: <OperationChainConfiguratorProtocol>
    
    func configure<T: AsyncOperation>(operationsChain operations:[T], withInputData inputData: Any?) -> OperationBufferProtocol where T: ChainableOperationProtocol {
        assert(operations.count != 0, "Operation chain couldn't be empty!")
        configureInput(withData: inputData, forFirstOperation: operations.first!)
        configureChain(withOperations: operations)
        let outputBuffer = configureOutput(forLastOperation: operations.last!)
        
        return outputBuffer
    }
    
    //MARK: Private methods
    
    private func configureInput(withData inputData: Any?, forFirstOperation firstOperation: ChainableOperationProtocol) {
        let inputBuffer = bufferFactory.createChainableOperationsBuffer()
        inputBuffer.setOperationQueue(inputData: inputData)
        firstOperation.input = inputBuffer
    }
    
    private func configureChain<T: AsyncOperation>(withOperations operations: [T]) where T: ChainableOperationProtocol {
        for i in (0..<operations.count-1) {
            let currentOperation = operations[i]
            let nextOperation = operations[i+1]
            chainer.chain(currentOperation, withOperation: nextOperation)
        }
    }
    
    private func configureOutput(forLastOperation operation: ChainableOperationProtocol) -> OperationBufferProtocol {
        let outputBuffer = bufferFactory.createChainableOperationsBuffer()
        operation.output = outputBuffer
        return outputBuffer
    }
    
    

}
