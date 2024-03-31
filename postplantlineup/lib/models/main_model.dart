class CardModel {
  final String title;
  final String imagePath;

  CardModel({
    required this.title,
    required this.imagePath,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      title: json['title'],
      imagePath: json['imagePath'],
    );
  }
}
