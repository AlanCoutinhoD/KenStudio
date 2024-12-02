import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
                  // Pestaña de Publicaciones (vacía por ahora)
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Información del Usuario
                        _buildProfileInfo(),
                        // Estadísticas del Usuario
                        _buildStats(),
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
        // DropdownButton<int>(
        //   value: _rating,
        //   onChanged: (value) => setState(() => _rating = value!),
        //   items: List.generate(5, (i) => DropdownMenuItem(value: i + 1, child: Text('${i + 1} Estrellas'))),
        // ),
        SizedBox(height: 10),
        ElevatedButton(onPressed: _submitReview, child: Text('Enviar reseña')),
      ],
    );
  }
}

Future<String?> _getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}
