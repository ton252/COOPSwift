
import Foundation

class AsyncOperation: Operation {
    
    // MARK: - State Management
    
    private var _executing: Bool = false {
        willSet { willChangeValue(forKey: "isExecuting") }
        didSet { didChangeValue(forKey: "isExecuting") }
    }
    open override var isExecuting: Bool { return _executing }
    
    private var _finished: Bool = false {
        willSet { willChangeValue(forKey: "isFinished") }
        didSet { didChangeValue(forKey: "isFinished") }
    }
    open override var isFinished: Bool { return _finished }
    
    // MARK: - Completion
    
    public func completeOperation() {
        _executing = false
        _finished = true
    }
    
    //MARK:- Overrides
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        print("start \(type(of:self))")
        if isCancelled {
            complete()
            return
        } else if isReady {
            _executing = true;
            Thread.detachNewThreadSelector(#selector(main), toTarget: self, with: nil)
        }
    }
    
    override func main() {
        super.main()
    }
    
    internal func complete() {
        _executing = false
        _finished = true
    }
}
