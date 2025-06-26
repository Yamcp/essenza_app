import 'package:flutter/material.dart';
import 'package:get/get.dart';

//controllers
import '../../../bloc/controllers/auth_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        backgroundColor: Color(0xFFB794F6),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFFF5E6FF), // Rosa muy claro
        child: ListView(
          children: [                     
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                authController.logout(); // Cierra el drawer
                // Aquí puedes agregar la lógica para cerrar sesión
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFFF5E6FF), // Rosa muy claro
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              // Cambiado a Center para centrar el contenido dentro del Padding
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000), // 10% opaco
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize
                      .min, // Para que la columna tome sólo el espacio necesario
                  children: [
                    Text(
                      'Bienvenida a Essenza!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF553C9A), // Morado oscuro
                      ),
                      textAlign: TextAlign.center, // Centrar texto
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Tu journal bullet que te acompañará todos los días',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
