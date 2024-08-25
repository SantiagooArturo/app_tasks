import 'package:apptasks/router/routes.dart';
import 'package:apptasks/ui/global_widgets/custom_button.widget.dart';
import 'package:apptasks/ui/layouts/main.layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: const Text(
              "Bienvenido",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: 20,),
          CustomButtonWidget(
              text: "Ingresar",
              onTap: () {
                context.go(Routes.tasks);
              })
        ],
      ),
    );
  }
}
