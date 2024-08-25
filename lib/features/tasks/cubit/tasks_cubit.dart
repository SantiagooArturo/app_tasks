import 'package:apptasks/core/models/dataError.model.dart';
import 'package:apptasks/features/tasks/models/task.model.dart';
import 'package:apptasks/features/tasks/models/taskCreate.dto.dart';
import 'package:apptasks/features/tasks/services/tasks.service.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final TasksService tasksService = TasksService();
  TasksCubit() : super(TasksInitial());

  Future<void> findAll() async {
    emit(FetchTasksLoading());
    try {
      final data = await tasksService.findAll();
      emit(FetchTasksSuccess(data: data));
    } catch (e) {
      emit(FetchTasksError(error: DataError(e as DioException))); //dio exception maneja los errores en la peticion
    }
  }

  Future<void> save(TaskCreateDto task) async {
    emit(FetchTasksLoading());
    try {
      await tasksService.save(task);
      findAll();
    } catch (e) {
      emit(FetchTasksError(error: DataError(e as DioException)));
    }
  }

  Future<void> update(String id, TaskModel taskSended) async {
    emit(FetchTasksLoading());
    try {
      final result = await tasksService.update(id, taskSended);
      findAll();
      //return result;
    } catch (e) {
      emit(FetchTasksError(error: DataError(e as DioException)));
    }
  }

  Future<void> delete(String id) async {
    // await Future.delayed(const Duration(seconds: 5), () {
    //   emit(FetchTasksLoading());
    // });
    
    try {
      await tasksService.delete(id);
      findAll();
    } catch (e) {
      emit(FetchTasksError(error: DataError(e as DioException)));
    }
  }

  Future<TaskModel?> findById(String id) async {
    emit(FetchTasksLoading());
    try {
      final result = await tasksService.findById(id);
      emit(TasksInitial());
      return result;
    } catch (e) {
      emit(FetchTasksError(error: DataError(e as DioException)));
    }
    return null;
  }
}
