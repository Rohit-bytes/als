import 'package:als/core/app_routes.dart';
import 'package:als/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  bool isLoading = false;

  // ================= LOGIN =================

  String? emailError;
  String? passwordError;

  bool isobsecure = false;

  void isobsecurecheck() {
    isobsecure = !isobsecure;
    update();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading = true;
      update();

      final response = await supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (response.user != null) {
        Get.offAllNamed(AppRoutes.landingpage);
      }
    } on AuthException catch (e) {
      Get.snackbar(
        "Login Failed",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> loginCheck(String email, String password) async {
    emailError = null;
    passwordError = null;

    bool isValid = true;

    // Email
    if (email.trim().isEmpty) {
      emailError = "Email is required";
      isValid = false;
    } else if (!GetUtils.isEmail(email.trim())) {
      emailError = "Enter a valid email address";
      isValid = false;
    }

    // Password
    if (password.isEmpty) {
      passwordError = "Password is required";
      isValid = false;
    } else if (password.length < 6) {
      passwordError = "Password must be at least 6 characters";
      isValid = false;
    }

    update();

    if (!isValid) {
      return;
    }

    await loginUser(email, password);
  }

  // ================= SIGNUP CONTROLLERS =================

  TextEditingController regnamecontrol = TextEditingController();
  TextEditingController regEnrollNumcontrol = TextEditingController();
  TextEditingController regEmailcontrol = TextEditingController();
  TextEditingController regaddcontrol = TextEditingController();
  TextEditingController regpasscontrol = TextEditingController();
  TextEditingController regreppasscontrol = TextEditingController();

  // ================= SIGNUP ERRORS =================

  String? nameError;
  String? enrollNoError;
  String? signupEmailError;
  String? signupPasswordError;
  String? confirmPasswordError;

  // ================= SIGNUP VALIDATION =================

  Future<void> signupCheck(
    String name,
    String enrollno,
    String email,
    String password,
    String repPassword,
  ) async {
    // Clear previous errors
    nameError = null;
    enrollNoError = null;
    signupEmailError = null;
    signupPasswordError = null;
    confirmPasswordError = null;

    bool isValid = true;

    // Name validation
    if (name.trim().isEmpty) {
      nameError = "Name is required";
      isValid = false;
    } else if (name.trim().length < 3) {
      nameError = "Name must be at least 3 characters";
      isValid = false;
    }

    // Enrollment number validation
    if (enrollno.trim().isEmpty) {
      enrollNoError = "Enrollment number is required";
      isValid = false;
    }

    // Email validation
    if (email.trim().isEmpty) {
      signupEmailError = "Email is required";
      isValid = false;
    } else if (!GetUtils.isEmail(email.trim())) {
      signupEmailError = "Enter a valid email address";
      isValid = false;
    }

    // Password validation
    if (password.isEmpty) {
      signupPasswordError = "Password is required";
      isValid = false;
    } else if (password.length < 6) {
      signupPasswordError = "Password must be at least 6 characters";
      isValid = false;
    }

    // Confirm password validation
    if (repPassword.isEmpty) {
      confirmPasswordError = "Please confirm your password";
      isValid = false;
    } else if (password != repPassword) {
      confirmPasswordError = "Passwords do not match";
      isValid = false;
    }

    // Update UI
    update();

    // Don't signup if validation failed
    if (!isValid) {
      return;
    }

    await signUpUser(name, enrollno, email, password, repPassword);
  }

  // ================= SUPABASE SIGNUP =================
  final user = supabase.auth.currentUser;
  Future<void> signUpUser(
    String name,
    String enrollno,
    String email,
    String password,
    String repPassword,
  ) async {
    try {
      isLoading = true;
      update();

      final response = await supabase.auth.signUp(
        email: email.trim(),
        password: password,
        data: {
          'name': name.trim(),
          'enrollNumber': enrollno.trim(),
          'email_verified': "true",
        },
      );

      if (response.user != null) {
        Get.offAllNamed(AppRoutes.landingpage);
      }
    } on AuthException catch (e) {
      Get.snackbar(
        "Signup Failed",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update();
    }
  }
}
