import 'dart:math';

class Player {
  String name;
  int defense;
  int attack;
  int service;

  Player({
    required this.name,
    required this.defense,
    required this.attack,
    required this.service,
  });

  double getAverageSkill() {
    return (defense + attack + service) / 3;
  }
}

class Team {
  List<Player> players = [];

  double getAverageSkill() {
    double totalSkill = 0;
    for (var player in players) {
      totalSkill += player.getAverageSkill();
    }
    return totalSkill / players.length;
  }
}

//es necesario que tengan al menos 1 jugador con buen ataque 
//es necesario que tengan al menos 1 jugador con buena defenza

class NivelatorLogic{



}

void main() {
  List<Player> players = [
    Player(name: 'Jugador 1', defense: 75, attack: 85, service: 70),
    Player(name: 'Jugador 2', defense: 80, attack: 75, service: 90),
    // Agrega más jugadores aquí
  ];

  List<Team> teams = formBalancedTeams(players);

  for (int i = 0; i < teams.length; i++) {
    print('Equipo ${i + 1} - Habilidad Promedio: ${teams[i].getAverageSkill()}');
    for (Player player in teams[i].players) {
      print('${player.name} - Defensa: ${player.defense}, Ataque: ${player.attack}, Servicio: ${player.service}');
    }
  }
}

List<Team> formBalancedTeams(List<Player> players) {
  // Ordena a los jugadores por su habilidad promedio de menor a mayor
  players.sort((a, b) => a.getAverageSkill().compareTo(b.getAverageSkill()));

  List<Team> teams = List.generate(5, (_) => Team());

  // Asigna jugadores de manera estratégica, desde los extremos hacia el centro
  int left = 0;
  int right = players.length - 1;

  for (int i = 0; i < players.length; i++) {
    if (i % 2 == 0) {
      teams[i % 5].players.add(players[left]);
      left++;
    } else {
      teams[i % 5].players.add(players[right]);
      right--;
    }
  }

  return teams;
}
