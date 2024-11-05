import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  
  // Variable para manejar el mensaje de error
  String? _errorMessage;

  Future<void> _registerUser() async {
    final String url = 'http://10.0.2.2:3000/api/v1/usuarios';

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "nombre": _nombreController.text,
        "password": _passwordController.text,
        "telefono": _telefonoController.text,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      if (responseData["status"] == "success") {
        // Navegar a la pantalla principal si el registro es exitoso
        Navigator.pushNamed(context, '/home');
      } else {
        // Manejar error si el registro no es exitoso
        setState(() {
          _errorMessage = "Error al registrar el usuario: ${responseData["message"]}";
        });
      }
    } else {
      setState(() {
        _errorMessage = "Error en la conexión: ${response.reasonPhrase}";
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
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Campo de texto para Correo Electrónico
            TextField(
              controller: _telefonoController,
              decoration: InputDecoration(
                labelText: 'Teléfono',
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
            // Botón de Registro
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Color rojo para el botón
                minimumSize: Size(double.infinity, 50), // Botón que ocupe todo el ancho
              ),
              onPressed: () {
                _registerUser(); // Llama a la función para registrar el usuario
              },
              child: Text(
                'Registrarme',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            // Mensaje de error
            if (_errorMessage != null) ...[
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 10),
            ],
            // Enlace de Iniciar sesión
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text(
                'Iniciar sesión',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
