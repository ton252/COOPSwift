//
//  ChainableOperationDelegate.swift
//  GroupOperation
//
//  Created by Антон Поляков on 08/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

protocol ChainableOperationDelegate {
    func didComplete<T: AsyncOperation>(chainableOperation:T, withError: Error?) where T: ChainableOperationProtocol
}
