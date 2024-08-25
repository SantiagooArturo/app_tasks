part of 'tasks_cubit.dart';

@immutable
sealed class TasksState {}

final class TasksInitial extends TasksState {}

final class FetchTasksLoading extends TasksState {}

final class FetchTasksSuccess extends TasksState {
  final List<TaskModel> data;

  FetchTasksSuccess({required this.data});
}

final class FetchTasksError extends TasksState {
  final DataError error;

  FetchTasksError({required this.error});
}
