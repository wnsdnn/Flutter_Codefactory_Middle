import 'package:flutter_riverpod/flutter_riverpod.dart';

class Logger extends ProviderObserver {
  @override
  // Provider가 업데이트 됬을때 실행
  void didUpdateProvider(ProviderBase<Object?> provider, Object? previousValue,
      Object? newValue, ProviderContainer container) {
    // super.didUpdateProvider(provider, previousValue, newValue, container);
    print('[Provider Updated]: $provider / pv: $previousValue / nv: $newValue');
  }

  @override
  // Provider가 추가되었을때 실행
  void didAddProvider(ProviderBase<Object?> provider, Object? value, ProviderContainer container) {
    // super.didAddProvider(provider, value, container);
    print('[Provider Added]: $provider / value: $value');
  }

  @override
  // Provider가 삭제되었을때 실행
  void didDisposeProvider(ProviderBase<Object?> provider, ProviderContainer container) {
    // super.didDisposeProvider(provider, container);
    print('[Provider Disposed]: $provider');
  }
}
