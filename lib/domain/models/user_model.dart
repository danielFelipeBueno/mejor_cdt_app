
class User {
  final String id;
  final String email;
  final String name;
  final String country;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.country,
  });

  /// Crea una instancia de [User] desde un mapa JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
    );
  }

  /// Convierte una instancia de [User] a un mapa JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'country': country,
    };
  }

  /// Crea una copia de la instancia con campos opcionalmente actualizados
  User copyWith({
    String? id,
    String? email,
    String? name,
    String? country,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      country: country ?? this.country,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is User &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.country == country;
  }

  @override
  int get hashCode {
    return id.hashCode ^ email.hashCode ^ name.hashCode ^ country.hashCode;
  }
}
