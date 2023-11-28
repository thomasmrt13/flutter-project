class Result<T> {
  // ignore: avoid_positional_boolean_parameters
  Result(this.success, this.message);
  
  final bool success;
  final T message;
}
