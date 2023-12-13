import Foundation

struct Jukebox{
    var musicQueue: Queue<EnqueuedMusic>
    var popularityDictionary: Dictionary<Music, UInt64>
    var musicPrice: UInt64
    
    /* O Jukebox deve conter a função de escolher a música que utiliza como dado de entrada o id da música e o usuário que a escolheu, e outra função de mesmo nome que utiliza como dados de entrada o nome da música e o usuário que a escolheu, essas duas funções devem enfileirar as músicas escolhidas e cobrar do usuário o preço pela escolha da música. */
    //escolherMusica(id musica, id user)
    //escolherMusica(nome musica, nomeuser)
    
    /* Outras duas funções de consultas de músicas também devem estar disponíveis na Jukebox uma pelo id e outra pelo nome da musica. */
    //consultaMusica(id musica)
    //consultaMusica(nome musica)
    
    /* Também deve estar disponível uma consulta de todas as músicas disponíveis e todas as músicas de determinado artista passando por id ou pelo nome do artista. */
    //todasMusicas()
    //consultaMusicasPorArtista(id artista)
    //consultaMusicasPorArtista(nome artista)
    
    @discardableResult
    mutating func nextMusic() -> Node<EnqueuedMusic>?{
        musicQueue.dequeue()
    }

    /* O Jukebox deve saber como retirar uma música já escolhida (sem estorno para o usuário) e como listar as músicas mais tocadas (mais escolhidas) quando for solicitado */
    
    @discardableResult
    mutating func removeMusicFromQueue(music: Music, user: User) -> Node<EnqueuedMusic>?{
        musicQueue.remove(value: EnqueuedMusic(music: music, user: user))
    }
    
    func getMusicsByRankedPopularity() -> Array<(Music, UInt64)>{
        let entries = popularitySet.sorted { $0.1 > $1.1 }
        
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

var queue: Queue<EnqueuedMusic> = Queue();

var u1 = User(id: 1, name: "Marcos", funds: 10000)
var a1 = Artist(id: 1, name: "Taylor Swift")
var m1 = Music(id: 1, name: "Welcome To New York", artist: a1, durationInSeconds: 300, score: 5.0)
var m2 = Music(id: 2, name: "Bad Blood", artist: a1, durationInSeconds: 300, score: 5.0)
var m3 = Music(id: 3, name: "Clean", artist: a1, durationInSeconds: 300, score: 5.0)
var m4 = Music(id: 4, name: "New Romantics", artist: a1, durationInSeconds: 300, score: 5.0)

m1.name

queue.isEmpty
queue.size
queue.enqueue(value: EnqueuedMusic(music: m1, user: u1))
queue.enqueue(value: EnqueuedMusic(music: m2, user: u1))
queue.enqueue(value: EnqueuedMusic(music: m3, user: u1))
queue.enqueue(value: EnqueuedMusic(music: m4, user: u1))
queue.description

queue.dequeue()
queue.size
queue.description

queue.remove(value: EnqueuedMusic(music: m3, user: u1))
queue.size
queue.description

var musicDictionary: Dictionary<String, Array<Music>> = Dictionary()
musicDictionary.updateValue([m1], forKey: String(1))
var ls = musicDictionary[String(1)]
ls?.append(m2)
musicDictionary.updateValue(ls!, forKey: String(1))
musicDictionary

var popularitySet: Dictionary<Music, UInt64> = Dictionary()
popularitySet[m1] = 100
popularitySet[m2] = 80
popularitySet[m3] = 140
popularitySet[m4] = 200

let entries = popularitySet.sorted { $0.1 > $1.1 }
type(of: entries)
for entry in entries{
    print(entry)
}

UInt64.max
print(UInt64.max)

let customDictionary: CustomDictionary<Music> = CustomDictionary()
customDictionary.add(m1)
customDictionary.add(m2)
customDictionary.add(m3)
customDictionary.add(m4)

var m1_2 = Music(id: 1, name: "You Are In Love", artist: a1, durationInSeconds: 300, score: 5.0)
customDictionary.add(m1_2)
customDictionary

var a2 = Artist(id: 2, name: "TS Cover")
var m5 = Music(id: 5, name: "Welcome To New York", artist: a2, durationInSeconds: 300, score: 5.0)
customDictionary.add(m5)
customDictionary

var m6 = Music(id: 6, name: "New Romantics", artist: a2, durationInSeconds: 300, score: 5.0)
customDictionary.add(m6)
customDictionary

customDictionary.removeAll(forKey: "Welcome To New York")
customDictionary

customDictionary.removeAll(forKey: 2)
customDictionary

customDictionary.removeAll(forKey: 6)
customDictionary

customDictionary.removeAll(forKey: 6)
customDictionary
