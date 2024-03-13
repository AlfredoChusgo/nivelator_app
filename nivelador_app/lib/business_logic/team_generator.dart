import 'dart:math';

import 'package:faker/faker.dart';

import '../models/models.dart';

class TeamGenerator {
  Future<List<Team>> monteCarloBalance(List<Jugador> players, int numTeams,
      ScoreWeightConfiguration configuration) async {
    Random random = Random();
    List<Team> bestTeams = List.empty(growable: true);
    num bestDifference = 2147483647;
    int iterations = 1000000;

    for (int i = 0; i < iterations; i++) {

      if (i % 100 == 0) {
        await Future.delayed(Duration.zero);
      }
      List<Team> currentTeams = List.generate(
          numTeams, (_) => Team(players: [], configuration: configuration));

      // Shuffle players randomly
      List<Jugador> shuffledPlayers = List.from(players);
      shuffledPlayers.shuffle();

      // Assign players to teams randomly
      for (int j = 0; j < shuffledPlayers.length; j++) {
        currentTeams[j % numTeams].players.add(shuffledPlayers[j]);
      }

      // Calculate the difference in total scores between teams
      num maxScore =
          currentTeams.map((team) => team.getTotalScore()).reduce(max);

      num minScore =
          currentTeams.map((team) => team.getTotalScore()).reduce(min);

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

void main() async{
  final faker = Faker();
  int count = 20;
  List<Jugador> jugadores = List.empty(growable: true);
  for (int i = 0; i < count; i++) {
    final jugador = Jugador(
      id: faker.guid.guid(),
      //ci: faker.random.alphaNumeric(8),
      nombre: faker.person.firstName(),
      ataque: faker.randomGenerator.integer(100, min: 0),
      defensa: faker.randomGenerator.integer(100, min: 0),
      salvada: faker.randomGenerator.integer(100, min: 0),
      servida: faker.randomGenerator.integer(100, min: 0),
      teamplay: faker.randomGenerator.integer(100, min: 0),
      saque: faker.randomGenerator.integer(100, min: 0),
    );
    jugadores.add(jugador);
  }

  int numTeams = 5;
  List<Team> teams = await TeamGenerator()
      .monteCarloBalance(jugadores, numTeams, ScoreWeightConfiguration.simple);

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
