class SendOTPModel {
  bool? success;
  String? message;
  Data? data;

  SendOTPModel({this.success, this.message, this.data});

  SendOTPModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['success'] = success;
    data['message'] = message;

    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }
}

class Data {
  String? verificationUid;
  String? channel;
  String? destination;
  String? whatsappDestination;
  String? purpose;
  int? expiresIn;
  bool? smsSent;
  bool? whatsappSent;
  bool? whatsappConfigured;
  String? whatsappTemplateName;
  String? whatsappTemplateLanguage;
  String? whatsappTemplateType;
  int? smsHttpCode;
  int? whatsappHttpCode;
  String? smsResponse;
  String? smsError;
  String? whatsappResponse;
  String? whatsappError;
  int? whatsappMetaErrorCode;
  String? whatsappMetaErrorType;
  String? whatsappMetaErrorMessage;
  String? whatsappMetaErrorDetails;

  Data({
    this.verificationUid,
    this.channel,
    this.destination,
    this.whatsappDestination,
    this.purpose,
    this.expiresIn,
    this.smsSent,
    this.whatsappSent,
    this.whatsappConfigured,
    this.whatsappTemplateName,
    this.whatsappTemplateLanguage,
    this.whatsappTemplateType,
    this.smsHttpCode,
    this.whatsappHttpCode,
    this.smsResponse,
    this.smsError,
    this.whatsappResponse,
    this.whatsappError,
    this.whatsappMetaErrorCode,
    this.whatsappMetaErrorType,
    this.whatsappMetaErrorMessage,
    this.whatsappMetaErrorDetails,
  });

  Data.fromJson(Map<String, dynamic> json) {
    verificationUid = json['verification_uid'];
    channel = json['channel'];
    destination = json['destination'];
    whatsappDestination = json['whatsapp_destination'];
    purpose = json['purpose'];
    expiresIn = json['expires_in'];
    smsSent = json['sms_sent'];
    whatsappSent = json['whatsapp_sent'];
    whatsappConfigured = json['whatsapp_configured'];
    whatsappTemplateName = json['whatsapp_template_name'];
    whatsappTemplateLanguage = json['whatsapp_template_language'];
    whatsappTemplateType = json['whatsapp_template_type'];
    smsHttpCode = json['sms_http_code'];
    whatsappHttpCode = json['whatsapp_http_code'];
    smsResponse = json['sms_response'];
    smsError = json['sms_error'];
    whatsappResponse = json['whatsapp_response'];
    whatsappError = json['whatsapp_error'];
    whatsappMetaErrorCode = json['whatsapp_meta_error_code'];
    whatsappMetaErrorType = json['whatsapp_meta_error_type'];
    whatsappMetaErrorMessage = json['whatsapp_meta_error_message'];
    whatsappMetaErrorDetails = json['whatsapp_meta_error_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['verification_uid'] = verificationUid;
    data['channel'] = channel;
    data['destination'] = destination;
    data['whatsapp_destination'] = whatsappDestination;
    data['purpose'] = purpose;
    data['expires_in'] = expiresIn;
    data['sms_sent'] = smsSent;
    data['whatsapp_sent'] = whatsappSent;
    data['whatsapp_configured'] = whatsappConfigured;
    data['whatsapp_template_name'] = whatsappTemplateName;
    data['whatsapp_template_language'] = whatsappTemplateLanguage;
    data['whatsapp_template_type'] = whatsappTemplateType;
    data['sms_http_code'] = smsHttpCode;
    data['whatsapp_http_code'] = whatsappHttpCode;
    data['sms_response'] = smsResponse;
    data['sms_error'] = smsError;
    data['whatsapp_response'] = whatsappResponse;
    data['whatsapp_error'] = whatsappError;
    data['whatsapp_meta_error_code'] = whatsappMetaErrorCode;
    data['whatsapp_meta_error_type'] = whatsappMetaErrorType;
    data['whatsapp_meta_error_message'] = whatsappMetaErrorMessage;
    data['whatsapp_meta_error_details'] = whatsappMetaErrorDetails;

    return data;
  }
}
