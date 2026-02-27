import 'address.dart';
import 'company.dart';

class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final Address address;
  final Company company;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.address,
    required this.company,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['id'] ?? 0) as int,
      name: (json['name'] ?? '') as String,
      username: (json['username'] ?? '') as String,
      email: (json['email'] ?? '') as String,
      phone: (json['phone'] ?? '') as String,
      website: (json['website'] ?? '') as String,
      address: Address.fromJson((json['address'] ?? {}) as Map<String, dynamic>),
      company: Company.fromJson((json['company'] ?? {}) as Map<String, dynamic>),
    );
  }
}