//
//  ChainableOperationProtocol.swift
//  GroupOperation
//
//  Created by Антон Поляков on 08/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

import Foundation

protocol ChainableOperationProtocol: class {
    var input: ChainableOperationInput? {get set}
    var output: ChainableOperationOutput? {get set}
    var delegate: ChainableOperationDelegate? {get set}
    //ignore previous error
}
