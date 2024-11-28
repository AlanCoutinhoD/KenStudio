import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/userProfile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; 
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts(); // Cargar las publicaciones cuando se inicie la pantalla
  }

  Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');  // Obtener el ID del usuario
  }

  // Función para obtener las publicaciones de la API
  Future<void> _fetchPosts() async {
    String url = 'https://f6b472jh-3006.usw3.devtunnels.ms/api/v1/publicaciones';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Decodificamos la respuesta JSON
        Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'encontrados') {
          // Convertimos la lista de publicaciones en un formato adecuado
          setState(() {
            posts = List<Map<String, dynamic>>.from(data['data'].map((post) {
              return {
                'imageUrl': post['contenido'], // URL de la imagen
                'title': post['titulo'], // Título de la publicación
                'description': post['desripcion'], // Descripción de la publicación
                'username': post['username_cliente'], // Nombre del autor
                'userId': post['id_cliente'], // ID del usuario para navegar al perfil
              };
            }));
          });
        } else {
          print('No se encontraron publicaciones');
        }
      } else {
        print('Error al cargar las publicaciones: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KENSTUDIO', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.redAccent,
        elevation: 4,
      ),
      body: posts.isEmpty
          ? Center(child: CircularProgressIndicator()) // Muestra un indicador mientras carga
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  elevation: 8,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagen de la publicación
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            post['imageUrl']!, // URL de la imagen
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 220,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Título de la publicación
                        Text(
                          post['title']!,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        // Descripción de la publicación
                        Text(
                          post['description']!,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 5),
                        // Nombre del autor, que al hacer clic navega al perfil
                        GestureDetector(
                          onTap: () {
                            // Navegar al perfil del usuario con el userId
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserProfileScreen(userId: post['userId']!),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('- ', style: TextStyle(fontSize: 14, color: Colors.grey)),
                              Text(post['username']!, style: TextStyle(fontSize: 14, color: Colors.black)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/subirPublicacion');
        },
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add, size: 30),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),  // Cambié el ícono por el de búsqueda
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Bandeja',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (index) async {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/buscador');
              break;
            case 2:
              Navigator.pushNamed(context, '/subirPublicacion');
              break;
            case 3:
              Navigator.pushNamed(context, '/videos');
              break;
            case 4:
            // Ahora obtenemos el userId desde SharedPreferences
              String? userId1 = await _getUserId(); // Recupera el userId guardado
              String userId = userId1 ?? 'default_value';  // Si es null, asigna 'default_value'
              Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserProfileScreen(userId: userId),
                              ),
                            );

              break;
          }
        },
      ),
    );
  }
}
