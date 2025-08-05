class UserModel {
  String id;
  String name;
  String email;
  String profilePictureUrl;
  String dni;
  String phoneNumber;
  String edad;
  String sexo;
  String estadocivil;
  String ocupacion;
  String pais;
  String ciudad;
  String direccion;
  String type;
  List<String> settings;
  DateTime createdAt;
  bool? isVerified;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl = '',
    this.dni = '',
    this.phoneNumber = '',
    this.edad = '',
    this.sexo = '',
    this.estadocivil = '',
    this.ocupacion = '',
    this.pais = '',
    this.ciudad = '',
    this.direccion = '',
    required this.type,
    required this.settings,
    required this.createdAt,
    this.isVerified,
  });

  //factory
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      profilePictureUrl: json['profilePictureUrl'] as String? ?? '',
      dni: json['dni'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      edad: json['edad'] as String? ?? '',
      sexo: json['sexo'] as String? ?? '',
      estadocivil: json['estadocivil'] as String? ?? '',
      ocupacion: json['ocupacion'] as String? ?? '',
      pais: json['pais'] as String? ?? '',
      ciudad: json['ciudad'] as String? ?? '',
      direccion: json['direccion'] as String? ?? '',
      type: json['type'] as String,
      settings: List<String>.from(json['settings'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isVerified: json['isVerified'] as bool?,
    );
  }
}