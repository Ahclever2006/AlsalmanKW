import 'dart:async';

typedef FutureCallback<T> = FutureOr<T> Function();
typedef FutureCallbackWithData<T, V> = FutureOr<T> Function(V data);
typedef FutureValueChanged<T> = FutureOr<void> Function(T);
typedef ValueChangedCustom<T, V> = FutureOr<V> Function(T);
typedef ValueChangedFilter<T, V> = FutureOr<void> Function(T, V);
