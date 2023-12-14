import Foundation

public class CustomDictionary<T> {

    private var mainDict = [String: Array<T>]()
    private var secondaryDict = [String: Array<T>]()

    public init(){}
}

protocol BasicFunctions{
    associatedtype T
    
    subscript(key: String) -> Array<T>? { get }

    subscript(key: UInt) -> Array<T>? { get }
    
    var count: Int { get }
}

extension CustomDictionary: BasicFunctions{
    public subscript(key: String) -> Array<T>? {
        return mainDict["string: \(key)"]
    }

    public subscript(key: UInt) -> Array<T>? {
        return mainDict["int: \(key)"]
    }
    
    public var count: Int{
        mainDict.count
    }
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
        if mainDict["int: \(instantiatedT.id)"] != nil{
            return false
        }
        
        mainDict["int: \(instantiatedT.id)"] = [instantiatedT]
        
        mainDict["string: \(instantiatedT.name)"] = 
            mainDict["string: \(instantiatedT.name)"] == nil ?
                [instantiatedT] :
                mainDict["string: \(instantiatedT.name)"]! + [instantiatedT]
        
        
        secondaryDict["int: \(instantiatedT.artist.id)"] =
            secondaryDict["int: \(instantiatedT.artist.id)"] == nil ?
                [instantiatedT] :
                secondaryDict["int: \(instantiatedT.artist.id)"]! + [instantiatedT]
        
        secondaryDict["string: \(instantiatedT.artist.name)"] =
            secondaryDict["string: \(instantiatedT.artist.name)"] == nil ?
                [instantiatedT] :
                secondaryDict["string: \(instantiatedT.artist.name)"]! + [instantiatedT]
        
        return true
    }

    public func removeAll(forKey key: String){
        guard let instancesOfT = mainDict["string: \(key)"] else{
            return
        }
        
        mainDict.removeValue(forKey: "string: \(key)")
        
        for instanceOfT in instancesOfT{
            mainDict.removeValue(forKey: "int: \(instanceOfT.id)")
            removeMusicFromArtist(instantiatedT: instanceOfT)
        }
    }

    public func removeAll(forKey key: UInt){ 
        guard let instancesOfT = mainDict["int: \(key)"] else{
            return
        }
        
        mainDict.removeValue(forKey: "int: \(key)")
        
        for instanceOfT in instancesOfT{
            removeMusicFromArtist(instantiatedT: instanceOfT)
            
            guard let instancesOfTByName = mainDict["string: \(instanceOfT.name)"] else{
                continue
            }
            
            if instancesOfTByName.count > 1{
                mainDict["string: \(instanceOfT.name)"] = instancesOfTByName.filter { $0 != instanceOfT }
                continue
            }
            
            mainDict.removeValue(forKey: "string: \(instanceOfT.name)")
        }
    }
    
    public func removeMusicFromArtist(instantiatedT: T){
        let instancesOfTByArtistId: Array<T>? = secondaryDict["int: \(instantiatedT.artist.id)"]
        let instancesOfTByArtistName: Array<T>? = secondaryDict["string: \(instantiatedT.artist.name)"]
        
        if instancesOfTByArtistId != nil && instancesOfTByArtistId!.count > 1{
            secondaryDict["int: \(instantiatedT.artist.id)"] = instancesOfTByArtistId!.filter { $0 != instantiatedT }
        } else {
            secondaryDict.removeValue(forKey: "int: \(instantiatedT.artist.id)")
        }
        
        if instancesOfTByArtistName != nil && instancesOfTByArtistName!.count > 1{
            secondaryDict["string: \(instantiatedT.artist.name)"] = instancesOfTByArtistName!.filter { $0 != instantiatedT }
        } else {
            secondaryDict.removeValue(forKey: "string: \(instantiatedT.artist.name)")
        }
    }
    
    public func getMusic(forKey key: String) -> Array<T>?{
        mainDict["string: \(key)"]
    }
    
    public func getMusic(forKey key: UInt) -> T?{
        mainDict["int: \(key)"]?.first
    }
    
    public func getMusicsFromArtist(forKey key: String) -> Array<T>?{
        secondaryDict["string: \(key)"]
    }
    
    public func getMusicsFromArtist(forKey key: UInt) -> Array<T>?{
        secondaryDict["int: \(key)"]
    }
    
    public func getAllMusics() -> Array<T>?{
        let idKeys: Array<String>? = mainDict.keys.filter { $0.starts(with: "int: ") }
        
        guard let idKeys = idKeys else{
            return nil
        }
        
        var response: Array<T> = Array()
        
        for idKey in idKeys{
            guard let music = mainDict[idKey] else{
                continue
            }
            
            response += music
        }
        
        return response
    }
}
