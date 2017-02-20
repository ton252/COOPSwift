//
//  OperationChainerProtocol.swift
//  GroupOperation
//
//  Created by Антон Поляков on 07/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

import Foundation

protocol OperationChainerProtocol {
    func chain<T: AsyncOperation>(_ operation1: T, withOperation operation2: T)  where T: ChainableOperationProtocol
    //func chain(_ operation: ChainableOperationProtocol, withOperation: ChainableOperationProtocol)
}

enum OperationChainerError: Error {
    case couldntCreateDependency
}

