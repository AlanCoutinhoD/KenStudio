import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';
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

  Map<DateTime, int> publicaciones = {};
  Map<DateTime, int> forecast = {};

  final TextEditingController _reviewController = TextEditingController();
  int _rating = 5;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
    _fetchPublicationsData();  // Cargar los datos de publicaciones
  }

  

  Future<void> _fetchUserProfile() async {
    final profileUrl = Uri.parse('https://f6b472jh-3006.usw3.devtunnels.ms/api/v1/clientes/${widget.userId}');
    final reviewsUrl = Uri.parse('https://f6b472jh-3006.usw3.devtunnels.ms/api/v1/usuarios/${widget.userId}/resenas');
    final forecastUrl = Uri.parse('https://f6b472jh-6000.usw3.devtunnels.ms/api/prediccion/7792516c-5f5b-46e1-8db1-921acdfb9fe0');
    try {
      final profileResponse = await http.get(profileUrl);
      final forecastResponse = await http.get(forecastUrl);
      if (profileResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
        userProfile = UserProfile.fromJson(json.decode(profileResponse.body));
        final data = json.decode(forecastResponse.body);
         // Procesar la cadena JSON dentro de 'datos' y 'forecast'
        final datosString = data['datos'];
        final forecastString = data['forecast'];
         // Parsear el string 'datos'
        final parsedDatos = _parseDatos(datosString);
        final parsedForecast = _parseDatos(forecastString);

        setState(() {
          publicaciones = parsedDatos;
          forecast = parsedForecast;
        });


        


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

  Future<void> _fetchPublicationsData() async {
    // Esta es la URL de predicciones. Reemplaza esto con la URL correcta.
    final forecastUrl = Uri.parse('https://f6b472jh-6000.usw3.devtunnels.ms/api/prediccion/7792516c-5f5b-46e1-8db1-921acdfb9fe0');
    
    try {
      final forecastResponse = await http.get(forecastUrl);
      if (forecastResponse.statusCode == 200) {
        final data = json.decode(forecastResponse.body);
        final datosString = data['datos'];
        final forecastString = data['forecast'];
        
        final parsedDatos = _parseDatos(datosString);
        final parsedForecast = _parseDatos(forecastString);

        setState(() {
          publicaciones = parsedDatos;
          forecast = parsedForecast;
        });
      } else {
        throw Exception('Error al cargar las predicciones');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  // Función para parsear la cadena que contiene Timestamps
  Map<DateTime, int> _parseDatos(String datosString) {
    final regex = RegExp(r"Timestamp\('(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})'\): (\d+)");
    final matches = regex.allMatches(datosString);

    final Map<DateTime, int> result = {};
    for (var match in matches) {
      final timestampStr = match.group(1)!;
      final value = int.parse(match.group(2)!);

      final date = DateTime.parse(timestampStr);
      result[date] = value;
    }

    return result;
  }

  // Función para enviar reseña
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
                  // Pestaña de Publicaciones (con la gráfica añadida)
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Información del Usuario
                        _buildProfileInfo(),
                        // Estadísticas del Usuario
                        _buildStats(),
                        // Gráfica de publicaciones
                        _buildLineChart(),
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
        SizedBox(height: 10),
        ElevatedButton(onPressed: _submitReview, child: Text('Enviar reseña')),
      ],
    );
  }

  // Gráfico de las publicaciones
   Widget _buildLineChart() {
  // Convertir las fechas a FlSpot y eliminar puntos fuera del rango permitido
  List<FlSpot> publicationSpots = publicaciones.entries
      .map((entry) => FlSpot(
            entry.key.millisecondsSinceEpoch.toDouble(),
            entry.value < 0 ? 0 : entry.value.toDouble(), // Limitar valores negativos a 0
          ))
      .where((spot) => spot.y <= 4) // Filtrar puntos fuera del rango permitido (por ejemplo, y > 4)
      .toList();

  List<FlSpot> forecastSpots = forecast.entries
      .map((entry) => FlSpot(
            entry.key.millisecondsSinceEpoch.toDouble(),
            entry.value.toDouble(),
          ))
      .where((spot) => spot.y <= 4) // Filtrar puntos fuera del rango permitido
      .toList();

  // Aseguramos que el valor mínimo del eje Y sea 0
  final double minY = 0;

  // Calcular el valor máximo del eje Y basado en los datos
  final double maxY = 4; // Valor máximo fijo (puedes cambiarlo si es necesario)

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        // Título de la gráfica
        Text(
          'ACTIVIDAD DE PUBLICACIONES',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8), // Espacio entre el título y la gráfica
        Container(
          height: 300,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: publicationSpots,
                  isCurved: false, // Sin curvatura
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
                  dotData: FlDotData(show: false),
                ),
                LineChartBarData(
                  spots: forecastSpots,
                  isCurved: false, // Sin curvatura
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
                  dotData: FlDotData(show: false),
                ),
              ],
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      // Mostrar solo valores enteros en el eje Y
                      if (value % 1 == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(value.toInt().toString()),
                        );
                      }
                      return SizedBox.shrink(); // Ocultar valores decimales
                    },
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false, // Ocultar los valores del lado derecho del eje Y
                  ),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false, // Ocultar valores en la parte superior
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(DateFormat('dd').format(date)),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: true),
              minY: minY, // Establecer el valor mínimo del eje Y en 0
              maxY: maxY, // Establecer el valor máximo del eje Y fijo
            ),
          ),
        ),
        SizedBox(height: 8), // Espacio entre la gráfica y las etiquetas
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.line_axis, color: Colors.blue),
                Text(
                  'Actividad Real',
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            Column(
              children: [
                Icon(Icons.line_axis, color: Colors.green),
                Text(
                  'Predicción de Actividad',
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8), // Espacio entre las etiquetas y la explicación de los ejes
        Text(
          'Eje Y: Cantidad de Publicaciones\nEje X: Días',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ],
    ),
  );
}
}

Future<String?> _getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}
