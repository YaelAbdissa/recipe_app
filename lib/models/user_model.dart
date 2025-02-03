class UserModel {
  final String id;
  final String firstName;

  final String email;

  UserModel({
    required this.id,
    required this.firstName,
    required this.email,
  });

  factory UserModel.fromJson(dynamic jsonObject) {
    return UserModel(
      id: jsonObject.id,
      firstName: jsonObject['firstName'],
      email: jsonObject['email'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map = {
      "id": id,
      "firstName": firstName,
      "email": email,
    };
    return map;
  }
}
