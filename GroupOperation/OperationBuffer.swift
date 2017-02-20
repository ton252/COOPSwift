//
//  OperationBuffer.swift
//  GroupOperation
//
//  Created by Антон Поляков on 07/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

class OperationBuffer: OperationBufferProtocol {
    
    private var buffer: Any?
    
    //MARK: <ChainableOperationInput>
    
    func obtainInputData(withTypeValidationBlock block: ChainableOperationInputTypeValidationBlock?) -> (Any?) {
        if let block = block {
            return obtainBufferData(withTypeValidationBlock: block)
        }
        return obtainBufferData()
    }
    
    //MARK: <ChainableOperationOutput>
    
    func didCompleteChainableOperation(withOutputData outputData: Any?) {
        updateBuffer(withData: outputData)
    }
    
    //MARK: <CompoundOperationQueueInput>
    
    func setOperationQueue(inputData: Any?) {
        self.updateBuffer(withData: inputData)
    }
    
    //MARK: <CompoundOperationQueueOutput>
    
    func obtainOperationQueueOutputData() -> Any? {
        return obtainBufferData()
    }
    
    //MARK: Private methods
    
    private func updateBuffer(withData data: Any?) {
        buffer = data
    }
    
    private func obtainBufferData() -> Any? {
        return buffer
    }
    
    private func obtainBufferData(withTypeValidationBlock block: ChainableOperationInputTypeValidationBlock) -> (Any?) {
        let data = obtainBufferData()
        let isBufferContentValid = block(data)
        assert(isBufferContentValid, "Buffer data has incorrect format \(type(of:data))")
        return data;
    }

}
