class Jugador {
  String id;
  String nombre;
  int ataque;
  int defensa;

  Jugador({required this.id, required this.nombre, required this.ataque, required this.defensa});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'ataque': ataque,
      'defensa': defensa,
    };
  }

  factory Jugador.fromMap(Map<String, dynamic> map) {
    return Jugador(
      id: map['id'],
      nombre: map['nombre'],
      ataque: map['ataque'],
      defensa: map['defensa'],
    );
  }
}

class ListaEquipoBalanceado {
  String id;
  String nombre;

  List<List<Jugador>> grupos;

  ListaEquipoBalanceado({required this.id, required this.nombre, required this.grupos});

  Map<String, dynamic> toMap() {
    final List<List<Map<String, dynamic>>> gruposMap = grupos.map((grupo) {
      return grupo.map((jugador) => jugador.toMap()).toList();
    }).toList();

    return {
      'id': id,
      'nombre': nombre,
      'grupos': gruposMap,
    };
  }

  // Método para crear un objeto ListaEquipoBalanceado desde un mapa
  factory ListaEquipoBalanceado.fromMap(Map<String, dynamic> map) {
    final List<List<Map<String, dynamic>>> gruposMap = List<List<Map<String, dynamic>>>.from(map['grupos']);
    final List<List<Jugador>> grupos = gruposMap.map((grupoMap) {
      return grupoMap.map((jugadorMap) => Jugador.fromMap(jugadorMap)).toList();
    }).toList();

    return ListaEquipoBalanceado(
      id: map['id'],
      nombre: map['nombre'],
      grupos: grupos,
    );
  }
}