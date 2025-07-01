class UserModel {
  String id;
  String name;
  String email;
  String profilePictureUrl;
  String dni;
  String phoneNumber;
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
      type: json['type'] as String,
      settings: List<String>.from(json['settings'] ?? []),
      createdAt: DateTime.parse(json['createdAt']as String),
      isVerified: json['isVerified'] as bool?,
    );
  }
}