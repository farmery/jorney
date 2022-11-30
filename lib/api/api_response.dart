class ApiResponse<T> {
  ApiResponse({this.data, this.error});
  final T? data;
  final String? error;

  factory ApiResponse.success(T data) {
    return ApiResponse(data: data);
  }
  factory ApiResponse.error(String error) {
    return ApiResponse(error: error);
  }
}
