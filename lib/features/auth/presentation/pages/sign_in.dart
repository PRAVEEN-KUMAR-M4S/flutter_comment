import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_comment/core/common/widgets/loader.dart';
import 'package:flutter_comment/core/constants/const_color.dart';
import 'package:flutter_comment/core/utils/snack_bar.dart';
import 'package:flutter_comment/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_comment/features/auth/presentation/widgets/auth_custom_button.dart';
import 'package:flutter_comment/features/auth/presentation/widgets/auth_field.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
             return showSnackBar(context, state.error);
            }else if(state is AuthSignInSuccess){
               Navigator.pushNamedAndRemoveUntil(context, '/HomePage',(route)=>false); 
            }
          },
          builder: (context, state) {
             if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    SizedBox(height: 20,),
                      const Text(
                        'Comment',
                        style: TextStyle(
                            fontSize: 24,
                            color: appBlue,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      AuthField(controller: _emailController, text: 'Email'),
                      const SizedBox(
                        height: 15,
                      ),
                      AuthField(
                        controller: _passwordController,
                        text: 'Password',
                        obscureText: true,
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthCustomButton(
                        text: 'Sign In',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AuthBloc>().add(AuthSignIn(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim()));
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/SignUpPage');
                        },
                        child: RichText(
                          text: TextSpan(
                              text: "Don't have an account? ",
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          color: appBlue,
                                          fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
