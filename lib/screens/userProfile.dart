import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

class UserProfileScreen extends StatefulWidget {
  final String userId; // Recibimos el id_cliente como parámetro

  UserProfileScreen({required this.userId});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late UserProfile userProfile;
  bool isLoading = true;

  final TextEditingController _reviewController = TextEditingController();
  int _rating = 5;

  final List<Map<String, dynamic>> exampleReviews = [
    {'reviewer': 'Carlos', 'rating': 4, 'comment': 'Muy buen perfil y contenido.'},
    {'reviewer': 'Ana', 'rating': 5, 'comment': 'Excelente experiencia con este usuario.'},
    {'reviewer': 'Luis', 'rating': 3, 'comment': 'Interesante, pero hay espacio para mejorar.'},
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserProfile(); // Llamamos la API con el ID del usuario recibido
  }

  // Método para obtener el perfil del usuario
  Future<void> _fetchUserProfile() async {
    final url = Uri.parse('https://f6b472jh-3006.usw3.devtunnels.ms/api/v1/clientes/${widget.userId}');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        userProfile = UserProfile.fromJson(json.decode(response.body));
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load user profile');
    }
  }

  void _submitReview() {
    if (_reviewController.text.isNotEmpty) {
      setState(() {
        exampleReviews.add({
          'reviewer': 'Tú',
          'rating': _rating,
          'comment': _reviewController.text,
        });
        _reviewController.clear();
        _rating = 5;
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
                  // Pestaña de Publicaciones
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
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
                              Text(
                                userProfile.username,
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(userProfile.userhandle, style: TextStyle(fontSize: 16, color: Colors.grey)),
                            ],
                          ),
                        ),
                        // Información adicional del usuario
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 2, blurRadius: 5, offset: Offset(0, 3)),
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
                        // Estadísticas del usuario
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(vertical: 10),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildStatColumn(userProfile.numeroDePost, 'Posts', Icons.post_add),
                              _buildRatingColumn(4, 5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Pestaña de Reseñas
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título de las reseñas
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Reseñas',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        // Lista de reseñas de ejemplo
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(), // Evita conflictos con el Scroll principal
                          shrinkWrap: true,
                          itemCount: exampleReviews.length,
                          itemBuilder: (context, index) {
                            final review = exampleReviews[index];
                            return ListTile(
                              leading: Icon(Icons.star, color: Colors.orange),
                              title: Text(review['reviewer']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(review['comment']),
                                  SizedBox(height: 5),
                                  Row(
                                    children: List.generate(5, (i) {
                                      return Icon(
                                        i < review['rating'] ? Icons.star : Icons.star_border,
                                        color: Colors.orange,
                                        size: 20,
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        Divider(),
                        // Formulario para agregar nueva reseña
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deja tu reseña',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              TextField(
                                controller: _reviewController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Escribe tu comentario',
                                ),
                                maxLines: 3,
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    'Calificación:',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 10),
                                  DropdownButton<int>(
                                    value: _rating,
                                    onChanged: (value) {
                                      setState(() {
                                        _rating = value!;
                                      });
                                    },
                                    items: List.generate(5, (i) {
                                      return DropdownMenuItem(
                                        value: i + 1,
                                        child: Text('${i + 1} Estrellas'),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: _submitReview,
                                child: Text('Enviar Reseña'),
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

  Widget _buildUserInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text('$label ', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildStatColumn(int count, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 30),
        SizedBox(height: 5),
        Text('$count', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }

  Widget _buildRatingColumn(double rating, double maxRating) {
    return Column(
      children: [
        Icon(Icons.star, size: 30, color: Colors.orange),
        SizedBox(height: 5),
        Text('${rating.toStringAsFixed(1)} / $maxRating', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
