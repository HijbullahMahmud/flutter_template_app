import 'package:ag_pos/features/home/domain/entities/template_feature.dart';
import 'package:ag_pos/features/home/domain/usecases/get_template_features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeRequested extends HomeEvent {
  const HomeRequested();
}

sealed class HomeState {
  const HomeState();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoadSuccess extends HomeState {
  const HomeLoadSuccess(this.features);

  final List<TemplateFeature> features;
}

final class HomeLoadFailure extends HomeState {
  const HomeLoadFailure(this.message);

  final String message;
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._getTemplateFeatures) : super(const HomeLoading()) {
    on<HomeRequested>(_onRequested);
  }

  final GetTemplateFeatures _getTemplateFeatures;

  Future<void> _onRequested(
    HomeRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    final result = await _getTemplateFeatures();
    result.fold(
      (failure) => emit(HomeLoadFailure(failure.message)),
      (features) => emit(HomeLoadSuccess(features)),
    );
  }
}
