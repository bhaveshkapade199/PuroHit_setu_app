import 'package:equatable/equatable.dart';

abstract class YajamanRegisterEvent extends Equatable {
  const YajamanRegisterEvent();

  @override
  List<Object?> get props => [];
}

class YajamanRegisterSubmitEvent extends YajamanRegisterEvent {
  final String name;
  final String phone;
  final String whatsappNumber;
  final String email;
  final String address;
  final String city;
  final String pincode;
  final String password;

  const YajamanRegisterSubmitEvent({
    required this.name,
    required this.phone,
    required this.whatsappNumber,
    required this.email,
    required this.address,
    required this.city,
    required this.pincode,
    required this.password,
  });

  @override
  List<Object?> get props => [
    name,
    phone,
    whatsappNumber,
    email,
    address,
    city,
    pincode,
    password,
  ];
}

class YajamanWhatsappSameAsPhoneChangedEvent extends YajamanRegisterEvent {
  final bool isSame;

  const YajamanWhatsappSameAsPhoneChangedEvent(this.isSame);

  @override
  List<Object?> get props => [isSame];
}

class YajamanPasswordVisibilityEvent extends YajamanRegisterEvent {
  final bool isVisible;

  const YajamanPasswordVisibilityEvent(this.isVisible);

  @override
  List<Object?> get props => [isVisible];
}

class YajamanSendPhoneOtpEvent extends YajamanRegisterEvent {
  final String phone;

  const YajamanSendPhoneOtpEvent([this.phone = ""]);

  @override
  List<Object?> get props => [phone];
}

class YajamanVerifyPhoneOtpEvent extends YajamanRegisterEvent {
  final String otp;
  final String phone;

  const YajamanVerifyPhoneOtpEvent(this.otp, [this.phone = ""]);

  @override
  List<Object?> get props => [otp, phone];
}
