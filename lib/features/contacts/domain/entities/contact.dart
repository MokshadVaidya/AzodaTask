import 'dart:convert';

class Contact {
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  Contact({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  Contact copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
  }) {
    return Contact(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      address: map['address'] ?? '',
    );
  }


  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Contact(name: $name, email: $email, phoneNumber: $phoneNumber, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Contact &&
      other.name == name &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      address.hashCode;
  }
}
