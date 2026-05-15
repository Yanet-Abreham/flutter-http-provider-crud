class User {
  final int id;
  final String email;
  final String first_Name;
  final String last_Name;
  final String avatar;
User({
  required this.id,
  required this.email,
  required this.first_Name,
  required this.last_Name,
  required this.avatar,
});

String get full_Name => '$first_Name $last_Name';
factory User.fromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] ?? 0,
    email: json['email'] ?? '',
    first_Name: json['firstName'] ?? json['first_Name'] ?? 'No Name',
    last_Name: json['lastName'] ?? json['last_Name'] ?? 'No Name',
    avatar: json['image'] ?? 'https://robohash.org/${json['id']}',
  );
 }
}