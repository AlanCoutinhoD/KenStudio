import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterClientScreen extends StatefulWidget {
  @override
  _RegisterClientScreenState createState() => _RegisterClientScreenState();
}

class _RegisterClientScreenState extends State<RegisterClientScreen> {
  File? _image;
  final picker = ImagePicker();
  final _generosController = TextEditingController();
  final _tipoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _nombreController = TextEditingController();
  final _passwordController = TextEditingController();
  final _tipoEventoController = TextEditingController();
  String _ubicacion = '';
  String _fotoPerfilUrl = '';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _obtenerUbicacion();
  }

  // Lógica para obtener la ubicación (esto puedes personalizarlo según tu lógica)
  Future<void> _obtenerUbicacion() async {
    _ubicacion = 'Copoya';  // Aquí puedes colocar la lógica para obtener la ubicación actual
  }

  // Función para seleccionar imagen de la galería
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Función para tomar foto con la cámara
  Future<void> _pickImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Función para subir la imagen a Imgur
  Future<String> _uploadImage() async {
    if (_image == null) {
      setState(() {
        _errorMessage = 'Por favor selecciona una foto.';
      });
      return '';
    }

    String clientId = 'fd6f28ce9d88390'; // Reemplaza con tu Client ID
    String url = "https://api.imgur.com/3/image";
    
    try {
      final request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers["Authorization"] = "Client-ID $clientId";
      request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonResponse = json.decode(responseData.body);
        String imageUrl = jsonResponse['data']['link']; // Obtiene la URL de la imagen
        print('Imagen subida exitosamente: $imageUrl'); // Imprime la URL de la imagen
        return imageUrl;
      } else {
        setState(() {
          _errorMessage = 'Error al subir la imagen: ${response.reasonPhrase}';
        });
        print('Error al subir la imagen: ${response.reasonPhrase}');
        return '';
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al subir la imagen: $e';
      });
      print('Error: $e');
      return '';
    }
  }

  // Función para registrar cliente
  Future<void> _registerClient() async {
    final String url = 'https://f6b472jh-3006.usw3.devtunnels.ms/api/v1/clientes';

    // Subimos la imagen y obtenemos la URL
    String fotoPerfilUrl = await _uploadImage();

    if (fotoPerfilUrl.isEmpty) {
      setState(() {
        _errorMessage = 'No se pudo subir la foto de perfil.';
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final String? idLead = prefs.getString('user_id');

    if (idLead == null) {
      setState(() {
        _errorMessage = 'Error: ID de usuario no encontrado.';
      });
      return;
    }

    // Crear el body del registro
    final Map<String, dynamic> body = {
      "id_lead": idLead,
      "generos": _generosController.text,
      "tipo": _tipoController.text,
      "telefono": _telefonoController.text,
      "nombre": _nombreController.text,
      "password": _passwordController.text,
      "ubicacion": _ubicacion,
      "tipo_evento": _tipoEventoController.text,
      "foto_perfil": fotoPerfilUrl,  // Usamos la URL de la imagen subida
    };

    // Imprimir el body en la consola
    print("Cuerpo del registro: ${json.encode(body)}");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _errorMessage = "Error en la conexión: ${response.reasonPhrase}";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Cliente'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen de perfil
              Text('Foto de perfil', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Center(
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.photo_library),
                                title: Text('Galería'),
                                onTap: () {
                                  _pickImageFromGallery();
                                  Navigator.of(context).pop();
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.photo_camera),
                                title: Text('Cámara'),
                                onTap: () {
                                  _pickImageFromCamera();
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: _image == null
                      ? Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image, size: 50, color: Colors.grey),
                              Text('Selecciona una imagen'),
                            ],
                          ),
                        )
                      : Image.file(_image!, width: double.infinity, height: 200, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _generosController,
                decoration: InputDecoration(
                  labelText: 'Géneros',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _tipoController,
                decoration: InputDecoration(
                  labelText: 'Tipo',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _telefonoController,
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _tipoEventoController,
                decoration: InputDecoration(
                  labelText: 'Tipo de evento',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerClient,
                child: Text('Registrar Cliente'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(_errorMessage, style: TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
