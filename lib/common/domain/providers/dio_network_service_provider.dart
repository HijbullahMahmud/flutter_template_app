

import 'package:clean_arch_with_riverpod/common/data/remote/dio_network_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'dio_network_service_provider.g.dart';

@riverpod
DioNetworkService networkService (Ref ref) {
  final dio = Dio();
  return DioNetworkService(dio);
}