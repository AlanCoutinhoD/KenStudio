import 'package:flutter/material.dart';

// Aquí puedes incluir el modelo de usuario si no está en otro archivo
class UserProfile {
  String username;
  String userhandle;
  String profileImage;
  String title;
  String biography;
  int numeroDePost;
  int seguidores;
  int seguidos;
  String ubicacion;
  String correo;
  String numeroDeTelefono;
  String pagina;

  UserProfile({
    required this.username,
    required this.userhandle,
    required this.profileImage,
    required this.title,
    required this.biography,
    required this.numeroDePost,
    required this.seguidores,
    required this.seguidos,
    required this.ubicacion,
    required this.correo,
    required this.numeroDeTelefono,
    required this.pagina,
  });
}

class UserProfileScreen extends StatelessWidget {
  // Datos de usuario desde el JSON
  final UserProfile userProfile = UserProfile(
    username: 'Noe Alejandro',
    userhandle: '@Noeon',
    profileImage: 'https://yt3.googleusercontent.com/LSzYgCI1omHqqJ_kwGclTsZ68_jstIUpJNMjL64D0pD8vJrNEmXz5QFfC05zn5PHe4UGhKpyKw=s900-c-k-c0x00ffffff-no-rj',
    title: 'Evento de 15 años',
    biography: 'Sigueme en trovo SoyNoeon!',
    numeroDePost: 120,
    seguidores: 1500,
    seguidos: 300,
    ubicacion: 'Ciudad de México, México',
    correo: 'noe.alejandro@example.com',
    numeroDeTelefono: '+52 55 1234 5678',
    pagina: 'https://www.ejemplo.com',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Encabezado con información del perfil sin la línea roja arriba
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.red,
                    backgroundImage: NetworkImage(userProfile.profileImage), // Imagen de perfil
                  ),
                  SizedBox(height: 10),
                  Text(
                    userProfile.username,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    userProfile.userhandle,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            // Sección de estadísticas (Posts, Seguidores, Siguiendo)
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        userProfile.numeroDePost.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Posts'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        userProfile.seguidores.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Seguidores'),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        userProfile.seguidos.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Siguiendo'),
                    ],
                  ),
                ],
              ),
            ),
            // Información adicional del usuario
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    userProfile.biography,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.red),
                      SizedBox(width: 5),
                      Text(userProfile.ubicacion),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.link, color: Colors.red),
                      SizedBox(width: 5),
                      Text(
                        userProfile.pagina,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Colors.red),
                      SizedBox(width: 5),
                      Text(userProfile.correo),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Colors.red),
                      SizedBox(width: 5),
                      Text(userProfile.numeroDeTelefono),
                    ],
                  ),
                ],
              ),
            ),
            // Botones de seguir y mensaje
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text('Seguir'),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Text('Mensaje'),
                  ),
                ],
              ),
            ),
            // Lista de publicaciones
            ...List.generate(3, (index) {
              return PostCard(
                username: userProfile.username,
                userhandle: userProfile.userhandle,
                profileImage: userProfile.profileImage,
                postImage: 'https://th.bing.com/th/id/R.c0a730b85da26a404a60d3da4289dfd3?rik=NgSa4X6OQKG1bA&riu=http%3a%2f%2fpm1.narvii.com%2f7807%2f73059d227c8c1f5ff28bb0e27406cf02c72de741r1-451-680v2_uhq.jpg&ehk=YD%2fdRTlhVfMpwDuZEtPmWnvNsirCj9%2fDKtueQ4NEg%2bM%3d&risl=&pid=ImgRaw&r=0',
                title: 'Evento de 15 años',
                description: 'Evento de 15 años en Tuxtla Gutiérrez en el salón Las Lomas',
              );
            }),
          ],
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String username;
  final String userhandle;
  final String profileImage;
  final String postImage;
  final String title;
  final String description;

  PostCard({
    required this.username,
    required this.userhandle,
    required this.profileImage,
    required this.postImage,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImage),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(userhandle, style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Image.network(postImage),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(description, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.favorite_border, color: Colors.red),
                    SizedBox(width: 5),
                    Text('Me gusta', style: TextStyle(color: Colors.red)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.share, color: Colors.grey),
                    SizedBox(width: 5),
                    Text('Compartir', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
