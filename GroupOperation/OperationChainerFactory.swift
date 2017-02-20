//
//  OperationChainerFactory.swift
//  GroupOperation
//
//  Created by Антон Поляков on 08/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

class OperationChainerFactory: OperationChainerFactoryProtocol {
    func createDataFlowOperationChainer() -> OperationChainerProtocol {
        return DataFlowOperationChainer.default
    }
}
