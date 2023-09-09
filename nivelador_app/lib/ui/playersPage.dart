// import 'package:flutter/material.dart';

// import '../bussiness_logic.dart';
// import '../database_helper.dart';

// class CreatePlayerScreen extends StatefulWidget {
//   @override
//   _CreatePlayerScreenState createState() => _CreatePlayerScreenState();
// }

// class _CreatePlayerScreenState extends State<CreatePlayerScreen> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController defenseController = TextEditingController();
//   final TextEditingController attackController = TextEditingController();
//   final TextEditingController serviceController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Create Player'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: defenseController,
//               decoration: InputDecoration(labelText: 'Defense'),
//             ),
//             TextField(
//               controller: attackController,
//               decoration: InputDecoration(labelText: 'Attack'),
//             ),
//             TextField(
//               controller: serviceController,
//               decoration: InputDecoration(labelText: 'Service'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 final player = Player(
//                   name: nameController.text,
//                   defense: int.parse(defenseController.text),
//                   attack: int.parse(attackController.text),
//                   service: int.parse(serviceController.text),
//                 );
//                 await DatabaseHelper().insertPlayer(player);
//                 Navigator.pop(context);
//               },
//               child: Text('Save Player'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
