//
//  OperationBufferFactory.swift
//  GroupOperation
//
//  Created by Антон Поляков on 07/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

class OperationBufferFactory: OperationBufferFactoryProtocol {
    func createChainableOperationsBuffer()->OperationBufferProtocol {
        return OperationBuffer()
    }
}
