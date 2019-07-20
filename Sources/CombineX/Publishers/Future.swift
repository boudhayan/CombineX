/// A publisher that eventually produces one value and then finishes or fails.
final public class Future<Output, Failure> : Publisher where Failure : Error {
    
    public typealias Promise = (Result<Output, Failure>) -> Void
    
    private let lock = Lock()
    
    private let subject = CurrentValueSubject<Output?, Failure>(nil)
    
    public init(_ attemptToFulfill: @escaping (@escaping Promise) -> Void) {
        attemptToFulfill(self.complete)
    }
    
    /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
    ///
    /// - SeeAlso: `subscribe(_:)`
    /// - Parameters:
    ///     - subscriber: The subscriber to attach to this `Publisher`.
    ///                   once attached it can begin to receive values.
    final public func receive<S>(subscriber: S) where Output == S.Input, Failure == S.Failure, S : Subscriber {
//        self.subject.receive(subscriber: subscriber)
//        
//        self.lock.lock()
//        if let result = self.result {
//            self.lock.unlock()
//            result.publisher.receive(subscriber: subscriber)
//        } else {
//            self.subject.receive(subscriber: subscriber)
//            self.lock.unlock()
//        }
    }
    
    private func complete(_ result: Result<Output, Failure>) {
//        switch result {
//        case .success(let output):
//            self.subject.send(output)
//            self.subject.send(completion: .finished)
//        case .failure(let error):
//            self.subject.send(completion: .failure(error))
//        }
    }
}
