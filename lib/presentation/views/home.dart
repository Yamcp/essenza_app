import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart'; // Agrega esta línea

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
        backgroundColor: Color(0xFFF5E6FF),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Cerrar sesión'),
              onTap: () {
                authController.logout();
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: Color(0xFFF5E6FF),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x1A000000),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Calendario
                    TableCalendar(
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: DateTime.now(),
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
                          color: Color(0xFFB794F6),
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: Color(0xFF553C9A),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Color(0xFFB794F6),
        indicatorColor: Color(0x8F8F8F8F),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.book, color: Colors.white),
            label: 'Journal',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings, color: Colors.white),
            label: 'Ajustes',
          ),
        ],
        selectedIndex: 0,
        onDestinationSelected: (int index) {
          // Aquí puedes manejar la navegación entre pantallas
        },
      ),
    );
  }
}