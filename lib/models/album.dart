class Album {
  Album({required this.title, required this.image});

  final title;
  final image;

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(image: json['thumbnailUrl'], title: json['title']);
  }
}
