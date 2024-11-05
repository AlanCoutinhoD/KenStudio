
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
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
            // Campo de texto para Correo Electrónico
            TextField(
              decoration: InputDecoration(
                labelText: 'Correo Electronico',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // Campo de texto para Contraseña
            TextField(
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
              onPressed: () {
                // Navega a la pantalla principal al iniciar sesión
                // Navigator.pushNamed(context, '/home');
                Navigator.pushNamed(context, '/home');
              },
              child: Text(
                'Iniciar Sesion',
                style: 
                
                TextStyle(fontSize: 18,color: const Color.fromARGB(255, 255, 255, 255)),
                
              ),
            ),
            SizedBox(height: 20),
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
