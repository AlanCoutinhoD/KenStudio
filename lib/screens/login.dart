import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';  // Importa SharedPreferences

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true; // Estado para controlar la visibilidad de la contraseña

  // Función para guardar el userId en SharedPreferences
  Future<void> _saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId); // Guardar el userId
    print('UserId guardado: $userId');
  }

  Future<void> _loginUser() async {
    final String nombre = _nombreController.text;
    final String password = _passwordController.text;
    final String url =
        'https://f6b472jh-3006.usw3.devtunnels.ms/api/v1/clientes?nombre=$nombre&password=$password';

    try {
      // Enviar solicitud GET
      final response = await http.get(Uri.parse(url));

      // Imprimir detalles para depuración
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // Comprobar si la respuesta contiene el campo 'status'
        if (responseData["status"] == "encontrado") {
          // Acceder al id del primer usuario en la lista 'data'
          final String userId = responseData['data'][0]['id'];
          print("User ID: $userId");

          // Guardar el userId en SharedPreferences
          await _saveUserId(userId);

          // Navegar al Home
          Navigator.pushNamed(context, '/home');
        } else {
          _showErrorDialog("Nombre o contraseña incorrectos.");
        }
      } else {
        // Manejo de errores en la solicitud
        _showErrorDialog("Error en la conexión: ${response.reasonPhrase}");
      }
    } catch (e) {
      // Captura de errores generales
      _showErrorDialog("Error: Verifique su conexión a internet o ingrese un nombre de usuario y contraseña correctos.");
      print("Error durante el login: $e");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error de Conexión"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cerrar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 150,
                ),
                SizedBox(height: 20),
                Text(
                  'KENSTUDIO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Discover music\naround the world',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  controller: _nombreController,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: _isPasswordHidden, // Cambia según el estado
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordHidden = !_isPasswordHidden; // Cambiar visibilidad
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: _loginUser,
                  child: Text(
                    'Iniciar Sesión',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Implementar funcionalidad de "Olvidaste tu contraseña" si es necesario
                  },
                  child: Text(
                    'Olvidaste tu contraseña?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/registro');
                  },
                  child: Text(
                    'Registrarme',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
