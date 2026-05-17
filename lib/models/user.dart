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
  final int userId = json['id'] ?? DateTime.now().millisecondsSinceEpoch;
  final imagePayload = json['image'] ?? '';
  final String verifiedAvatar = imagePayload.isNotEmpty
      ? imagePayload
      : 'https://robohash.org/$userId.png';

  return User(
    id: userId,
    email: json['email'] ?? '',
    first_Name: json['firstName'] ?? 'No Name',
    last_Name: json['lastName'] ?? 'No Name',
    avatar: verifiedAvatar,
  );
 }
}