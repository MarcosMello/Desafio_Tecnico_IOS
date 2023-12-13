import Foundation

public class CustomDictionary<T> {

    private var dict = [String: Array<T>]()

    public init(){}
    
    subscript(key: String) -> Array<T>? {
        return dict["string: \(key)"]
    }

    subscript(key: UInt) -> Array<T>? {
        return dict["int: \(key)"]
    }
}

protocol CountFunctions{
    var count: Int { get }
}

protocol MainFunctions{
    associatedtype T
    
    @discardableResult
    func add(_ instantiatedT: T) -> Bool

    func removeAll(forKey key: String)

    func removeAll(forKey key: UInt)
}

extension CustomDictionary: MainFunctions where T == Music{
    @discardableResult
    public func add(_ instantiatedT: T) -> Bool{
        if dict["int: \(instantiatedT.id)"] != nil{
            return false
        }
        
        dict["int: \(instantiatedT.id)"] = [instantiatedT]
        
        guard let musics = dict["string: \(instantiatedT.name)"] else{
            dict["string: \(instantiatedT.name)"] = [instantiatedT]
            
            return true
        }
        
        dict["string: \(instantiatedT.name)"] = musics + [instantiatedT]
        
        return true
    }

    public func removeAll(forKey key: String){
        guard let musics = dict["string: \(key)"] else{
            return
        }
        
        dict.removeValue(forKey: "string: \(key)")
        
        for music in musics{
            dict.removeValue(forKey: "int: \(music.id)")
        }
    }

    public func removeAll(forKey key: UInt){ 
        guard let musics = dict["int: \(key)"] else{
            return
        }
        
        dict.removeValue(forKey: "int: \(key)")
        
        for music in musics{
            let musicsByName: Array<Music>? = dict["string: \(music.name)"]
            
            guard let musicsByName = musicsByName else{
                continue
            }
            
            if musicsByName.count > 1{
                dict["string: \(music.name)"] = musicsByName.filter { $0 != music }
                continue
            }
            
            dict.removeValue(forKey: "string: \(music.name)")
        }
    }
}
