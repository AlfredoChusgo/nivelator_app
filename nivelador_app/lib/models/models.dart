class Jugador {
  String id;
  String nombre;
  int ataque;
  int defensa;
  int salvada;
  int servida;
  int teamplay;
  int saque;
  
  Jugador(
      {required this.id,
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

  Team({required this.players});  
  
  factory Team.Empty(){
    return Team(players: []);
  }

  num getTotalScore({num ataqueWeight = 1, num defensaWeight = 1, num salvadaWeight = 1, num servidaWeight = 1, num teamplayWeight = 1, num saqueWeight = 1}) {
    num total = 0;
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

   // Convert Team object to Map
  Map<String, dynamic> toMap() {
    return {
      'jugadores': players.map((jugador) => jugador.toMap()).toList(),
    };
  }

  // Create Team object from Map
  static Team fromMap(Map<String, dynamic> map) {
    return Team(
      players: (map['jugadores'] as List<dynamic>)
      .map((playerMap) => Jugador.fromMap(playerMap)).toList()
    );
  }
}

class ListaEquipoBalanceado {
  String id;
  String nombre;
  DateTime dateTime;
  List<Team> equipos;

  ListaEquipoBalanceado({required this.id, required this.nombre, required this.equipos, required this.dateTime});

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
      equipos: (map['equipos'] as List<dynamic>).map((teamMap) => Team.fromMap(teamMap)).toList(),
    );
  }
}