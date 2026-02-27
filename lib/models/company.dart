class Company {
  final String name;
  final String catchPhrase;

  const Company({
    required this.name,
    required this.catchPhrase,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: (json['name'] ?? '') as String,
      catchPhrase: (json['catchPhrase'] ?? '') as String,
    );
  }
}