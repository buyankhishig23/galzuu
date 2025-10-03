class Question {
  int? id;
  int? gameId;
  String? question;
  String? img;
  String? type;

  Question({this.id, this.gameId, this.question, this.img, this.type});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      gameId: json['game_id'],
      question: json['question'],
      img: json['img'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'game_id': gameId,
      'question': question,
      'img': img,
      'type': type,
    };
  }
}
