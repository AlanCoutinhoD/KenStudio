// screens/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> posts = [
    {
      'username': 'Noe Alejandro',
      'userhandle': '@Noeon',
      'profileImage': 'https://yt3.googleusercontent.com/LSzYgCI1omHqqJ_kwGclTsZ68_jstIUpJNMjL64D0pD8vJrNEmXz5QFfC05zn5PHe4UGhKpyKw=s900-c-k-c0x00ffffff-no-rj',
      'postImage': 'https://th.bing.com/th/id/R.c0a730b85da26a404a60d3da4289dfd3?rik=NgSa4X6OQKG1bA&riu=http%3a%2f%2fpm1.narvii.com%2f7807%2f73059d227c8c1f5ff28bb0e27406cf02c72de741r1-451-680v2_uhq.jpg&ehk=YD%2fdRTlhVfMpwDuZEtPmWnvNsirCj9%2fDKtueQ4NEg%2bM%3d&risl=&pid=ImgRaw&r=0',
      'title': 'Evento de 15 años',
      'description': 'Evento de 15 años en Tuxtla Gutiérrez en el salón Las Lomas'
    },
    {
      'username': 'Luis Batalla',
      'userhandle': '@LuisB',
      'profileImage': 'https://scontent.ftgz2-1.fna.fbcdn.net/v/t39.30808-6/361609173_290338383516902_148942040969675955_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeGiqzfyU-sYlnidhtQxNeiYB0AuegqO28sHQC56Co7byxadzn9MZs06SzWLAtXT6lLUj0OpHfrh_g61sDnZeKEr&_nc_ohc=vNo9xE1VF1oQ7kNvgFbfZpy&_nc_zt=23&_nc_ht=scontent.ftgz2-1.fna&_nc_gid=AcLMmhJdh9MaoOrjwEU1WuH&oh=00_AYAwnf2Ca433O6PJL-F4VtXkzUEaRzi6ngH6DVSTJVeEjA&oe=671E106F',
      'postImage': 'https://i.ytimg.com/vi/M6_f2eRbqk0/hqdefault.jpg',
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
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/userProfile',
                            arguments: {
                              'username': post['username'],
                              'userhandle': post['userhandle'],
                              'profileImage': post['profileImage'],
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(post['profileImage']!),
                          radius: 25,
                        ),
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
                  Image.network(
                    post['postImage']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                  SizedBox(height: 10),
                  Text(
                    post['title']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(post['description']!,
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Amigos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box, color: Colors.red, size: 40),
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
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/friends');
              break;
            case 2:
              // Acción para el botón central
              Navigator.pushNamed(context, '/subirPublicacion');
              break;
            case 3:
              Navigator.pushNamed(context, '/videos');
              break;
            case 4:
              Navigator.pushNamed(context, '/userProfile');
              break;
          }
        },
      ),
    );
  }
}
