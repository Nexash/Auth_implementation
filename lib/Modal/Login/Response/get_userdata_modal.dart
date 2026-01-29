// User data response
class UserData {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String username;

  UserData({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.username,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      firstname: json['first_name'],
      lastname: json['last_name'],
      email: json['email'],
      username: json['username'],
    );
  }
}
