import 'package:festival_volunteer_application/UX_Elements/StandardAppBar.dart';
import 'package:flutter/material.dart';

class FoodAndBeveragesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StandardAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/app_backdrop_V1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            _buildBeverageTile(),
            _buildFoodTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildBeverageTile() {
    final beverages = [
      {
        'header': 'Øl og Cider',
        'items': [
          {'name': 'Bøgedal x ØF 24', 'price': '42 kroner'},
          {'name': 'Royal Øko Pils', 'price': '32 kroner'},
          {'name': 'Royal Øko Classic', 'price': '32 kroner'},
          {'name': 'Happy Joe Cider', 'price': '36 kroner'},
        ]
      },
      {
        'header': 'Nohrlund Øko Drinks',
        'items': [
          {'name': 'Nohrlund Gin tonic', 'price': '52 kroner'},
          {'name': 'Nohrlund Raspberry & Peach Collins', 'price': '52 kroner'},
          {'name': 'Nohrlund Mojito', 'price': '52 kroner'},
          {'name': 'Nohrlund Gin Mango smash', 'price': '52 kroner'},
        ]
      },
      {
        'header': 'Vin og bobler',
        'items': [
          {'name': 'Rødvin', 'price': '250 kroner'},
          {'name': 'Hvid Naturvin', 'price': '250 kroner'},
          {'name': 'Rose', 'price': '250 kroner'},
          {'name': 'Cava', 'price': '200 kroner'},
          {'name': 'Orange Vin', 'price': '280 kroner'},
        ]
      },
      {
        'header': 'Mate Mate',
        'items': [
          {'name': 'Maté Maté', 'price': '30 kroner'},
          {'name': 'Vodka Maté Maté', 'price': '42 kroner'},
          {'name': 'Double Shot', 'price': '52 kroner'},
        ]
      },
      {
        'header': 'Sodavand og danskvand',
        'items': [
          {'name': 'Hancock Danskvand', 'price': '20 kroner'},
          {'name': 'Sicillia/Fritz Sodavand', 'price': '20 kroner'},
        ]
      },
    ];

    return Card(
      color: const Color.fromARGB(255, 210, 232, 198)?.withOpacity(0.85),
      shadowColor: Colors.black,
      margin: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            const Text(
              'Drikkevarer',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OedstedFestival',
              ),
            ),
            const SizedBox(height: 5.0),
            ...beverages.map((section) {
              final header = section['header'] as String;
              final items = section['items'] as List<Map<String, String>>;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5.0),
                  Text(
                    header,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OedstedFestival',
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  ...items.map((bev) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        '${bev['name']}, ${bev['price']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'OedstedFestival',
                        ),
                      ),
                    );
                  }).toList(),
                ],
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodTile() {
    final foods = [
      {
        'name': 'Rulle med falafel',
        'description':
            'Arabisk brød\nHomemade falafel\nSprød Spidskål\nJuicy rødkål med varme krydderier\nMarineret rødløg med sylt\nYogurt med urter\nKraftig tahin mayo',
        'price': '70 kroner'
      },
      {
        'name': 'Bowl',
        'description':
            'Krydret tyrkisk bulgur\nHomemade falafel\nSprød Spidskål\nJuicy rødkål med varme krydderier\nMarineret rødløg med sylt\nYogurt med urter\nKraftig Tahin mayo',
        'price': '70 kroner'
      },
      {
        'name': 'Fritter med mayo (Fuld vegansk)',
        'description': '',
        'price': '35 kroner'
      },
    ];

    return Card(
      color: const Color.fromARGB(255, 210, 232, 198)?.withOpacity(0.85),
      shadowColor: Colors.black,
      margin: const EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            const Text(
              'Menu',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OedstedFestival',
              ),
            ),
            const SizedBox(height: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: foods.map((food) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        food['name']!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OedstedFestival',
                        ),
                      ),
                      if (food['description']!.isNotEmpty) ...[
                        const SizedBox(height: 5.0),
                        Text(
                          food['description']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'OedstedFestival',
                          ),
                        ),
                      ],
                      const SizedBox(height: 5.0),
                      Text(
                        food['price']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OedstedFestival',
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}