class ChangePasswordModel {
  final bool success;
  final String message;
  final Data data;

  ChangePasswordModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: Data.fromJson(Map<String, dynamic>.from(json['data'] ?? {})),
    );
  }
}

class Data {
  final int gurujiId;
  final bool passwordChanged;

  Data({required this.gurujiId, required this.passwordChanged});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      gurujiId: json['guruji_id'] ?? 0,
      passwordChanged: json['password_changed'] ?? false,
    );
  }
}
