class MasterPasswordModel {
  final String password;

  MasterPasswordModel({required this.password});

  MasterPasswordModel.fromJson(Map<String, dynamic> json)
      : this.password = json['password'];

  Map<String, dynamic> toJson() => {
        'password': this.password,
      };
}
