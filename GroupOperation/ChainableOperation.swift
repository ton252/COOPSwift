//
//  ChainableOperation.swift
//  GroupOperation
//
//  Created by Антон Поляков on 07/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

import Foundation

typealias ChainableOperationOutputDataBlock = (Any?, Error?) -> Void

class ChainableOperation<InputDataType>: AsyncOperation, ChainableOperationProtocol {
    
    var input: ChainableOperationInput?
    var output: ChainableOperationOutput?
    var delegate: ChainableOperationDelegate?
    
    override func main() {
        // Step 2: Validate input data and obtain it if can.
        let inputData = obtainInputDataWithTypeValidation()
        
        // Step 3: Process input data and return the new one with completion block.
        process(inputData: inputData) { (processedData, error) in
            self.complete(withData: inputData, error: error)
        }
    }
    
    func complete(withData data: Any?, error: Error?) {
        output?.didCompleteChainableOperation(withOutputData: data)
        delegate?.didComplete(chainableOperation: self, withError: error)
        complete()
    }
    
    func process(inputData: InputDataType?, completionBlock: ChainableOperationOutputDataBlock) {
        assert(false, "You should override the method \(#function) in a subclass")
    }
    
    private func obtainInputDataWithTypeValidation() -> InputDataType? {
        guard let input = input else {
            return nil
        }
        let inputData = input.obtainInputData { (inputData) -> (Bool) in
            let inputData = inputData as? InputDataType
            return (inputData != nil) ? true : false
        }
        
        return inputData as? InputDataType
    }
    
}
