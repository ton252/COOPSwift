//
//  ViewController.swift
//  GroupOperation
//
//  Created by Антон Поляков on 07/02/2017.
//  Copyright © 2017 Антон Поляков. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    let queue = OperationQueue()

    override func viewDidLoad() {
        
        let compoundOperation = CompoundOperation.default
        let op1 = Chain2()
        let op2 = Chain2()
        let array = [op1,op2]
        compoundOperation.configure(withChainableOperations: array, inputData: 2) { (data, error) -> (Void) in
            print(data,error)
        }
        queue.addOperation(compoundOperation)
        
        super.viewDidLoad()        
    }
}

