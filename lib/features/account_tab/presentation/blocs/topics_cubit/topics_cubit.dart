import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/data/models/topic_model.dart';
import '../../../../auth/data/repositories/auth_repository.dart';

part 'topics_state.dart';

class TopicsCubit extends BaseCubit<TopicsState> {
  TopicsCubit(this._authRepository) : super(const TopicsState());

  final AuthRepository _authRepository;

  Future<void> getTopicsData(int id, [bool refresh = false]) async {
    final Topic? topicContent;
    try {
      if (!refresh) emit(state.copyWith(status: TopicsStateStatus.loading));

      topicContent = await _authRepository.getTopicsData(id);
      emit(state.copyWith(
        status: TopicsStateStatus.loaded,
        topicContent: topicContent,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TopicsStateStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> refresh(int id) => getTopicsData(id, true);
}
