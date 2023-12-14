import Foundation

struct Jukebox{
    var musicQueue: Queue<EnqueuedMusic> = Queue()
    var musicsDictionary: CustomDictionary<Music>
    var popularityDictionary: Dictionary<Music, UInt>
    var musicPrice: UInt64
    
    public init(
        musicsDictionary: CustomDictionary<Music>,
        popularityDictionary: Dictionary<Music, UInt>,
        musicPrice: UInt64
    ){
        self.musicsDictionary = musicsDictionary
        self.popularityDictionary = popularityDictionary
        self.musicPrice = musicPrice
    }
    
    @discardableResult
    public mutating func enqueueMusic(forKey key: UInt, user: inout User) -> Bool{
        guard let music = getMusic(forKey: key),
                user.consumeFunds(value: musicPrice) else{
            return false
        }
        
        let enqueuedMusic: EnqueuedMusic = EnqueuedMusic(music: music, user: user)
        
        musicQueue.enqueue(value: enqueuedMusic)
        
        return true
    }
    
    @discardableResult
    public mutating func enqueueMusic(forKey key: String, user: inout User) -> Bool{
        guard let musics = getMusic(forKey: key),
                user.consumeFunds(value: musicPrice) else{
            return false
        }
        
        let music: Music = selectMusicFromArray(musicArray: musics)
        
        let enqueuedMusic: EnqueuedMusic = EnqueuedMusic(music: music, user: user)
        
        musicQueue.enqueue(value: enqueuedMusic)
        
        return true
    }
    
    public func getMusic(forKey key: UInt) -> Music?{
        musicsDictionary.getMusic(forKey: key)
    }
    
    public func getMusic(forKey key: String) -> Array<Music>?{
        musicsDictionary.getMusic(forKey: key)
    }
    
    func getAllMusics() -> Array<Music>?{
        musicsDictionary.getAllMusics()
    }
    
    func getMusicsByArtists(forKey key: UInt) -> Array<Music>?{
        musicsDictionary.getMusicsFromArtist(forKey: key)
    }
    
    func getMusicsByArtists(forKey key: String) -> Array<Music>?{
        musicsDictionary.getMusicsFromArtist(forKey: key)
    }
    
    @discardableResult
    mutating func nextMusic() -> Node<EnqueuedMusic>?{
        musicQueue.dequeue()
    }
    
    @discardableResult
    mutating func removeMusicFromQueue(music: Music, user: User) -> Node<EnqueuedMusic>?{
        musicQueue.remove(value: EnqueuedMusic(music: music, user: user))
    }
    
    func getMusicsByRankedPopularity() -> Array<(Music, UInt)>{
        let entries = popularityDictionary.sorted { $0.1 > $1.1 }
        
        return entries
    }
    
    /* Por último uma função que retorna a fila de músicas escolhidas.  */
    
    func getMusicQueue() -> Queue<EnqueuedMusic> {
        musicQueue
    }
    
    func showMusicQueue(){
        print(musicQueue)
    }
}

func readLineInt() -> String?{  //Função utilizada para simular a leitura de linha
    String(0)
}

func selectMusicFromArray(musicArray: Array<Music>) -> Music{
    musicArray.enumerated().forEach { print("\($0) - \($1)") }
    
    var selected: Int = -1
    
    while selected < 0 || selected >= musicArray.count {
        guard let lineRead = readLineInt() else{
            print("Tente novamente!")
            continue
        }
        
        guard let stringConverted = Int(lineRead) else{
            print("Tente novamente!")
            continue
        }
        
        selected = stringConverted
    }
    
    return musicArray[selected]
}
