import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';  // Asegúrate de que fl_chart esté importado

// Modelo de perfil de usuario
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

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
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
    return DefaultTabController(
      length: 2, // Número de pestañas
      child: Scaffold(
        appBar: AppBar(
          title: Text("Perfil de ${userProfile.username}"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Publicaciones"),
              Tab(text: "Reseñas"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Pestaña de Publicaciones
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Información del usuario con diseño mejorado
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        // Imagen de perfil
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.red,
                          backgroundImage: NetworkImage(userProfile.profileImage),
                        ),
                        SizedBox(height: 10),
                        // Nombre y handle de usuario
                        Text(
                          userProfile.username,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          userProfile.userhandle,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Información adicional del usuario con bordes y estilo
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUserInfoRow('Biografía:', userProfile.biography),
                        _buildUserInfoRow('Ubicación:', userProfile.ubicacion),
                        _buildUserInfoRow('Correo:', userProfile.correo),
                        _buildUserInfoRow('Teléfono:', userProfile.numeroDeTelefono),
                        _buildUserInfoRow('Página web:', userProfile.pagina),
                      ],
                    ),
                  ),
                  // Estadísticas de usuario con iconos
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatColumn(userProfile.numeroDePost, 'Posts', Icons.post_add),
                        _buildRatingColumn(4, 5), // Calificación
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Publicaciones",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Lista de publicaciones
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5, // Número de publicaciones
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        elevation: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Información de la publicación
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(userProfile.profileImage),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userProfile.username,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      Text(userProfile.userhandle),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Imagen de la publicación
                            Image.network(
                              'https://th.bing.com/th/id/R.c0a730b85da26a404a60d3da4289dfd3?rik=NgSa4X6OQKG1bA&riu=http%3a%2f%2fpm1.narvii.com%2f7807%2f73059d227c8c1f5ff28bb0e27406cf02c72de741r1-451-680v2_uhq.jpg&ehk=YD%2fdRTlhVfMpwDuZEtPmWnvNsirCj9%2fDKtueQ4NEg%2bM%3d&risl=&pid=ImgRaw&r=0',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Título de la publicación",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Descripción de la publicación..."),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Pestaña de Reseñas
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Reseñas de los usuarios",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Gráfica de Reseñas de Usuarios
                  Container(
                    width: 300, // Tamaño ajustado de la gráfica
                    height: 250, // Altura ajustada de la gráfica
                    child: BarChart(
                      BarChartData(
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                return Text('${value.toInt() + 1}');  // Solo número, sin estrellas
                              },
                            ),
                          ),
                        ),
                        borderData: FlBorderData(show: true),
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 10, color: Colors.yellow)]),
                          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 20, color: Colors.yellow)]),
                          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 30, color: Colors.yellow)]),
                          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 40, color: Colors.yellow)]),
                          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 50, color: Colors.yellow)]),
                        ],
                      ),
                    ),
                  ),
                  // Reseñas de ejemplo debajo de la gráfica
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Usuario 1",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star_border, color: Colors.yellow),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text("Excelente servicio, muy recomendable."),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text(
                              "Usuario 2",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star_border, color: Colors.yellow),
                            Icon(Icons.star_border, color: Colors.yellow),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text("Buen servicio, pero puede mejorar."),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Text(
                              "Usuario 3",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star, color: Colors.yellow),
                            Icon(Icons.star_border, color: Colors.yellow),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text("Muy bueno, lo volvería a usar."),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para crear un row de información del usuario
  Widget _buildUserInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Text(
            "$title ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          Expanded(child: Text(value, style: TextStyle(color: Colors.black))),
        ],
      ),
    );
  }

  // Método para crear una columna de estadísticas
  Widget _buildStatColumn(int count, String label, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30, color: Colors.yellow),
        Text(
          "$count",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(label),
      ],
    );
  }

  // Método para crear una columna con calificación
  Widget _buildRatingColumn(int rating, int maxRating) {
    return Column(
      children: [
        Icon(Icons.star, size: 30, color: Colors.yellow),
        Text(
          "$rating/$maxRating",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text("Calificación"),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserProfileScreen(),
  ));
}
