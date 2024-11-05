import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _loginUser() async {
    final String nombre = _nombreController.text;
    final String password = _passwordController.text;
    final String url = 'http://10.0.2.2:3000/api/v1/usuarios?nombre=$nombre&password=$password'; // Cambia esto según tu configuración

    try {
      final response = await http.get(Uri.parse(url));

      // Imprimir el estado y cuerpo de la respuesta en la consola para depuración
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData["status"] == "encontrado") {
          // Navegar a la pantalla de inicio si el login es exitoso
          Navigator.pushNamed(context, '/home');
        } else {
          // Manejar error si el usuario no fue encontrado
          setState(() {
            _errorMessage = "Nombre o contraseña incorrectos.";
          });
        }
      } else {
        // Manejar un código de estado diferente a 200
        setState(() {
          _errorMessage = "Error en la conexión: ${response.reasonPhrase}";
        });
      }
    } catch (e) {
      // Captura cualquier excepción que ocurra durante la solicitud
      setState(() {
        _errorMessage = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',  // Ruta de la imagen del logo
              height: 150,               // Ajustar el tamaño si es necesario
            ),
            SizedBox(height: 20),
            Text(
              'KENSTUDIO',
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
            // Campo de texto para Nombre
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Correo Electronico',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Campo de texto para Contraseña
            TextField(
              controller: _passwordController,
              obscureText: true,  // Oculta el texto
              decoration: InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility),  // Icono para mostrar/ocultar la contraseña
              ),
            ),
            SizedBox(height: 20),
            // Botón de Iniciar Sesión
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Color rojo para el botón
                minimumSize: Size(double.infinity, 50), // Botón que ocupe todo el ancho
              ),
              onPressed: _loginUser,
              child: Text(
                'Iniciar Sesion',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            // Mostrar mensaje de error, si existe
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            // Enlace de Olvidaste tu contraseña
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/subirPublicacion');
              },
              child: Text(
                'Olvidaste tu contraseña?',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 10),
            // Enlace de Registrarme
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/registro');
              },
              child: Text(
                'Registrarme',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
