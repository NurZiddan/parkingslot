class User {
  final String username;
  final String email;
  final String password;
  final String? googleId;
  final bool isVerified;
  final String apiKey;

  User({
    required this.username,
    required this.email,
    required this.password,
    this.googleId,
    required this.isVerified,
    required this.apiKey,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      googleId: json['google_id'],
      isVerified: json['is_verified'],
      apiKey: json['api_key'],
    );
  }
}
