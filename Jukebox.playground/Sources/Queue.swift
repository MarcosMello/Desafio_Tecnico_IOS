import Foundation

public struct Queue<T: Equatable> : CustomStringConvertible{
    public var head: Node<T>?
    public var tail: Node<T>?
    
    public var size: Int = 0;
    
    public init(){}
    
    public var isEmpty: Bool{
        head == nil
    }
    
    public var description: String{
        guard let head = head else{
            return "Fila Vazia"
        }
        
        return String(describing: head)
    }
    
    public mutating func enqueue(value: T){
        let newNode: Node = Node(value: value, next: head)
        
        head?.previous = newNode
        head = newNode
        
        if (tail == nil){
            tail = head
        }
        
        size += 1
    }
    
    @discardableResult
    public mutating func dequeue() -> Node<T>?{
        guard let tail = tail,
              let head = head else{
            return nil
        }
        
        let dequeuedNode: Node<T>? = tail
        
        if (head === tail){
            self.head = nil
            self.tail = nil
        } else {
            tail.previous?.next = nil
            self.tail = tail.previous
        }
        
        size -= 1
        
        return dequeuedNode;
    }
    
    @discardableResult
    public mutating func remove(value: T) -> Node<T>?{
        guard let head = head else {
            return nil
        }
        
        var currentNode: Node<T>? = head;
        
        while currentNode != nil && currentNode!.value != value {
            currentNode = currentNode!.next
        }
        
        guard let currentNode = currentNode else{
            return nil
        }
        
        currentNode.previous?.next = currentNode.next
        currentNode.next?.previous = currentNode.previous
        
        currentNode.previous = nil
        currentNode.next = nil
        
        size -= 1
        
        return currentNode;
    }
}
