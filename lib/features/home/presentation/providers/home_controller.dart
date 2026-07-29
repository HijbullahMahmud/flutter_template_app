import 'package:ag_pos/core/types/result.dart';
import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:ag_pos/features/home/domain/usecases/get_template_features.dart';
import 'package:flutter/foundation.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeController extends ChangeNotifier {
  HomeController(this._getTemplateFeatures);

  final GetTemplateFeatures _getTemplateFeatures;

  HomeStatus _status = HomeStatus.initial;
  List<TemplateFeature> _features = const <TemplateFeature>[];
  String? _errorMessage;

  HomeStatus get status => _status;
  List<TemplateFeature> get features => _features;
  String? get errorMessage => _errorMessage;

  Future<void> load() async {
    _status = HomeStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _getTemplateFeatures();

    switch (result) {
      case Success<List<TemplateFeature>>(:final value):
        _features = value;
        _status = HomeStatus.success;
      case ResultFailure<List<TemplateFeature>>(:final failure):
        _status = HomeStatus.failure;
        _errorMessage = failure.message;
    }

    notifyListeners();
  }
}
