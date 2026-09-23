import 'package:als/main.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int currentIndex = 0;

  List<Map<String, dynamic>> courses = [];

  @override
  void onInit() {
    super.onInit();
    getCourses();
  }

  // Bottom navigation
  void changeIndex(int index) {
    currentIndex = index;
    update();
  }

  Future<void> getCourses() async {
    try {
      final response = await supabase.from('courses').select("course_id");

      print('RESPONSE: $response');
      print('LENGTH: ${response.length}');

      courses = List<Map<String, dynamic>>.from(response);

      print('COURSES: $courses');
      print('COURSES LENGTH: ${courses.length}');

      update();
    } catch (e) {
      print('ERROR: $e');
    }
  }
}
