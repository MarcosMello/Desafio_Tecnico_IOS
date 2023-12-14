import Foundation

public struct Artist: Equatable, Hashable, CustomStringConvertible{
    public let id: UInt
    public let name: String
    
    public init(id: UInt, name: String) {
        self.id = id
        self.name = name
    }
    
    public static func == (lhs: Artist, rhs: Artist) -> Bool{
        lhs.id == rhs.id
    }
    
    public var description: String{
        "(\(name) (\(id)))"
    }
}

public struct Music: Equatable, Hashable, CustomStringConvertible{
    public let id: UInt
    public let name: String
    public let artist: Artist
    public let durationInSeconds: UInt
    public let score: Double
    
    public init(id: UInt, name: String, artist: Artist, durationInSeconds: UInt, score: Double) {
        self.id = id
        self.name = name
        self.artist = artist
        self.durationInSeconds = durationInSeconds
        self.score = score
    }
    
    public static func == (lhs: Music, rhs: Music) -> Bool{
        lhs.id == rhs.id
    }
    
    public var description: String {
        "(\(id) - \(name) by \(String(describing: artist)) with duration of \(durationInSeconds) - \(score) stars)"
    }
}

public struct User: Equatable, CustomStringConvertible{
    public let id: UInt
    public let name: String
    var funds: UInt64
    
    public init(id: UInt, name: String, funds: UInt64) {
        self.id = id
        self.name = name
        self.funds = funds
    }
    
    public static func == (lhs: User, rhs: User) -> Bool{
        lhs.id == rhs.id
    }
    
    public func getFunds() -> UInt64{
        funds
    }
    
    @discardableResult
    public mutating func consumeFunds(value: UInt64) -> Bool{
        if (value > self.funds){
            return false
        } else {
            self.funds -= value
            return true
        }
    }
    
    public var description: String{
        let formatting = funds.quotientAndRemainder(dividingBy: 100)
        
        return "(\(id) - \(name) with funds of R$ \(formatting.quotient).\(formatting.remainder < 10 ? "0" + String(formatting.remainder) : String(formatting.remainder)))"
    }
}

public struct EnqueuedMusic: Equatable, CustomStringConvertible{
    public let music: Music
    public let user: User
    
    public init(music: Music, user: User) {
        self.music = music
        self.user = user
    }
    
    public var description: String {
        "(\(music.id) - \(music.name) selecionado por \(user.id) - \(user.name))"
    }
}
