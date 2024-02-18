import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  // ProviderScope의 아래에 있는 모든 Provider가 업데이트 되었을때 호출
  @override
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    print('[Provider Updated] provider: $provider / pv: $previousValue / nv: $newValue');
  }

  // ProviderScope의 아래에 있는 모든 Provider가 추가되었을때 호출
  @override
  void didAddProvider(ProviderBase<Object?> provider, Object? value, ProviderContainer container) {
    print('[Provider Added] provider: $provider / value: $value ');
  }

  // ProviderScope의 아래에 있는 모든 Provider가 삭제되었을때 호출
  @override
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    print('[Provider Disposed] provider: $provider');
  }
}
