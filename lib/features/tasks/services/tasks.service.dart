import 'package:apptasks/core/services/api.service.dart';
import 'package:apptasks/features/tasks/models/task.model.dart';
import 'package:apptasks/features/tasks/models/taskCreate.dto.dart';

class TasksService {
  final String endpoint = '/tasks';
  final ApiService apiService = ApiService();

  Future<List<TaskModel>> findAll() async {
    try {
      final response = await apiService.get(endpoint);

      final List<TaskModel> tasks = List<TaskModel>.from(response.data.map((element) => TaskModel.fromMap(element)));
      return tasks;
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskModel> save(TaskCreateDto task) async {
    try {
      final response = await apiService.post(endpoint, task.toMap());
      return TaskModel.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskModel> update(String id, TaskModel taskSended) async {
    try {
      final response = await apiService.put('$endpoint/$id', taskSended.toMap());
      return TaskModel.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete(String id) async {
    try {
      await apiService.delete(endpoint + '/$id');
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskModel> findById(String id) async {
    try {
      final response = await apiService.get('$endpoint/$id');

      return TaskModel.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }


  Future<List<TaskModel>> findByTitle(String title) async {
    try {
      final response = await apiService.get('$endpoint?title=$title');
      final List<TaskModel> tasks = List<TaskModel>.from(response.data.map((element) => TaskModel.fromMap(element)));
      return tasks;
    } catch (e) {
      rethrow;
    }
  }
}
