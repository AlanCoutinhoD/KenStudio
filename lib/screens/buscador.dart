
import 'package:flutter/material.dart';

class BuscadorScreen extends StatelessWidget {
  final List<Map<String, dynamic>> profiles = [
    {
      'name': 'Luis Gordillo',
      'followers': '10,500',
      'location': 'Potinaspak',
      'genres': 'Pop, Rock',
      'image': 'assets/images/default.jpg',
      'rating': '4/10',
    },
    {
      'name': 'Luis Batalla',
      'followers': '10,500',
      'location': 'Chiapa de Corzo',
      'genres': 'Pop, Rock',
      'image': 'assets/images/logo.png',
      'rating': '4/10',
    },
    {
      'name': 'Noe Alejandro',
      'followers': '10,500',
      'location': 'Potinaspak',
      'genres': 'Pop, Rock',
      'image': 'assets/images/noe.png',
      'rating': '4/10',
    },
    {
      'name': 'Grupo Marrano',
      'followers': '10,500',
      'location': 'Potinaspak',
      'genres': 'Pop, Rock',
      'image': 'assets/images/default.jpg',
      'rating': '4/10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfiles'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar perfiles...',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {},
                  child: Text('Buscar'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return GestureDetector(
                  onTap: () {
                    // Al hacer clic en un perfil, navegar a la pantalla de perfil
                    Navigator.pushNamed(
                      context,
                      '/profile',
                      arguments: profile,  // Pasar el perfil seleccionado
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      leading: ClipOval(
                        child: Image.asset(
                          profile['image'],  // Imagen circular
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(profile['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${profile['followers']} seguidores'),
                          Text(profile['location']),
                          Text(profile['genres']),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.yellow),
                          Text(profile['rating']),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
        ],
      ),
    );
  }
}
