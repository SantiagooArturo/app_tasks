import 'package:apptasks/features/tasks/cubit/tasks_cubit.dart';
import 'package:apptasks/features/tasks/models/task.model.dart';
import 'package:apptasks/router/routes.dart';
import 'package:apptasks/ui/layouts/main.layout.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  late TasksCubit _tasksCubit;

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  init() {
    _tasksCubit = BlocProvider.of<TasksCubit>(context);
    _tasksCubit.findAll();
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Mis tarea"),
              Column(
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        
                        hintText: "Buscar tarea",
                      ),
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () async {
                    final result = await context.push("${Routes.tasks}/create");
                    if (result != null) {
                      Fluttertoast.showToast(
                          msg: "Se agrego correctamente el tarea",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  icon: const Icon(
                    Icons.add,
                  ))
            ],
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {},
                    child: BlocBuilder<TasksCubit, TasksState>(
                      builder: (context, state) {
                        if (state is FetchTasksLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is FetchTasksSuccess) {
                          return ListView.builder(
                            itemCount: state.data.length,
                            itemBuilder: (context, index) {
                              final item = state.data[index];
                              return ListTile(
                                title: Text(item.title),
                                subtitle: Text(item.description),
                                leading: IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                  onPressed: () async {
                                    try {
                                      await _tasksCubit.delete(item.id!);

                                      Fluttertoast.showToast(
                                        msg: "Se elimino correctamente la tarea",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );

                                      // await _tasksService.delete(item.id ?? '');
                                    } catch (e) {
                                      if (e is DioException) {
                                        Fluttertoast.showToast(
                                          msg: e.message!,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.grey,
                                          textColor: Colors.white,
                                        );
                                      }
                                    }
                                  },
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: Colors.grey.shade400,
                                  size: 14,
                                ),
                                onTap: () async {
                                  final result = await context
                                      .push("${Routes.tasks}/edit/${item.id}");
                                  if (result != null) {
                                    Fluttertoast.showToast(
                                        msg: "Se actualizo correctamente la tarea",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.blue,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                              );
                            },
                          );
                        } else if (state is FetchTasksError) {
                          return Center(
                            child: Text(
                              state.error.exception.message ??
                                  'Ocurrio un problema al obtener las tareas',
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
