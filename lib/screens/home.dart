// screens/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> posts = [
    {
      'username': 'Noe Alejandro',
      'userhandle': '@Noeon',
      'profileImage': 'https://yt3.googleusercontent.com/LSzYgCI1omHqqJ_kwGclTsZ68_jstIUpJNMjL64D0pD8vJrNEmXz5QFfC05zn5PHe4UGhKpyKw=s900-c-k-c0x00ffffff-no-rj', // Imagen de perfil del usuario
      'postImage': 'https://th.bing.com/th/id/R.c0a730b85da26a404a60d3da4289dfd3?rik=NgSa4X6OQKG1bA&riu=http%3a%2f%2fpm1.narvii.com%2f7807%2f73059d227c8c1f5ff28bb0e27406cf02c72de741r1-451-680v2_uhq.jpg&ehk=YD%2fdRTlhVfMpwDuZEtPmWnvNsirCj9%2fDKtueQ4NEg%2bM%3d&risl=&pid=ImgRaw&r=0', // Imagen del post
      'title': 'Evento de 15 años',
      'description': 'Evento de 15 años en Tuxtla Gutiérrez en el salón Las Lomas'
    },
    // Puedes agregar más posts a esta lista
    {
      'username': 'Luis Batalla',
      'userhandle': '@LuisB',
      'profileImage': 'https://scontent.ftgz2-1.fna.fbcdn.net/v/t39.30808-6/361609173_290338383516902_148942040969675955_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeGiqzfyU-sYlnidhtQxNeiYB0AuegqO28sHQC56Co7byxadzn9MZs06SzWLAtXT6lLUj0OpHfrh_g61sDnZeKEr&_nc_ohc=vNo9xE1VF1oQ7kNvgFbfZpy&_nc_zt=23&_nc_ht=scontent.ftgz2-1.fna&_nc_gid=AcLMmhJdh9MaoOrjwEU1WuH&oh=00_AYAwnf2Ca433O6PJL-F4VtXkzUEaRzi6ngH6DVSTJVeEjA&oe=671E106F',
      'postImage': 'https://i.ytimg.com/vi/M6_f2eRbqk0/hqdefault.jpg',
      'title': 'Concierto en Chiapas',
      'description': 'Concierto en Chiapas con artistas locales'
    },
{
      'username': 'Luis Batalla',
      'userhandle': '@LuisB',
      'profileImage': 'https://i.kym-cdn.com/photos/images/facebook/002/295/694/056.jpg',
      'postImage': 'https://th.bing.com/th/id/R.bd024224d3c4e6c37f013f2d308b5af7?rik=piNXOCvYZrOrQA&pid=ImgRaw&r=0',
      'title': 'Concierto en Chiapas',
      'description': 'Concierto en Chiapas con artistas locales'
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KENSTUDIO'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabecera del post (perfil)
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(post['profileImage']!),
                        radius: 25,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['username']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(post['userhandle']!,
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Imagen del post
                  Image.network(
                    post['postImage']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  SizedBox(height: 10),
                  // Título del post
                  Text(
                    post['title']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  // Descripción del post
                  Text(post['description']!,
                      style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 10),
                  // Botones de "Me gusta", "Compartir"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          // Lógica para "Me gusta"
                        },
                        icon: Icon(Icons.favorite_border, color: Colors.red),
                        label: Text('Me gusta',
                            style: TextStyle(color: Colors.red)),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Lógica para compartir
                        },
                        icon: Icon(Icons.share, color: Colors.grey),
                        label: Text('Compartir', style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: 1, // Índice seleccionado (Inicio)
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
        onTap: (index) {
          // Lógica para cambiar entre pantallas
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/profile'); // Navegar a la pantalla de perfil
              break;
            case 1:
              // Estamos en la pantalla de inicio, no hacer nada
              break;
            case 2:
              Navigator.pushNamed(context, '/notifications'); // Navegar a la pantalla de notificaciones
              break;
          }
        },
      ),
    );
  }
}
