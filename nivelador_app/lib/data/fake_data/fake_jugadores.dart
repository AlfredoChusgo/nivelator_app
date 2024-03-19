

import 'dart:convert';

import 'package:nivelador_app/models/models.dart';

const jsonData = '''[
  {
    "id": "1",
    "nombre": "alexander",
    "habilidades": {
      "ataque": 30,
      "defensa": 35,
      "salvada": 20,
      "servida": 40,
      "teamplay": 55,
      "saque": 40
    }
  },
  {
    "id": "2",
    "nombre": "Alfredo",
    "habilidades": {
      "ataque": 73,
      "defensa": 55,
      "salvada": 46,
      "servida": 50,
      "teamplay": 36,
      "saque": 46
    }
  },
  {
    "id": "3",
    "nombre": "Carla arevilca",
    "habilidades": {
      "ataque": 24,
      "defensa": 35,
      "salvada": 30,
      "servida": 48,
      "teamplay": 45,
      "saque": 28.5
    }
  },
  {
    "id": "4",
    "nombre": "christian rodillin",
    "habilidades": {
      "ataque": 50,
      "defensa": 35,
      "salvada": 20,
      "servida": 27,
      "teamplay": 30,
      "saque": 40
    }
  },
  {
    "id": "5",
    "nombre": "cristian",
    "habilidades": {
      "ataque": 50,
      "defensa": 70,
      "salvada": 80,
      "servida": 75,
      "teamplay": 100,
      "saque": 45
    }
  },
  {
    "id": "6",
    "nombre": "dalvinder",
    "habilidades": {
      "ataque": 38,
      "defensa": 30,
      "salvada": 28,
      "servida": 25,
      "teamplay": 35,
      "saque": 30
    }
  },
  {
    "id": "7",
    "nombre": "daniel coria",
    "habilidades": {
      "ataque": 45,
      "defensa": 78,
      "salvada": 81,
      "servida": 60,
      "teamplay": 80,
      "saque": 70
    }
  },
  {
    "id": "8",
    "nombre": "david juarez",
    "habilidades": {
      "ataque": 60,
      "defensa": 55,
      "salvada": 55,
      "servida": 70,
      "teamplay": 40,
      "saque": 58
    }
  },
  {
    "id": "9",
    "nombre": "edward",
    "habilidades": {
      "ataque": 43,
      "defensa": 35,
      "salvada": 30,
      "servida": 43,
      "teamplay": 38,
      "saque": 35
    }
  },
  {
    "id": "10",
    "nombre": "eduardo machaca",
    "habilidades": {
      "ataque": 40,
      "defensa": 42,
      "salvada": 38,
      "servida": 45,
      "teamplay": 80,
      "saque": 40
    }
  },
  {
    "id": "11",
    "nombre": "ibeth",
    "habilidades": {
      "ataque": 30,
      "defensa": 35,
      "salvada": 22,
      "servida": 35,
      "teamplay": 30,
      "saque": 50
    }
  },
  {
    "id": "12",
    "nombre": "isaac",
    "habilidades": {
      "ataque": 55,
      "defensa": 32,
      "salvada": 20,
      "servida": 19,
      "teamplay": 28,
      "saque": 60
    }
  },
  {
    "id": "13",
    "nombre": "JJ",
    "habilidades": {
      "ataque": 29,
      "defensa": 28,
      "salvada": 26,
      "servida": 38,
      "teamplay": 60,
      "saque": 44
    }
  },
  {
    "id": "14",
    "nombre": "jose maria",
    "habilidades": {
      "ataque": 63,
      "defensa": 62,
      "salvada": 50,
      "servida": 45,
      "teamplay": 35,
      "saque": 45
    }
  },
  {
    "id": "15",
    "nombre": "josue",
    "habilidades": {
      "ataque": 35,
      "defensa": 34,
      "salvada": 30,
      "servida": 32.5,
      "teamplay": 40,
      "saque": 35
    }
  },
  {
    "id": "16",
    "nombre": "julieta",
    "habilidades": {
      "ataque": 10,
      "defensa": 15,
      "salvada": 5,
      "servida": 10,
      "teamplay": 35,
      "saque": 15
    }
  },
  {
    "id": "17",
    "nombre": "margaret",
    "habilidades": {
      "ataque": 20,
      "defensa": 25,
      "salvada": 20,
      "servida": 20,
      "teamplay": 35,
      "saque": 22
    }
  },
  {
    "id": "18",
    "nombre": "matias",
    "habilidades": {
      "ataque": 20,
      "defensa": 30,
      "salvada": 24,
      "servida": 40,
      "teamplay": 45,
      "saque": 19
    }
  },
  {
    "id": "19",
    "nombre": "moises",
    "habilidades": {
      "ataque": 35,
      "defensa": 43,
      "salvada": 42,
      "servida": 32,
      "teamplay": 25,
      "saque": 35
    }
  },
  {
    "id": "20",
    "nombre": "nicolas",
    "habilidades": {
      "ataque": 65,
      "defensa": 40,
      "salvada": 35,
      "servida": 75,
      "teamplay": 30,
      "saque": 65
    }
  },
  {
    "id": "21",
    "nombre": "nirvana",
    "habilidades": {
      "ataque": 43,
      "defensa": 48,
      "salvada": 37,
      "servida": 55,
      "teamplay": 43,
      "saque": 65
    }
  },
  {
    "id": "22",
    "nombre": "paolo",
    "habilidades": {
      "ataque": 58,
      "defensa": 68,
      "salvada": 65,
      "servida": 51,
      "teamplay": 65,
      "saque": 52.5
    }
  },
  {
    "id": "23",
    "nombre": "patzi",
    "habilidades": {
      "ataque": 45,
      "defensa": 42.5,
      "salvada": 42.5,
      "servida": 40,
      "teamplay": 25,
      "saque": 35
    }
  },
  {
    "id": "24",
    "nombre": "piter",
    "habilidades": {
      "ataque": 22,
      "defensa": 25,
      "salvada": 22.5,
      "servida": 28,
      "teamplay": 35,
      "saque": 20
    }
  },
  {
    "id": "25",
    "nombre": "ronald",
    "habilidades": {
      "ataque": 90,
      "defensa": 90,
      "salvada": 90,
      "servida": 70,
      "teamplay": 90,
      "saque": 70
    }
  },
  {
    "id": "26",
    "nombre": "rony",
    "habilidades": {
      "ataque": 40,
      "defensa": 65,
      "salvada": 65,
      "servida": 50,
      "teamplay": 42,
      "saque": 42
    }
  },
  {
    "id": "27",
    "nombre": "ruben",
    "habilidades": {
      "ataque": 40,
      "defensa": 72.5,
      "salvada": 75,
      "servida": 45,
      "teamplay": 50,
      "saque": 42
    }
  },
  {
    "id": "28",
    "nombre": "suca",
    "habilidades": {
      "ataque": 45,
      "defensa": 62.5,
      "salvada": 67.5,
      "servida": 50,
      "teamplay": 35,
      "saque": 37.5
    }
  },
  {
    "id": "29",
    "nombre": "Andy",
    "habilidades": {
      "ataque": 25,
      "defensa": 50,
      "salvada": 45,
      "servida": 60,
      "teamplay": 50,
      "saque": 35
    }
  },
   {
    "id": "30",
    "nombre": "Josue z",
    "habilidades": {
      "ataque": 38,
      "defensa": 45,
      "salvada": 40,
      "servida": 45,
      "teamplay": 40,
      "saque": 30
    }
  },
  {
    "id": "31",
    "nombre": "Juan Z",
    "habilidades": {
      "ataque": 38,
      "defensa": 45,
      "salvada": 40,
      "servida": 45,
      "teamplay": 40,
      "saque": 30
    }
  }
  ] ''';

List<Jugador> fakeJugadores = List<Jugador>.from(
      json.decode(jsonData).map((x) => Jugador.fromMap(x)));

String ab = "asdfasdf";

