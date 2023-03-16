class Album {
  Album({required this.author, required this.id, required this.image});

  final id;
  final author;
  final image;

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        id: json['id'], author: json['author'], image: json['download_url']);
  }
}


// {"id":"102","author":"Ben Moore","width":4320,"height":3240,"url":"https://unsplash.com/photos/pJILiyPdrXI","download_url":"https://picsum.photos/id/102/4320/3240"}