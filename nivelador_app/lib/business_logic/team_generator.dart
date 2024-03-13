import 'dart:math';

import 'package:faker/faker.dart';

import '../models/models.dart';

class TeamGenerator {
List<Team> monteCarloBalance(List<Jugador> players, int numTeams, {num defensaWeight = 1, num ataqueWeight = 1, num salvadaWeight = 1,
 num saqueWeight = 1, num servidaWeight = 1, num teamplayWeight = 1}) {
  Random random = Random();
  List<Team> bestTeams = List.empty(growable: true);
  num bestDifference = 2147483647;
  int iterations = 100000;

  for (int i = 0; i < iterations; i++) {
    List<Team> currentTeams = List.generate(numTeams, (_) => Team.Empty());

    // Shuffle players randomly
    List<Jugador> shuffledPlayers = List.from(players);
    shuffledPlayers.shuffle();

    // Assign players to teams randomly
    for (int j = 0; j < shuffledPlayers.length; j++) {
      currentTeams[j % numTeams].players.add(shuffledPlayers[j]);
    }

    // Calculate the difference in total scores between teams
    num maxScore = currentTeams.map((team) => team.getTotalScore(
      defensaWeight: defensaWeight, 
      ataqueWeight: ataqueWeight,
      salvadaWeight: salvadaWeight,
      saqueWeight: saqueWeight,
      servidaWeight: servidaWeight,
      teamplayWeight: teamplayWeight)).reduce(max);

    num minScore = currentTeams.map((team) => team.getTotalScore(
      defensaWeight: defensaWeight, 
      ataqueWeight: ataqueWeight,
      salvadaWeight: salvadaWeight,
      saqueWeight: saqueWeight,
      servidaWeight: servidaWeight,
      teamplayWeight: teamplayWeight)).reduce(min);

    num difference = maxScore - minScore;

    // Update best teams if current teams have a smaller difference
    if (difference < bestDifference) {
      bestDifference = difference;
      bestTeams = List.from(currentTeams);
    }
  }

  return bestTeams;
}
}


void main() {
    final faker = Faker();
    int count = 20;
    List<Jugador> jugadores = List.empty(growable: true);
    for (int i = 0; i < count; i++) {
    final jugador = Jugador(
      id: faker.guid.guid(),
      //ci: faker.random.alphaNumeric(8),
      nombre: faker.person.firstName(),
      ataque : faker.randomGenerator.integer(100,min: 0),
      defensa : faker.randomGenerator.integer(100,min: 0),
      salvada : faker.randomGenerator.integer(100,min: 0),
      servida : faker.randomGenerator.integer(100,min: 0),
      teamplay : faker.randomGenerator.integer(100,min: 0),
      saque : faker.randomGenerator.integer(100,min: 0),
    );
    jugadores.add(jugador);
  }



  int numTeams = 5;
  List<Team> teams = TeamGenerator().monteCarloBalance(jugadores, numTeams, defensaWeight: 0.5, ataqueWeight: 1,salvadaWeight: 0.25,saqueWeight: 0.1,servidaWeight: 0.7,teamplayWeight: 0.3);


  // Print teams and their total scores
  for (int i = 0; i < teams.length; i++) {
    print("Team ${i + 1}:");
    teams[i].players.forEach((player) {
      //print("${player.nombre} - Defense: ${player.defense}, Attack: ${player.attack}");
      print(player.toString());
    });
    //print("Total Defense: ${teams[i].totalDefense}, Total Attack: ${teams[i].totalAttack}, Total Score: ${teams[i].getTotalScore(defenseWeight: 2, attackWeight: 1)}\n");
    print("Total score : ${teams[i].getTotalScore()}");
  }
}
