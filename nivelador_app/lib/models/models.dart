class Jugador {
  String id;
  String nombre;
  int ataque;
  int defensa;
  int salvada;
  int servida;
  int teamplay;
  int saque;

  Jugador({
    required this.id,
    required this.nombre,
    required this.ataque,
    required this.defensa,
    required this.salvada,
    required this.servida,
    required this.teamplay,
    required this.saque,
  });

  // Convert Jugador object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'ataque': ataque,
      'defensa': defensa,
      'salvada': salvada,
      'servida': servida,
      'teamplay': teamplay,
      'saque': saque,
    };
  }

  // Create Jugador object from Map
  static Jugador fromMap(Map<String, dynamic> map) {
    return Jugador(
      id: map['id'],
      nombre: map['nombre'],
      ataque: map['ataque'],
      defensa: map['defensa'],
      salvada: map['salvada'],
      servida: map['servida'],
      teamplay: map['teamplay'],
      saque: map['saque'],
    );
  }

  @override
  String toString() {
    return 'Jugador{id: $id, nombre: $nombre, ataque: $ataque, defensa: $defensa, salvada: $salvada, servida: $servida, teamplay: $teamplay, saque: $saque}';
  }
}

class Team {
  List<Jugador> players;
  ScoreWeightConfiguration configuration;
  Team({required this.players, required this.configuration});

  factory Team.Empty() {
    return Team(players: [],configuration: ScoreWeightConfiguration.none);
  }

  //num getTotalScore({num ataqueWeight = 1, num defensaWeight = 1, num salvadaWeight = 1, num servidaWeight = 1, num teamplayWeight = 1, num saqueWeight = 1}) {
  num getTotalScore(){
    return _getTotalScore(configuration);
  }

  num getTotalScoreWithCustomConfiguration(ScoreWeightConfiguration configuration){
    return _getTotalScore(configuration);
  }
  num _getTotalScore(ScoreWeightConfiguration configuration) {
    num ataqueWeight = 1;
    num defensaWeight = 1;
    num salvadaWeight = 1;
    num servidaWeight = 1;
    num teamplayWeight = 1;
    num saqueWeight = 1;

    num total = 0;

    switch (configuration) {
      case ScoreWeightConfiguration.none:
        ataqueWeight = 1;
        defensaWeight = 1;
        salvadaWeight = 1;
        servidaWeight = 1;
        teamplayWeight = 1;
        saqueWeight = 1;

        break;

      case ScoreWeightConfiguration.simple:
        ataqueWeight = 0.8;
        defensaWeight = 0.5;
        salvadaWeight = 0.25;
        servidaWeight = 0.7;
        teamplayWeight = 0.3;
        saqueWeight = 0.1;

        break;

      case ScoreWeightConfiguration.advance:
        ataqueWeight = 0.9;
        defensaWeight = 0.70;
        salvadaWeight = 0.40;
        servidaWeight = 0.9;
        teamplayWeight = 0.2;
        saqueWeight = 0.1;

        break;
      default:
    }

    for (Jugador jugador in players) {
      total += (ataqueWeight * jugador.ataque) +
          (defensaWeight * jugador.defensa) +
          (salvadaWeight * jugador.salvada) +
          (servidaWeight * jugador.servida) +
          (teamplayWeight * jugador.teamplay) +
          (saqueWeight * jugador.saque);
    }
    return total;
  }

  Map<String, dynamic> toMap() {
    return {
      'players': players.map((jugador) => jugador.toMap()).toList(),
      'configuration': configuration.toString(),
    };
  }

  // Create Team object from Map
  static Team fromMap(Map<String, dynamic> map) {
    return Team(
      players: List<Jugador>.from(
          map['players'].map((item) => Jugador.fromMap(item))),
      configuration: ScoreWeightConfiguration.values
          .firstWhere((e) => e.toString() == map['configuration']),
    );
  }
}

class ListaEquipoBalanceado {
  String id;
  String nombre;
  DateTime dateTime;
  List<Team> equipos;

  ListaEquipoBalanceado(
      {required this.id,
      required this.nombre,
      required this.equipos,
      required this.dateTime});

  // Convert ListaEquipoBalanceado object to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'dateTime': dateTime.toIso8601String(),
      'equipos': equipos.map((team) => team.toMap()).toList(),
    };
  }

  // Create ListaEquipoBalanceado object from Map
  static ListaEquipoBalanceado fromMap(Map<String, dynamic> map) {
    return ListaEquipoBalanceado(
      id: map['id'],
      nombre: map['nombre'],
      dateTime: DateTime.parse(map['dateTime']),
      equipos: (map['equipos'] as List<dynamic>)
          .map((teamMap) => Team.fromMap(teamMap))
          .toList(),
    );
  }
}

enum ScoreWeightConfiguration { none, simple, advance }
// class ScoreWeight {
//   late num ataqueWeight;
//   late num defensaWeight;
//   late num salvadaWeight;
//   late num servidaWeight;
//   late num teamplayWeight;
//   late num saqueWeight;

//   ScoreWeight({required num defensaWeight ,required  num ataqueWeight ,required  num salvadaWeight ,
//  required num saqueWeight ,required  num servidaWeight,required  num teamplayWeight}){
//    ataqueWeight = ataqueWeight ;
//    defensaWeight = defensaWeight;
//    salvadaWeight = salvadaWeight; 
//    servidaWeight = servidaWeight; 
//    teamplayWeight = teamplayWeight; 
//    saqueWeight = saqueWeight;
//   }

//   factory ScoreWeight.empty(){
//     return ScoreWeight(defensaWeight: 1, ataqueWeight: 1, salvadaWeight: 1, saqueWeight: 1, servidaWeight: 1, teamplayWeight: 1);
//   }
//   factory ScoreWeight.empty(){
//     return ScoreWeight(defensaWeight: 1, ataqueWeight: 1, salvadaWeight: 1, saqueWeight: 1, servidaWeight: 1, teamplayWeight: 1);
//   }
// }