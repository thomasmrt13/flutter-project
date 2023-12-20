class Result<T> {
  Result.success(this.message) : success = true;
  Result.failure(this.message) : success = false;
  
  final bool success;
  final T message;
}
