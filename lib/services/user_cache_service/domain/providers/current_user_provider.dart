import 'package:clean_arch_with_riverpod/services/user_cache_service/domain/providers/user_cache_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentUserProvider = FutureProvider((ref)async{
  final repository = ref.watch(userLocalRepositoryProvider);
  final eitherType =(await repository.fetchUser());
  return eitherType.fold((l) => null, (r) => r);
});