import 'dart:convert';

class Jugador {
  String id;
  String nombre;  
  JugadorHabilidades habilidades;

  Jugador({
    required this.id,
    required this.nombre,
    required this.habilidades
  });

factory Jugador.fromJson(String json) {
    final Map<String, dynamic> map = jsonDecode(json);
    return Jugador(
      id: map['id'],
      nombre: map['nombre'],
      habilidades: JugadorHabilidades(
        ataque: map['habilidades']['ataque'],
        defensa: map['habilidades']['defensa'],
        salvada: map['habilidades']['salvada'],
        servida: map['habilidades']['servida'],
        teamplay: map['habilidades']['teamplay'],
        saque: map['habilidades']['saque'],
      ),
    );
  }

  // Method to convert Jugador instance to a JSON string
  String toJson() {
    return jsonEncode({
      'id': id,
      'nombre': nombre,
      'habilidades': {
        'ataque': habilidades.ataque,
        'defensa': habilidades.defensa,
        'salvada': habilidades.salvada,
        'servida': habilidades.servida,
        'teamplay': habilidades.teamplay,
        'saque': habilidades.saque,
      },
    });
  }
  
 // Method to create a Jugador instance from a Map
  static Jugador fromMap(Map<String, dynamic> map) {
    return Jugador(
      id: map['id'] as String,
      nombre: map['nombre'] as String,
      habilidades: JugadorHabilidades(
        ataque: map['habilidades']['ataque'] as num,
        defensa: map['habilidades']['defensa'] as num,
        salvada: map['habilidades']['salvada'] as num,
        servida: map['habilidades']['servida'] as num,
        teamplay: map['habilidades']['teamplay'] as num,
        saque: map['habilidades']['saque'] as num,
      ),
    );
  }

  static Jugador fromSQLiteTable(Map<String, dynamic> map) {
    return Jugador(
      id: map['id'] as String,
      nombre: map['nombre'] as String,
      habilidades: JugadorHabilidades(
        ataque: map['ataque'] as num,
        defensa: map['defensa'] as num,
        salvada: map['salvada'] as num,
        servida: map['servida'] as num,
        teamplay: map['teamplay'] as num,
        saque: map['saque'] as num,
      ),
    );
  }

  // Method to convert Jugador instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'habilidades': {
        'ataque': habilidades.ataque,
        'defensa': habilidades.defensa,
        'salvada': habilidades.salvada,
        'servida': habilidades.servida,
        'teamplay': habilidades.teamplay,
        'saque': habilidades.saque,
      },
    };
  }


  Map<String, dynamic> toSqliteTable() {
    return {
      'id': id,
      'nombre': nombre,
      'ataque': habilidades.ataque,
      'defensa': habilidades.defensa,
      'salvada': habilidades.salvada,
      'servida': habilidades.servida,
      'teamplay': habilidades.teamplay,
      'saque': habilidades.saque,
    };
  }
  @override
  String toString() {
    return 'Jugador{id: $id, nombre: $nombre, ataque: ${habilidades.ataque}, defensa: ${habilidades.defensa}, salvada: ${habilidades.salvada}, servida: ${habilidades.servida}, teamplay: ${habilidades.teamplay}, saque: ${habilidades.saque}}';
  }
  String getNameAndScore(HabilidadesPeso pesos){
    return "$nombre -- score : ${getScore(pesos)}";
  }

  num getScore(HabilidadesPeso pesos) {
    //HabilidadesPeso pesos = getHabilidadPeso(configuration);
    num result = 0;

    result += (pesos.ataque * habilidades.ataque) +
        (pesos.defensa * habilidades.defensa) +
        (pesos.salvada * habilidades.salvada) +
        (pesos.servida * habilidades.servida) +
        (pesos.teamplay * habilidades.teamplay) +
        (pesos.saque * habilidades.saque);
    return result;
  }
  
  HabilidadesPeso getHabilidadPeso(ScoreWeightConfiguration configuration) {
    HabilidadesPeso pesos = HabilidadesPeso.maximumWeight();

    switch (configuration) {
      case ScoreWeightConfiguration.none:
        pesos.ataque = 1;
        pesos.defensa = 1;
        pesos.salvada = 1;
        pesos.servida = 1;
        pesos.teamplay = 1;
        pesos.saque = 1;

        break;

      case ScoreWeightConfiguration.simple:
              pesos.ataque = 0.8;//
        pesos.defensa = 0.6;//
        pesos.salvada = 0.5;
        pesos.servida = 0.7;//
        pesos.teamplay = 0.35;
        pesos.saque = 0.15;       

        break;

      case ScoreWeightConfiguration.advance:
        pesos.ataque = 0.9;
        pesos.defensa = 0.70;
        pesos.salvada = 0.40;
        pesos.servida = 0.9;
        pesos.teamplay = 0.2;
        pesos.saque = 0.1;

        break;
        case ScoreWeightConfiguration.custom:
        pesos.ataque = 0.9;//
        pesos.defensa = 0.45;//
        pesos.salvada = 0.20;
        pesos.servida = 0.30;//
        pesos.teamplay = 0.1;
        pesos.saque = 0.05;

        break;
      default:
    }

    return pesos;
  }

  static String getJsonFromJugadores(List<Jugador> jugadores){
    List<Map<String, dynamic>> jugadoresMap = jugadores.map((jugador) => jugador.toMap()).toList();
    String jsonString = jsonEncode(jugadoresMap);

    return jsonString;
  }
}

class Team {
  List<Jugador> players;
  //ScoreWeightConfiguration configuration;
  HabilidadesPeso pesos;
  Team({required this.players, required this.pesos});

  factory Team.Empty() {
    return Team(players: [],pesos: HabilidadesPeso.maximumWeight());
  }

  //num getTotalScore({num ataqueWeight = 1, num defensaWeight = 1, num salvadaWeight = 1, num servidaWeight = 1, num teamplayWeight = 1, num saqueWeight = 1}) {
  num getTotalScore(){
    return _getTotalScore(pesos);
  }

  num getTotalScoreWithCustomConfiguration(HabilidadesPeso pesos){
    return _getTotalScore(pesos);
  }
  num _getTotalScore(HabilidadesPeso pesos) {

    num total = 0;

    for (Jugador jugador in players) {
      total += jugador.getScore(pesos);
    }
    return total;
  }

  Map<String, dynamic> toMap() {
    return {
      'players': players.map((jugador) => jugador.toMap()).toList(),
      'pesos': pesos.toString(),
    };
  }

  // Create Team object from Map
  static Team fromMap(Map<String, dynamic> map) {
    return Team(
      players: List<Jugador>.from(
          map['players'].map((item) => Jugador.fromMap(item))),
      // configuration: ScoreWeightConfiguration.values
      //     .firstWhere((e) => e.toString() == map['configuration']),
      pesos : HabilidadesPeso.maximumWeight()
    );
  }

  
  static String toWhatsappMessage(List<List<Team>> teams){
    String result = "";

    for (var j = 0; j < teams.length; j++) {
      result += "``` \n Opcion [$j]```";
      for (var i = 0; i < teams.length; i++) {
        result += "``` \n Equipo $i```";
        teams[j][i].players.forEach((element) {
          result += "\n";
          result += "* ${element.nombre}";
        });

        result += " \n ----------------------";
      }
      result += " \n [][][][][][][]";      
    }


    return result;
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

class ListaJugadores {
  String id;
  String nombre;
  List<Jugador> jugadores;

  ListaJugadores({required this.id, required this.nombre, required this.jugadores});
  
  }

enum ScoreWeightConfiguration { none, simple, advance, custom }
enum IterationCategory {
  veryLow,
  low,
  moderate,
  high,
  veryHigh,
}

extension IterationCategoryExtension on IterationCategory {
  String toStringValue() {
    switch (this) {
      case IterationCategory.veryLow:
        return 'Muy baja';
      case IterationCategory.low:
        return 'Baja';
      case IterationCategory.moderate:
        return 'Moderada';
      case IterationCategory.high:
        return 'Alta';
      case IterationCategory.veryHigh:
        return 'Muy alta';
    }
  }

    int toCantidadIteracionesValue() {
    switch (this) {
      case IterationCategory.veryLow:
        return 1000;
      case IterationCategory.low:
        return 10000;
      case IterationCategory.moderate:
        return 100000;
      case IterationCategory.high:
        return 1000000;
      case IterationCategory.veryHigh:
        return 3000000;
    }
  }
}

class JugadorHabilidades {
  num ataque;
  num defensa;
  num salvada;
  num servida;
  num teamplay;
  num saque;
  JugadorHabilidades({required this.ataque, required this.defensa, required this.salvada, required this.servida, required this.teamplay, required this.saque });

    @override
  String toString() {
    return '{ataque: $ataque, defensa: $defensa, salvada: $salvada, servida: $servida, teamplay: $teamplay, saque: $saque}';
  }
}

class HabilidadesPeso {
  num ataque;
  num defensa;
  num salvada;
  num servida;
  num teamplay;
  num saque;
  HabilidadesPeso({required this.ataque, required this.defensa, required this.salvada, required this.servida, required this.teamplay, required this.saque });

  factory HabilidadesPeso.maximumWeight(){
    return HabilidadesPeso(ataque: 1, defensa: 1, salvada: 1, servida: 1, teamplay: 1, saque: 1);
  }

  factory HabilidadesPeso.fromJson(String jsonString) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return HabilidadesPeso(
      ataque: jsonMap['ataque'],
      defensa: jsonMap['defensa'],
      salvada: jsonMap['salvada'],
      servida: jsonMap['servida'],
      teamplay: jsonMap['teamplay'],
      saque: jsonMap['saque'],
    );
  }

  String toJson() {
    return jsonEncode({
      'ataque': ataque,
      'defensa': defensa,
      'salvada': salvada,
      'servida': servida,
      'teamplay': teamplay,
      'saque': saque,
    });
  }
}

class Settings {
  HabilidadesPeso habilidadesPeso;

  Settings({required this.habilidadesPeso});

  static Settings fromSQLiteTable(String jsonString) {
    return Settings( 
      habilidadesPeso: HabilidadesPeso.fromJson(jsonString),
    );
  }
}

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