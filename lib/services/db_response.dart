class DbResponse<T> {
  DbResponse({this.data, this.error});
  final T? data;
  final String? error;

  factory DbResponse.success(T data) {
    return DbResponse(data: data);
  }
  factory DbResponse.error(String error) {
    return DbResponse(error: error);
  }
}
