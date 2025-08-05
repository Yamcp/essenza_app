import 'package:flutter/material.dart';
import 'package:get/get.dart';
//controllers
import '../../../bloc/controllers/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileController profilecontroller = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    profilecontroller.getProfileUid();

    ever(profilecontroller.email, (value) => emailController.text = value);
    ever(profilecontroller.phone, (value) => phoneController.text = value);
    ever(profilecontroller.name, (value) => nameController.text = value);
    ever(profilecontroller.edad, (value) => edadController.text = value);
    ever(profilecontroller.sexo, (value) => sexoController.text = value);
    ever(profilecontroller.estadocivil, (value) => estadocivilController.text = value);
    ever(profilecontroller.ocupacion, (value) => ocupacionController.text = value);
    ever(profilecontroller.pais, (value) => paisController.text = value);
    ever(profilecontroller.ciudad, (value) => ciudadController.text = value);
    ever(profilecontroller.direccion, (value) => direccionController.text = value);
  }

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final edadController = TextEditingController();
  final sexoController = TextEditingController();
  final estadocivilController = TextEditingController();
  final ocupacionController = TextEditingController();
  final paisController = TextEditingController();
  final ciudadController = TextEditingController();
  final direccionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Color(0xFFB794F6),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF9F7AEA), // Morado muy claro
              Color(0xFFF5E6FF), // Rosa muy claro
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Editar Perfil',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    listaPerfil(
                      title: "Email: ${emailController.text}",
                      icon: Icons.mail,
                    ),
                    listaPerfil(
                      title: "Nombre: ${nameController.text}",
                      icon: Icons.person,
                    ),
                    FormField(
                      builder: (context) {
                        return TextField(
                          decoration: InputDecoration(labelText: "Nombre"),
                          controller: nameController,
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    listaPerfil(
                      title: "Teléfono: ${phoneController.text}",
                      icon: Icons.phone,
                    ),
                    FormField(
                      builder: (context) {
                        return TextField(
                          decoration: InputDecoration(labelText: "Teléfono"),
                          controller: phoneController,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                    
                    listaPerfil(
                      title: "Edad: ${edadController.text}",
                      icon: Icons.cake,
                    ),
                    FormField(
                      builder: (context) {
                        return TextField(
                          decoration: InputDecoration(labelText: "Edad"),
                          controller: edadController,
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    listaPerfil(
                      title: "Sexo: ${sexoController.text}",
                      icon: Icons.transgender,
                    ),
                    Row(
                      children: [
                      Checkbox(
                        value: sexoController.text == "Masculino",
                        onChanged: (bool? value) {
                        setState(() {
                          sexoController.text = value == true ? "Masculino" : "Femenino";
                        });
                        },
                      ),
                      const Text("Masculino"),
                      Checkbox(
                        value: sexoController.text == "Femenino",
                        onChanged: (bool? value) {
                        setState(() {
                          sexoController.text = value == true ? "Femenino" : "Masculino";
                        });
                        },
                      ),
                      const Text("Femenino"),
                      ],
                    ),
                    SizedBox(height: 20),

                    listaPerfil(
                      title: "Estado Civil: ${estadocivilController.text}",
                      icon: Icons.family_restroom,
                    ),
                    FormField(
                      builder: (context) {
                        return TextField(
                          decoration: InputDecoration(labelText: "Estado Civil"),
                          controller: estadocivilController,
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    listaPerfil(
                      title: "Ocupación: ${ocupacionController.text}",
                      icon: Icons.work,
                    ),
                    FormField(
                      builder: (context) {
                        return TextField(
                          decoration: InputDecoration(labelText: "Ocupación"),
                          controller: ocupacionController,
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    listaPerfil(
                      title: "País: ${paisController.text}",
                      icon: Icons.public,
                    ),                  
                    FormField(
                      builder: (context) {
                        return TextField(
                          decoration: InputDecoration(labelText: "País"),
                          controller: paisController,
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    listaPerfil(
                      title: "Ciudad: ${ciudadController.text}",
                      icon: Icons.location_city,
                    ),
                    FormField(
                      builder: (context) {
                        return TextField(
                          decoration: InputDecoration(labelText: "Ciudad"),
                          controller: ciudadController,
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    listaPerfil(
                      title: "Dirección: ${direccionController.text}",
                      icon: Icons.home,
                    ),
                    FormField(
                      builder: (context) {
                        return TextField(
                          decoration: InputDecoration(labelText: "Dirección"),
                          controller: direccionController,
                        );
                      },
                    ),
                    SizedBox(height: 20),
                                  
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        profilecontroller.updateProfile(
                          nameController.text,
                          phoneController.text,
                          edadController.text,
                          sexoController.text,
                          estadocivilController.text,
                          ocupacionController.text,
                          paisController.text,
                          ciudadController.text,
                          direccionController.text,
                        );
                      },
                      child: Text(
                        "Actualizar",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
    );
  }
}

class listaPerfil extends StatelessWidget {
  final String title;
  final IconData icon;

  const listaPerfil({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(leading: Icon(icon), title: Text(title));
  }
}
