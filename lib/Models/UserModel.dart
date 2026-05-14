// ignore_for_file: file_names

class UserModel {
  String uid;
  String email;
  String username;

  UserModel({required this.uid, required this.email, required this.username});

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'username': username};
  }
}
