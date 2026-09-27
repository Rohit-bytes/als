import 'package:als/auth/custom_widgets/custom_snackbar.dart';
import 'package:als/core/app_routes.dart';
import 'package:als/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int currentIndex = 0;

  List<Map<String, dynamic>> courses = [];
  List<Map<String, dynamic>> semester = [];
  List<Map<String, dynamic>> classes = [];

  @override
  void onInit() {
    super.onInit();
    getCourses();
    getSemester();
    getClasses();
  }

  // Bottom navigation
  void changeIndex(int index) {
    currentIndex = index;
    update();
  }

  Future<void> getCourses() async {
    try {
      final response = await supabase.from('courses').select();

      courses = List<Map<String, dynamic>>.from(response);

      update();
    } catch (e) {
      print('ERROR: $e');
    }
  }

  Future<void> getSemester() async {
    try {
      final response = await supabase.from('Semester').select();

      semester = List<Map<String, dynamic>>.from(response);

      update();
    } catch (e) {
      print('ERROR: $e');
    }
  }

  Future<void> getClasses() async {
    try {
      final response = await supabase.from('new_class').select();

      classes = List<Map<String, dynamic>>.from(response);
      print("class ${classes}");

      update();
    } catch (e) {
      print('ERROR: $e');
    }
  }

  bool isloading = false;
  String? finalcourseName, finalsemesterName;
  TextEditingController classNamecontrol = TextEditingController();
  Future<void> addnewclass(
    String courseName,
    String semesterName,
    String className,
  ) async {
    try {
      isloading = true;
      update();
      await supabase.from('new_class').insert({
        'course': courseName,
        'semester': semesterName,
        'class_name': className,
      });
      // CustomSnackbar.success(title: "Class created", message: "Succesfully");
      // finalcourseName = "";
      // finalsemesterName = "";
      // classNamecontrol.clear();
      Get.toNamed(AppRoutes.addclasssuccesful);
    } catch (e) {
      print(e);
      CustomSnackbar.error(
        title: "Class not created",
        message: "error while creating class",
      );
    } finally {
      isloading = false;
      update();
    }
  }

  String? courseError;
  String? semesterError;
  String? classNameError;

  void clearErrors() {
    courseError = null;
    semesterError = null;
    classNameError = null;
    update();
  }

  bool validateClassForm() {
    courseError = null;
    semesterError = null;
    classNameError = null;

    bool isValid = true;

    if (finalcourseName == null || finalcourseName!.isEmpty) {
      courseError = "Please select a course";
      isValid = false;
    }

    if (finalsemesterName == null || finalsemesterName!.isEmpty) {
      semesterError = "Please select a semester";
      isValid = false;
    }

    if (classNamecontrol.text.trim().isEmpty) {
      classNameError = "Class name cannot be empty";
      isValid = false;
    }

    update();

    return isValid;
  }
}
