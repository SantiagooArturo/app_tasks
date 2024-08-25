import 'package:apptasks/features/login/login.screen.dart';
import 'package:apptasks/features/register/register.screen.dart';
import 'package:apptasks/features/splash/splash.screen.dart';

import 'package:apptasks/features/tasks/task.create.screen.dart';
import 'package:apptasks/features/tasks/tasks.screen.dart';
import 'package:apptasks/router/routes.dart';
import 'package:go_router/go_router.dart';

final goRouter = GoRouter(routes: [
  GoRoute(
    path: Routes.splash,
    builder: (context, state) {
      return const SplashScreen();
    },
  ),
  GoRoute(
    path: Routes.login,
    builder: (context, state) {
      return const LoginScreen();
    },
  ),
  GoRoute(
    path: Routes.register,
    builder: (context, state) {
      return const RegisterScreen();
    },
  ),
  GoRoute(
      path: Routes.tasks,
      builder: (context, state) {
        return const TasksScreen();
      },
      routes: [
        GoRoute(
          path: "create",
          builder: (context, state) {
            return const TaskCreateScreen();
          },
        ),
        GoRoute(
          path: "edit/:id",
          builder: (context, state) {
            return  TaskCreateScreen(id: state.pathParameters['id'].toString(),);
          },
        ),
      ]),
]);
