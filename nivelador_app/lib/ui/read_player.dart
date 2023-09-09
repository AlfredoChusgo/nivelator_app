// import 'package:flutter/material.dart';
// import '../bussiness_logic.dart';
// import '../database_helper.dart';

// class ReadPlayersScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Players'),
//       ),
//       body: FutureBuilder<List<Player>>(
//         future: DatabaseHelper().getPlayers(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             final players = snapshot.data;
//             return ListView.builder(
//               itemCount: players.length,
//               itemBuilder: (context, index) {
//                 final player = players[index];
//                 return ListTile(
//                   title: Text(player.name),
//                   subtitle: Text('Defense: ${player.defense}, Attack: ${player.attack}, Service: ${player.service}'),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
