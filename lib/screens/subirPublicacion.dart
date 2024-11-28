import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';  // Importa SharedPreferences

class SubirScreen extends StatefulWidget {
  @override
  _SubirScreenState createState() => _SubirScreenState();
}

class _SubirScreenState extends State<SubirScreen> {
  File? _image;
  final picker = ImagePicker();
  final _titleController = TextEditingController();
  final _infoController = TextEditingController();

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

  // Función para obtener el ID de usuario guardado en SharedPreferences
  Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');  // Obtener el ID del usuario
  }

  // Función para subir la imagen a Imgur
  Future<void> _uploadImage() async {
    if (_image == null) return;

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
        print('Imagen subida exitosamente: $imageUrl'); // Imprime la URL en la consola

        // Ahora obtenemos el userId desde SharedPreferences
        String? userId = await _getUserId(); // Recupera el userId guardado

        if (userId != null) {
          // Subir la publicación utilizando el userId y la URL de la imagen
          _publishPost(userId, imageUrl); 
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: No se encontró el ID del usuario')));
        }
      } else {
        print('Error al subir la imagen: ${response.reasonPhrase}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al subir la imagen')));
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al subir la imagen: $e')));
    }
  }

  // Función para publicar la publicación
  Future<void> _publishPost(String userId, String imageUrl) async {
    // URL con el user_id directamente
    String url = 'https://f6b472jh-3006.usw3.devtunnels.ms/api/v1/clientes/$userId/publicaciones';
    
    // Body de la publicación
    Map<String, dynamic> postData = {
      "titulo": _titleController.text,  // Usamos el título como descripción
      "descripcion": _infoController.text,  // Usamos la información como descripción
      "contenido": imageUrl,  // Usamos la URL de la imagen como contenido
    };
    
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(postData),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Publicación exitosa
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Publicación realizada con éxito')));
        Navigator.pop(context); // Regresar a la pantalla anterior (menú)
      } else {
        print('Error al crear la publicación: ${response.reasonPhrase}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al crear la publicación')));
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al crear la publicación')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir imagen'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Imagen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                              Text('Subir una imagen', style: TextStyle(color: Colors.red)),
                              Text('Selecciona la imagen'),
                              Text('PNG, JPG, GIF hasta 10MB'),
                            ],
                          ),
                        )
                      : Image.file(_image!, width: double.infinity, height: 200, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 20),
              Text('Título', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Introduce un título',
                ),
                maxLines: 1, // Limita a una línea.
              ),
              SizedBox(height: 20),
              Text('Descripción', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              TextField(
                controller: _infoController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Introduce una descripción',
                ),
                maxLines: null, // Permite múltiples líneas.
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_image != null && _titleController.text.isNotEmpty && _infoController.text.isNotEmpty) {
                      _uploadImage(); // Llamamos a la función para subir la imagen
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Completa todos los campos')));
                    }
                  },
                  child: Text('Subir imagen'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        currentIndex: 2,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Amigos'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box, color: Colors.red, size: 40), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.live_tv), label: 'Bandeja'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
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
              Navigator.pushNamed(context, '/upload');
              break;
            case 3:
              Navigator.pushNamed(context, '/videos');
              break;
            case 4:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
