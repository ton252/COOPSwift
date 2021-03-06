//
//  ChainableOperationInput.swift
//  GroupOperation
//
//  Created by Антон Поляков on 08/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//


typealias ChainableOperationInputTypeValidationBlock = (Any?)->(Bool)

protocol ChainableOperationInput {
    func obtainInputData(withTypeValidationBlock: ChainableOperationInputTypeValidationBlock?) -> Any?
}

