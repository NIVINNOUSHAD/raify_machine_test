class APIResponse {
  int statusCode;
  String message;
  dynamic data;
  String status;
  APIResponse({this.statusCode, this.status, this.message, this.data});

  APIResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message = json['message'];
    statusCode = json['status_code'];
    status = json['status'];
  }
}
