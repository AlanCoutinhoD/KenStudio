import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart'; // Para obtener la ubicación
import 'package:geocoding/geocoding.dart'; // Para obtener la dirección

class BuscadorScreen extends StatefulWidget {
  @override
  _BuscadorScreenState createState() => _BuscadorScreenState();
}

class _BuscadorScreenState extends State<BuscadorScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];
  String _errorMessage = '';

  // Función para obtener la ubicación del usuario y convertirla a ciudad/estado
  Future<String> _getLocationAddress() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verificar si el servicio de ubicación está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Ubicación no disponible';
    }

    // Verificar los permisos de ubicación
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Permisos de ubicación denegados';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'Permisos de ubicación denegados permanentemente';
    }

    // Obtener la ubicación actual
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    // Usamos geocoding para convertir latitud y longitud a una dirección
    List<Placemark>? placemarks = await GeocodingPlatform.instance?.placemarkFromCoordinates(position.latitude, position.longitude);

    // Verificamos si placemarks no es nulo y tiene al menos un resultado
    if (placemarks != null && placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return place.locality ?? place.administrativeArea ?? 'Ubicación no disponible'; // Retorna la ciudad o estado
    } else {
      return 'Ubicación no disponible';
    }
  }

  // Función para realizar la búsqueda por texto
  Future<void> _searchProfiles() async {
    final String url = 'https://f6b472jh-3006.usw3.devtunnels.ms/api/v1/buscar';
    final Map<String, dynamic> body = {"texto": _searchController.text};

    try {
      print("Enviando solicitud a $url con body: $body");

      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print('Respuesta - Código de estado: ${response.statusCode}');
      print('Respuesta - Cuerpo: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status'] == 'encontrado') {
          setState(() {
            searchResults = data['data'];
          });
        } else {
          setState(() {
            _errorMessage = 'No se encontraron resultados';
            searchResults = [];
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Error en la conexión: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
      print("Error durante la búsqueda: $e");
    }
  }

  // Función para realizar la búsqueda por ubicación
  Future<void> _searchByLocation() async {
    String location = await _getLocationAddress(); // Obtener la dirección (ciudad/estado)

    // Si no se obtuvo la ubicación, mostramos un mensaje de error
    if (location == 'Ubicación no disponible' || location == 'Permisos de ubicación denegados' || location == 'Permisos de ubicación denegados permanentemente') {
      setState(() {
        _errorMessage = location;
        searchResults = [];
      });
      return;
    }

    final String url = 'https://f6b472jh-3006.usw3.devtunnels.ms/api/v1/clientes?ubicacion=$location'; // Agregamos la ubicación a la URL

    try {
      print("Enviando solicitud a $url");

      final response = await http.get(Uri.parse(url)); // Realizamos la solicitud GET

      print('Respuesta - Código de estado: ${response.statusCode}');
      print('Respuesta - Cuerpo: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        if (data['status'] == 'encontrado') {
          setState(() {
            searchResults = data['data']; // Actualizamos los resultados
          });
        } else {
          setState(() {
            _errorMessage = 'No se encontraron resultados';
            searchResults = [];
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Error en la conexión: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
      print("Error durante la búsqueda: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buscador de Perfiles', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.redAccent,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Barra de búsqueda
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Buscar perfiles...',
                        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        prefixIcon: Icon(Icons.search, color: Colors.redAccent),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _searchProfiles,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text('Buscar por texto', style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            // Nuevo botón para buscar por ubicación
            ElevatedButton(
              onPressed: _searchByLocation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Color diferente para este botón
                padding: EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('Buscar por ubicación', style: TextStyle(fontSize: 14)),
            ),
            SizedBox(height: 10),
            // Mensaje de error
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            // Lista de resultados de búsqueda
            Expanded(
              child: searchResults.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final profile = searchResults[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                            leading: ClipOval(
                              child: Image.network(
                                'https://www.kindpng.com/picc/m/24-248253_user-profile-default-image-png-clipart-png-download.png',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              profile['nombre'],
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Text(
                                  'Tipo: ${profile['tipo']}',
                                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                                ),
                                Text(
                                  'Tipo de evento: ${profile['tipo_evento']}',
                                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                                ),
                                Text(
                                  'Ubicación: ${profile['ubicacion']}',
                                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                                ),
                                Text(
                                  'Géneros: ${profile['generos']}',
                                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'No hay resultados para mostrar',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
