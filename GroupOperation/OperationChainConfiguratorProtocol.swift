//
//  OperationChainConfiguratorProtocol.swift
//  GroupOperation
//
//  Created by Антон Поляков on 08/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

protocol OperationChainConfiguratorProtocol {
    func configure<T: AsyncOperation>(operationsChain operations:[T], withInputData inputData: Any?) -> OperationBufferProtocol where T: ChainableOperationProtocol
//    func configure(operationsChain:[ChainableOperationProtocol], withInputData: Any?) -> OperationBufferProtocol
}
