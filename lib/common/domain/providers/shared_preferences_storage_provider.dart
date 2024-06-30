import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/local/shared_prefs_service.dart';
part 'shared_preferences_storage_provider.g.dart';

// final storageServiceProvider = Provider((ref){
//   final SharedPrefsService prefsService = SharedPrefsService();
//   prefsService.init();
//   return prefsService;
// });

@riverpod
SharedPrefsService storageService(Ref ref) {
  final SharedPrefsService prefsService = SharedPrefsService();
  prefsService.init();
  return prefsService;
}

 