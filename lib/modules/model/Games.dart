class Conf {
  int? id;
  String? type;
  String? value;

  Conf({this.id, this.type, this.value});

  factory Conf.fromJson(Map<String, dynamic> json) {
    return Conf(id: json['id'], type: json['type'], value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'type': type, 'value': value};
  }
}

class Game {
  int? id;
  String? name;
  String? detail;
  String? img;
  int? active;
  List<Conf>? conf;

  Game({this.id, this.name, this.detail, this.img, this.active, this.conf});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'],
      name: json['name'],
      detail: json['detail'],
      img: json['img'],
      active: json['active'],
      conf:
          json['conf'] != null
              ? List<Conf>.from(json['conf'].map((x) => Conf.fromJson(x)))
              : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'detail': detail,
      'img': img,
      'active': active,
      'conf': conf != null ? conf!.map((x) => x.toJson()).toList() : [],
    };
  }
}
