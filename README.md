# Desafio Tecnico IOS
## Aplicação simulando o funcionamento de uma jukebox

### Tópicos utilizados
* Structs
* Classes
* Optionals
* Dictionaries
* Generics
* Protocols
* Extensions

### Estruturas extras implementadas

* Node - Class
* Queue - Struct
* CustomDictionary - Class
* EnqueuedMusic - Struct

### TODO List

* (Branch API_Spotify) Adicionar conexão com [API do Spotify](https://developer.spotify.com/documentation/web-api), com foco em [playlists](https://developer.spotify.com/documentation/web-api/reference/get-playlists-tracks);
* Sair de Playground para Command Line Tool para poder fazer uma interface no terminal para interação com usuário;
* Reescrever e melhorar CustomDictionary, a fim de torna-lá mais legivel e eficiente;
* Utilizar [biblioteca oficial de estruturas de dados da Apple](https://github.com/apple/swift-collections) para substituir Queue - que utiliza uma abordagem de lista duplamente encadeada com apontamentos para o inicio e fim - pela Deque - que utiliza listas circulares com apontamentos para o inicio e fim.

### Implementação CustomDictionary

#### CustomDictionary
* Classe utilizada para as funções relacionadas as buscas de músicas, atráves de seus ids e nome, ou por ids e nome de Artistas. Nessa, tem-se dois dicionarios que são a parte principal dessa, uma vez que atráves dessa estrutura é possível realizar buscas em tempo amortizado de O(1) - que é importante uma vez que a principal operação é a get;
* Dicionario entre String - "int: id" ou "string: nome" - e T, nesse caso Music;
* Nessa, as principais operações são add, removeAll, removeMusicFromArtist e funções get.
  * add -> insere (int: id_musica, Music) caso não exista, para garantir que só tenha uma música por id, após isso adiciona (string: nome_musica, Musica) na principal, (string: nome_artista, Musica) e (string: id_artista, Musica) na secundária;
  * removeAll(String) -> remove todas as músicas com o mesmo nome tanto da principal quanto da secundária;
  * removeAll(Int) -> remove a música com o mesmo id tanto da principal quanto da secundária;
  * removeMusicFromArtist(T) -> função para facilitar a remoção de músicas do dicionário secundário, uma vez que os procedimentos são iguais nos dois casos, diferentemente dos metodos anteriores;
  * getAllMusics() -> retorna um opcional de lista T que filtra os valores pelas chaves que contém o inicio "int: " para pegarmos apenas uma entrada de cada música, uma vez que o id é único. 
