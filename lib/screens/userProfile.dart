import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Encabezado
          Container(
            color: Colors.red,
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: Text(
                'Perfil de Usuario',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          
          // Foto de perfil y nombre
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 50,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Juan Doe',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            '@juandoe',
            style: TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 10),

          // Estadísticas de perfil
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildProfileStat('150', 'Posts'),
              _buildProfileStat('10k', 'Seguidores'),
              _buildProfileStat('500', 'Siguiendo'),
            ],
          ),
          SizedBox(height: 20),

          // Descripción del perfil
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'Fotógrafo profesional 📸 | Amante de los viajes ✈️ | Foodie 🍕 '
              'Capturando momentos y sabores alrededor del mundo. '
              'Sígueme para ver mis aventuras diarias.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: 20),

          // Información de contacto
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              children: [
                _buildContactInfo(Icons.location_on, 'Madrid, España'),
                _buildContactInfo(Icons.link, 'www.juandoe.com'),
                _buildContactInfo(Icons.email, 'juan.doe@email.com'),
                _buildContactInfo(Icons.phone, '+34 123 456 789'),
              ],
            ),
          ),
          Spacer(),

          // Botones de acción
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text('Seguir'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red, side: BorderSide(color: Colors.red),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: Text('Mensaje'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileStat(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(IconData icon, String info) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.red,
          ),
          SizedBox(width: 10),
          Text(
            info,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
