import 'package:flutter/material.dart';
import 'screens/welcome.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/buscador.dart';
import 'screens/subirPublicacion.dart';
import 'screens/home.dart';
import 'screens/videos.dart';
import 'screens/userProfile.dart';


void main() async {
  // Asegúrate de que WidgetsBinding esté inicializado antes de llamar a Firebase.initializeApp()
  WidgetsFlutterBinding.ensureInitialized();

  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KenStudio',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Definir las rutas de la aplicación
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),  
        '/login': (context) => LoginScreen(), 
        '/registro': (context) => RegisterScreen(),
        '/buscador': (context) => BuscadorScreen(),
        '/subirPublicacion': (context) => SubirScreen(),  // Asegúrate de que esta pantalla esté importada correctamente
        '/home': (context) => HomeScreen(),
        '/videos': (context) => VideoFeedScreen(),
        '/userProfile': (context) => UserProfileScreen()
      },
    );
  }
}
