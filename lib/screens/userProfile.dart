import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';  // Importa el paquete de fl_chart

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

class UserProfileScreen extends StatelessWidget {
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
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.red,
                    backgroundImage: NetworkImage(userProfile.profileImage),
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
            // Agregar gráficas de actividad y calificaciones
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Gráfica de actividad reciente
                  Text("Actividad Reciente", style: TextStyle(fontWeight: FontWeight.bold)),
                  AspectRatio(
                    aspectRatio: 1.7,
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 15),
                              FlSpot(1, 30),
                              FlSpot(2, 25),
                              FlSpot(3, 35),
                              FlSpot(4, 30),
                              FlSpot(5, 40),
                            ],
                            isCurved: true,
                            dotData: FlDotData(show: true),
                            color: Colors.red, // Corregido: usar 'color' en lugar de 'colors'
                            barWidth: 2,
                          ),
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, _) {
                                const months = ["Ene", "Feb", "Mar", "Abr", "May", "Jun"];
                                return Text(months[value.toInt()]);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Gráfica de calificaciones
                  Text("Calificaciones de Usuarios", style: TextStyle(fontWeight: FontWeight.bold)),
                  AspectRatio(
                    aspectRatio: 1.3,
                    child: BarChart(
                      BarChartData(
                        barGroups: [
                          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 150, color: Colors.red)]),
                          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 100, color: Colors.red)]),
                          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 75, color: Colors.red)]),
                          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 50, color: Colors.red)]),
                          BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 25, color: Colors.red)]),
                        ],
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, _) => Text(value.toInt().toString()),
                            ),
                          ),
                        ),
                      ),
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
}
