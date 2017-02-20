//
//  Chain2.swift
//  GroupOperation
//
//  Created by Антон Поляков on 08/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

import UIKit

class Chain2: ChainableOperation<Int> {
    override func process(inputData: Int?, completionBlock: ChainableOperationOutputDataBlock) {
        complete(withData: 2, error: nil)
    }
}
