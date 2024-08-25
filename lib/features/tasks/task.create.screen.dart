import 'package:apptasks/features/tasks/cubit/tasks_cubit.dart';
import 'package:apptasks/features/tasks/models/task.model.dart';
import 'package:apptasks/features/tasks/models/taskCreate.dto.dart';
import 'package:apptasks/features/tasks/services/tasks.service.dart';
import 'package:apptasks/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class TaskCreateScreen extends StatefulWidget {
  final String id;
  const TaskCreateScreen({super.key, this.id = 'none'});

  @override
  State<TaskCreateScreen> createState() => _TaskCreateScreenState();
}

class _TaskCreateScreenState extends State<TaskCreateScreen> {
  late TasksCubit _tasksCubit;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priorityController = TextEditingController();
  bool valuePresent = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  Future<void> init() async {
    _tasksCubit = BlocProvider.of<TasksCubit>(context);

    if (widget.id != 'none') {
      final findTask = await _tasksCubit.findById(widget.id);
      valuePresent = true;
      if (findTask != null) {
        setState(() {
          titleController.text = findTask.title;
          descriptionController.text = findTask.description;
          priorityController.text = findTask.priority ?? '';
        });
      }
    }
  }

  final TasksService _tasksService = TasksService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is FetchTasksLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(labelText: 'Título'),
                        ),
                        TextFormField(
                          controller: descriptionController,
                          decoration: InputDecoration(labelText: 'Descripción'),
                        ),
                        TextFormField(
                          controller: priorityController,
                          decoration: InputDecoration(labelText: 'Prioridad (opcional)'),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () async{
                            if (valuePresent == false) {
                              TaskCreateDto modelSendDto = TaskCreateDto(
                                title: titleController.text,
                                description: descriptionController.text,
                                priority: priorityController.text,
                              );
                              await _tasksCubit.save(modelSendDto);
                              // context.go(Routes.tasks);
                              context.pop(true);
                            } else {
                              TaskModel modelUpdate = TaskModel(
                                title: titleController.text,
                                description: descriptionController.text,
                                priority: priorityController.text,
                              );
                              // validar update
                              await _tasksCubit.update(widget.id, modelUpdate);
                              context.pop(false);
                            }
                          },
                          child: Text('Guardar'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
