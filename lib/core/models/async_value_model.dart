class AsyncValueModel<T> {
  final bool isLoading;
  final T value;
  final Object? error;

  AsyncValueModel({
    required this.isLoading,
    required this.value,
    required this.error,
  });

  factory AsyncValueModel.initial(T value) => AsyncValueModel(
        isLoading: false,
        value: value,
        error: null,
      );

  AsyncValueModel<T> loading() => AsyncValueModel(
        isLoading: true,
        value: value,
        error: error,
      );

  Future<AsyncValueModel<T>> guard(Future<T> Function() callback) async {
    try {
      return AsyncValueModel(
        isLoading: false,
        value: await callback(),
        error: null,
      );
    } catch (e) {
      return AsyncValueModel(
        isLoading: false,
        value: this.value,
        error: e,
      );
    }
  }

  AsyncValueModel<T> data(T data) {
    return AsyncValueModel(isLoading: false, value: data, error: null);
  }

  bool get hasError => error != null;
}
