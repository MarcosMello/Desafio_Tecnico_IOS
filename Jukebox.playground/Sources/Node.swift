import Foundation

public class Node<T: Equatable> : CustomStringConvertible{
    public let value: T
    public var previous: Node?
    public var next: Node?
    
    public var description: String{
        guard let next = next else{
            return "\(value) -> nil"
        }
        
        return "\(value) -> \(String(describing: next))"
    }
    
    public init (value: T, previous: Node? = nil, next: Node? = nil){
        self.value = value
        self.previous = previous
        self.next = next
    }
}
