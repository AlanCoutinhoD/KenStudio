import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';  // Importa para usar gráficos
import 'package:intl/intl.dart';
// Modelo de Usuario
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

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      username: json['data']['username'],
      userhandle: '@${json['data']['username']}',
      profileImage: json['data']['foto_perfil'],
      title: json['data']['tipo_evento'],
      biography: 'Biografía de ${json['data']['username']}',
      numeroDePost: 120,
      seguidores: 1500,
      seguidos: 300,
      ubicacion: json['data']['ubicacion'],
      correo: 'correo@ejemplo.com',
      numeroDeTelefono: json['data']['telefono'],
      pagina: 'https://www.ejemplo.com',
    );
  }
}

// Modelo de Reseña
class Review {
  final String id;
  final String comentario;
  final int estrellas;
  final String? nombreUsuario;

  Review({
    required this.id,
    required this.comentario,
    required this.estrellas,
    this.nombreUsuario,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      comentario: json['comentario'],
      estrellas: json['estrellas'],
      nombreUsuario: json['nombre_usuario'],
    );
  }
}

// Pantalla del Perfil de Usuario
class UserProfileScreen extends StatefulWidget {
  final String userId;

  UserProfileScreen({required this.userId});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserProfile userProfile;
  List<Review> userReviews = [];
  bool isLoading = true;

  final TextEditingController _reviewController = TextEditingController();
  int _rating = 5;

  // Datos de ejemplo para las publicaciones y el forecast
  Map<DateTime, int> publicaciones = {
    DateTime(2024, 11, 28): 4,
    DateTime(2024, 11, 29): 0,
    DateTime(2024, 11, 30): 0,
    DateTime(2024, 12, 1): 3,
  };

  Map<DateTime, int> forecast = {
    DateTime(2024, 12, 2): 3,
    DateTime(2024, 12, 3): 1,
    DateTime(2024, 12, 4): 1,
    DateTime(2024, 12, 5): 2,
    DateTime(2024, 12, 6): 2,
    DateTime(2024, 12, 7): 2,
  };

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    final profileUrl = Uri.parse('https://f6b472jh-3006.usw3.devtunnels.ms/api/v1/clientes/${widget.userId}');
    final reviewsUrl = Uri.parse('https://f6b472jh-3006.usw3.devtunnels.ms/api/v1/usuarios/${widget.userId}/resenas');

    try {
      final profileResponse = await http.get(profileUrl);
      if (profileResponse.statusCode == 200) {
        userProfile = UserProfile.fromJson(json.decode(profileResponse.body));
      } else {
        throw Exception('Error al cargar el perfil');
      }

      final reviewsResponse = await http.get(reviewsUrl);
      if (reviewsResponse.statusCode == 200) {
        final List<dynamic> reviewsJson = json.decode(reviewsResponse.body)['data'];
        userReviews = reviewsJson.map((review) => Review.fromJson(review)).toList();
      } else {
        throw Exception('Error al cargar las reseñas');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isLoading ? "Cargando perfil..." : "Perfil de ${userProfile.username}"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Publicaciones"),
              Tab(text: "Reseñas"),
            ],
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  // Pestaña de Publicaciones (con gráfico de líneas)
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildProfileInfo(),
                        _buildStats(),
                        _buildLineChart(),  // Aquí se inserta el gráfico
                      ],
                    ),
                  ),
                  // Pestaña de Reseñas
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Reseñas',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: userReviews.length,
                          itemBuilder: (context, index) {
                            final review = userReviews[index];
                            return ListTile(
                              leading: Icon(Icons.star, color: Colors.orange),
                              title: Text(review.nombreUsuario ?? 'Anónimo'),
                              subtitle: Text(review.comentario),
                              trailing: Text('${review.estrellas}⭐'),
                            );
                          },
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _buildReviewInput(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }


Widget _buildLineChart() {
  // Convertir las fechas a FlSpot
  List<FlSpot> publicationSpots = publicaciones.entries
      .map((entry) => FlSpot(
          entry.key.millisecondsSinceEpoch.toDouble(), entry.value.toDouble()))
      .toList();

  List<FlSpot> forecastSpots = forecast.entries
      .map((entry) => FlSpot(
          entry.key.millisecondsSinceEpoch.toDouble(), entry.value.toDouble()))
      .toList();

  // Determinar el rango del eje Y
  final double minYValue = [
    ...publicationSpots.map((spot) => spot.y),
    ...forecastSpots.map((spot) => spot.y),
  ].reduce((a, b) => a < b ? a : b); // Valor mínimo del eje Y

  final double maxYValue = [
    ...publicationSpots.map((spot) => spot.y),
    ...forecastSpots.map((spot) => spot.y),
  ].reduce((a, b) => a > b ? a : b); // Valor máximo del eje Y

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      height: 300,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: publicationSpots,
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.lightBlueAccent],
              ),
              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.2),
                    Colors.lightBlueAccent.withOpacity(0.1),
                  ],
                ),
              ),
              dotData: FlDotData(show: false), // Ocultar los puntos
            ),
            LineChartBarData(
              spots: forecastSpots,
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.green, Colors.lightGreenAccent],
              ),
              barWidth: 4,
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.green.withOpacity(0.2),
                    Colors.lightGreenAccent.withOpacity(0.1),
                  ],
                ),
              ),
              dotData: FlDotData(show: false), // Ocultar los puntos
            ),
          ],
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.withOpacity(0.5),
              strokeWidth: 1,
            ),
            getDrawingVerticalLine: (value) => FlLine(
              color: Colors.grey.withOpacity(0.5),
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Ocultar los valores de la parte superior
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => Text(
                  '${value.toInt()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false), // Ocultar valores del lado derecho
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 24 * 60 * 60 * 1000, // Intervalo de un día en milisegundos
                getTitlesWidget: (value, meta) {
                  DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                  return Text(
                    DateFormat('dd MMM').format(date),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.black.withOpacity(0.3), width: 1),
          ),
          minX: publicaciones.keys.first.millisecondsSinceEpoch.toDouble(),
          maxX: forecast.keys.last.millisecondsSinceEpoch.toDouble(),
          minY: minYValue - 1, // Ajustar el margen inferior (1 unidad debajo del valor más bajo)
          maxY: maxYValue + 1, // Ajustar el margen superior (1 unidad arriba del valor más alto)
          lineTouchData: LineTouchData(
            enabled: false, // Deshabilitar interacción con el gráfico
          ),
        ),
      ),
    ),
  );
}


  // Información del perfil
  Widget _buildProfileInfo() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(userProfile.profileImage),
        ),
        SizedBox(height: 10),
        Text(userProfile.username, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(userProfile.userhandle, style: TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }

  // Estadísticas del usuario
  Widget _buildStats() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatColumn(userProfile.numeroDePost, 'Posts'),
          _buildStatColumn(userReviews.length, 'Reseñas'),
        ],
      ),
    );
  }

  Widget _buildStatColumn(int count, String label) {
    return Column(
      children: [
        Text('$count', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildReviewInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _reviewController,
          decoration: InputDecoration(labelText: 'Escribe tu comentario'),
        ),
        SizedBox(height: 10),
        ElevatedButton(onPressed: _submitReview, child: Text('Enviar reseña')),
      ],
    );
  }

  Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<void> _submitReview() async {
    String? userId1 = await _getUserId();
    String userId = userId1 ?? 'default_value';

    if (_reviewController.text.isNotEmpty) {
      final url = Uri.parse('https://f6b472jh-3006.usw3.devtunnels.ms/api/v1/usuarios/${widget.userId}/resenas');
      final body = json.encode({
        "id_cliente": widget.userId,
        "comentario": _reviewController.text,
      });

      try {
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: body,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          setState(() {
            userReviews.add(Review(
              id: DateTime.now().toString(),
              comentario: _reviewController.text,
              estrellas: _rating,
              nombreUsuario: "Tú",
            ));
            _reviewController.clear();
            _rating = 5;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Reseña enviada con éxito.')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al enviar la reseña. Inténtalo de nuevo.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error de red: $e')),
        );
      }
    }
  }
}
