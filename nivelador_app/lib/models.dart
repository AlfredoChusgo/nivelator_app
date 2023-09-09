
class Team {
  int? id;
  String name;

  Team({
    this.id,
    required this.name,
  });
}

class Player {
  int? id;
  String name;
  int defense;
  int attack;
  int service;
  int? teamId;

  Player({
    this.id,
    required this.name,
    required this.defense,
    required this.attack,
    required this.service,
    this.teamId,
  });

  // Convert a Player object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'defense': defense,
      'attack': attack,
      'service': service,
      'team_id': teamId,
    };
  }
}
