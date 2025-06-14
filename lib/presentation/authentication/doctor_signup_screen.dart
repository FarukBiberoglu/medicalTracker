import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled19/core/enum/role_enum.dart';
import 'package:untitled19/core/extension/padding_extension.dart';
import 'package:untitled19/presentation/authentication/doctor_cubit/doctor_cubit.dart';
import 'package:untitled19/presentation/authentication/doctor_cubit/doctor_cubit_state.dart';
import 'package:untitled19/presentation/authentication/doctor_login_view.dart';
import 'package:untitled19/presentation/authentication/login_screen.dart';
import 'package:untitled19/presentation/authentication/sign_up_screen.dart';
import 'package:untitled19/presentation/doctor/main/view/main_view.dart';
import '../../core/router/app_router.dart';
import '../../core/widgets/custom_button_widget.dart';
import '../../core/widgets/custom_text_field_widget.dart';
import '../../core/utils/ui_utils.dart';
import '../../data/service/service_locator.dart';
import 'cubit/auth/auth_cubit.dart';
import 'cubit/auth/auth_cubit_state.dart';


class DoctorSignUp extends StatefulWidget {
  const DoctorSignUp({super.key});

  @override
  State<DoctorSignUp> createState() => _DoctorSignUpState();
}

class _DoctorSignUpState extends State<DoctorSignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();

  bool _isPasswordVisible = false;

  final _nameFocus = FocusNode();
  final _usernameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _phoneFocus = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    _nameFocus.dispose();
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your full name";
    }
    return null;
  }


  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address (e.g., example@email.com)';
    }
    return null;
  }

  // Password validation
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Phone validation
  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    final phoneRegex = RegExp(r'^\+?[\d\s-]{10,}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid phone number (e.g., +1234567890)';
    }
    return null;
  }

  Future<void> handleSignUp() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await getIt<AuthCubit>().signUp(
          role: RoleEnum.doktor,
          fullName: nameController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          password: passwordController.text.trim(),
          specialization: specializationController.text.trim(),
        );

      } catch (e) {
        if (context.mounted) {
          UiUtils.showSnackBar(context, message: e.toString(), isError: true);
        }
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
        bloc: getIt<AuthCubit>(),
        listener: (context, state) {
          if (state.status == AuthStatus.authenticated) {
            getIt<AppRouter>().push(const DoctorMainView());
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Create Account",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Please fill in the details to continue",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        controller: nameController,
                        focusNode: _nameFocus,
                        hintText: "Doctor Name",
                        validator: _validateName,
                        prefixIcon: const Icon(Icons.person_outline),
                      ),

                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: emailController,
                        hintText: "Email",
                        focusNode: _emailFocus,
                        validator: _validateEmail,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: specializationController,
                        hintText: "Specilationz",
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: phoneController,
                        focusNode: _phoneFocus,
                        validator: _validatePhone,
                        hintText: "Phone Number",
                        prefixIcon: const Icon(Icons.phone_outlined),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        obscureText: !_isPasswordVisible,
                        hintText: "Password",
                        focusNode: _passwordFocus,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        validator: _validatePassword,
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomButton(
                        onPressed: handleSignUp,
                        text: "Create Account",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account?  ",
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                            children: [
                              TextSpan(
                                text: "Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                       Navigator.push(context, MaterialPageRoute(builder: (context) => DoctorLoginView()));
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const SignupScreen()),
                            );
                          },
                          child: const Text(
                            "Are you a patient? Sign Up here",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).symmetricPadding(vertical: 40),
              ),
            ),
          );
        });
  }
}