import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/bloc/controllers/daily_phrase_controller.dart';
import '/presentation/widgets/daily_phrase_widget.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final DailyPhraseController dailyPhraseController = DailyPhraseController();
  int _currentIndex = 0;
  int? selectedMood;
  final List<String> moods = ['😔', '😟', '😐', '🙂', '😄'];
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  void _showCustomMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.2),
      isScrollControlled: false,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFEFFFF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.people, color: Colors.black87),
                title: const Text('Perfil', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  Get.back();
                  Get.toNamed('/profile');
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.black87),
                title: const Text('Cerrar sesión', style: TextStyle(fontWeight: FontWeight.w600)),
                onTap: () {
                  Get.back();
                  // Aquí deberíás llamar a tu authController.logout();
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Días de la semana
    List<DateTime> weekDays = List.generate(7, (i) {
      return focusedDay.subtract(Duration(days: focusedDay.weekday - 1 - i));
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF3ECE7),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Barra superior con ícono de menú a la IZQUIERDA
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, size: 28, color: Color(0xFF1E1F21)),
                      onPressed: () => _showCustomMenu(context),
                    ),
                  ],
                ),
                // Header días semana
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: weekDays.map((date) {
                    final isToday = date.day == DateTime.now().day &&
                        date.month == DateTime.now().month &&
                        date.year == DateTime.now().year;
                    final isSelected = selectedDay != null &&
                        date.day == selectedDay!.day &&
                        date.month == selectedDay!.month &&
                        date.year == selectedDay!.year;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDay = date;
                          focusedDay = date;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        decoration: BoxDecoration(
                          color: isToday
                              ? const Color(0xFF9F7A7A)
                              : isSelected
                                  ? const Color(0xFF1E1F21)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Text(
                              ['Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa', 'Su'][date.weekday - 1],
                              style: TextStyle(
                                fontSize: 12,
                                color: isToday || isSelected
                                    ? Colors.white
                                    : Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${date.day}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isToday || isSelected
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 28),
                // Morning/Evening reflection cards (puedes adaptar esto como gustes)
                Row(
                  children: [
                    Expanded(
                      child: _HomeCard(
                        icon: Icons.wb_sunny_outlined,
                        label: "Morning\nreflection",
                        subtitle: "Start your perfect day",
                        onTap: () {},
                        bgColor: Colors.white,
                        iconColor: Colors.orange[400]!,
                        isYellow: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _HomeCard(
                        icon: Icons.nightlight_round,
                        label: "Evening\nreflection",
                        subtitle: "Assess your day",
                        onTap: () {},
                        bgColor: Colors.white,
                        iconColor: Colors.blueGrey[700]!,
                        isYellow: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),

                /// AQUÍ --- FRASE DEL DÍA SEGÚN MVC ---
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: DailyPhraseWidget(controller: dailyPhraseController),
                ),
                // -------------------------------------

                const SizedBox(height: 14),
                // Selector de emociones
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x16000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.wb_sunny, color: Colors.orange, size: 32),
                      const SizedBox(height: 6),
                      const Text(
                        "¿Cómo te sientes hoy?",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(moods.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedMood = index;
                              });
                            },
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: selectedMood == index
                                  ? Colors.orange[300]
                                  : Colors.grey[200],
                              child: Text(
                                moods[index],
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 8),
                      if (selectedMood != null)
                        Text(
                          "You selected: ${moods[selectedMood!]}",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF9F7A7A),
        indicatorColor: const Color(0xFFE5DFD9),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home, color: Color(0xFF1E1F21)),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.home, color: Color(0xFF1E1F21)),
            label: 'Frases',
          ),
      
          NavigationDestination(
            icon: Icon(Icons.menu_book, color: Color(0xFF1E1F21)),
            label: 'Journal',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings, color: Color(0xFF1E1F21)),
            label: 'Ajustes',
          ),
        ],
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
          // Implementa la navegación real a otras vistas aquí si las tienes
        },
      ),
    );
  }
}

/// Tu widget auxiliar para las tarjetas (puede estar aquí o en otro archivo)
class _HomeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;
  final Color bgColor;
  final Color iconColor;
  final bool isYellow;

  const _HomeCard({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.bgColor,
    required this.iconColor,
    this.subtitle,
    this.isYellow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: iconColor, size: 32),
              const SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  height: 1.1,
                ),
              ),
              if (subtitle != null) ...[
                SizedBox(height: 7),
                Text(
                  subtitle!,
                  style: TextStyle(
                      color: Colors.grey[600], fontSize: 13, height: 1.15),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}