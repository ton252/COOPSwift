//
//  OperationDataFlowChainer.swift
//  GroupOperation
//
//  Created by Антон Поляков on 07/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

import Foundation

class DataFlowOperationChainer: OperationChainerProtocol {
    
    private let bufferFactory: OperationBufferFactoryProtocol
    
    class var `default`: DataFlowOperationChainer {
        get {
            let bufferFactory = OperationBufferFactory()
            return DataFlowOperationChainer(bufferFactory: bufferFactory)
        }
    }
    
    init(bufferFactory: OperationBufferFactoryProtocol) {
        self.bufferFactory = bufferFactory
    }
    
    func chain<T: AsyncOperation>(_ operation1: T, withOperation operation2: T) where T: ChainableOperationProtocol {
        assert(operation1 != operation2, "Operation(\(operation1)) is equal (\(operation2)). Operations must be different!")
        operation2.addDependency(operation1)
        let buffer = bufferFactory.createChainableOperationsBuffer()
        operation1.output = buffer
        operation2.input = buffer
    }
    
//    func chain(_ operation1: ChainableOperationProtocol, withOperation operation2: ChainableOperationProtocol) {
//        assert(operation1 != operation2, "Operation(\(operation1)) is equal (\(operation2)). Operations must be different!")
//        operation2.addDependency(operation1)
//        let buffer = bufferFactory.createChainableOperationsBuffer()
//        operation1.output = buffer
//        operation2.input = buffer
//    }
}



