import 'package:als/main.dart';
import 'package:get/get.dart';

class AttendanceController extends GetxController {
  //get current attendance list
  List<Map<String, dynamic>> totalstudent = [];
  List<Map<String, dynamic>> studentpresent = [];
  List<Map<String, dynamic>> studentabsent = [];

  bool isloading = false;

  Future<void> fetchStudentAttendance() async {
    try {
      isloading = true;
      update();

      final data = await supabase.from('student_attendance').select();

      // All attendance records
      totalstudent = List<Map<String, dynamic>>.from(data);

      // Present students
      studentpresent = totalstudent
          .where((student) => student['attendance'] == 1)
          .toList();

      // Absent students
      studentabsent = totalstudent
          .where((student) => student['attendance'] == 0)
          .toList();

      print("Total: ${totalstudent}");
      print("Present: ${studentpresent.length}");
      print("Absent: ${studentabsent.length}");
    } catch (e) {
      print("Error: $e");
    } finally {
      isloading = false;
      update();
    }
  }

  List<Map<String, dynamic>> students = [];

  Future<void> fetchAllStudent(String classid) async {
    try {
      isloading = true;
      final response = await supabase
          .from('student_profiles')
          .select()
          .eq("class_id", classid);

      students = List<Map<String, dynamic>>.from(response);

      print("Total students: ${students.length}");
      print(students);

      update(); // If using GetBuilder
    } catch (e) {
      print("Error fetching students: $e");
    } finally {
      isloading = false;
      update();
    }
  }
}
