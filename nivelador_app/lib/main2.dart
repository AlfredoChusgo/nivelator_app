import 'dart:math';

import 'models/models.dart';



class DivisorDeJugadores {
  List<Jugador> jugadores;
  int cantidadGrupos;
  int jugadoresPorGrupo;

  DivisorDeJugadores({required this.jugadores, required this.cantidadGrupos, required this.jugadoresPorGrupo});

  List<List<Jugador>> dividirJugadores() {
    // Copia la lista de jugadores y la baraja de manera aleatoria
    List<Jugador> jugadoresAleatorios = List.from(jugadores)..shuffle(Random());

    // Divide a los jugadores en grupos
    List<List<Jugador>> grupos = List.generate(cantidadGrupos, (index) => []);

    for (int i = 0; i < jugadoresAleatorios.length; i++) {
      grupos[i % cantidadGrupos].add(jugadoresAleatorios[i]);
    }

    return grupos;
  }

}

// void main() {
//   List<Jugador> jugadores = [
//     Jugador(id: "as",nombre: "sdfasdf",ataque: 50,defensa: 20),
//     // Jugador(2, "Jugador2", 70, 65),
//     // Jugador(3, "Jugador3", 85, 55),
//     // Jugador(4, "Jugador4", 10, 20),  // Jugador con valores extremos
//     // Jugador(5, "Jugador5", 90, 50),
//     // Jugador(6, "Jugador6", 95, 45),
//     // Jugador(7, "Jugador7", 60, 75),
//     // Jugador(8, "Jugador8", 70, 80),
//     // Jugador(9, "Jugador9", 55, 90),
//     // Jugador(10, "Jugador10", 50, 95),
//     // Jugador(11, "Jugador11", 65, 85),
//     // Jugador(12, "Jugador12", 60, 70),
//   ];

//   // Solicitar la cantidad de grupos y jugadores por grupo al usuario
//   print("Ingrese la cantidad de grupos:");
//   int cantidadGrupos = 3;

//   print("Ingrese la cantidad de jugadores por grupo:");
//   int jugadoresPorGrupo = 4;

//   // Utilizar la clase DivisorDeJugadores para dividir a los jugadores en grupos
//   DivisorDeJugadores divisor = DivisorDeJugadores(jugadores: jugadores,cantidadGrupos: 3,jugadoresPorGrupo: 4);
//   List<List<Jugador>> grupos = divisor.dividirJugadores();

//   // Imprime los grupos y sus promedios
//   for (int i = 0; i < grupos.length; i++) {
//     print("Grupo ${i + 1}:");
//     double promedioAtaqueGrupo = 0;
//     double promedioDefensaGrupo = 0;

//     for (var jugador in grupos[i]) {
//       print("ID: ${jugador.id}, Nombre: ${jugador.nombre}, Ataque: ${jugador.ataque}, Defensa: ${jugador.defensa}");
//       promedioAtaqueGrupo += jugador.ataque;
//       promedioDefensaGrupo += jugador.defensa;
//     }

//     promedioAtaqueGrupo /= grupos[i].length;
//     promedioDefensaGrupo /= grupos[i].length;

//     print("Promedio de Ataque del Grupo: $promedioAtaqueGrupo");
//     print("Promedio de Defensa del Grupo: $promedioDefensaGrupo");
//     print("");
//   }
// }
