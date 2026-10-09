import 'package:als/auth/custom_widgets/custom_snackbar.dart';
import 'package:als/core/app_routes.dart';
import 'package:als/main.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubjectController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // fetchAllSubject();
    listenTosubject();
    fetchAllduration();
  }

  @override
  void onClose() {
    supabase.removeChannel(subjectChannel);
    super.onClose();
  }

  //fetch all subjects
  List<Map<String, dynamic>> subject = [];
  late final RealtimeChannel subjectChannel;

  void listenTosubject() {
    subjectChannel = supabase
        .channel('new_subject_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'subject',
          callback: (payload) {
            print("subject table changed: ${payload.eventType}");

            // fetchAllSubject();
          },
        )
        .subscribe();
  }

  // Future<void> fetchAllSubject() async {
  //   try {
  //     final response = await supabase.from('subject').select();

  //     subject = List<Map<String, dynamic>>.from(response);

  //     print("Total subject: ${subject.length}");
  //     print(subject);

  //     update();
  //   } catch (e) {
  //     print("Error fetching subjects: $e");
  //   }
  // }

  // fetch duration
  List<Map<String, dynamic>> duration = [];
  Future<void> fetchAllduration() async {
    try {
      final response = await supabase.from('duration').select();

      duration = List<Map<String, dynamic>>.from(response);

      print("Total durations: ${duration.length}");
      print(duration);

      update();
    } catch (e) {
      print("Error fetching duration: $e");
    }
  }

  Future<void> fetchClassSubject(String classId) async {
    try {
      isloading = true;
      update();
      // 1. Get subject IDs assigned to this class
      final classSubjectResponse = await supabase
          .from('class_subject')
          .select('subject_id')
          .eq('class_id', classId);

      final List<Map<String, dynamic>> classSubjects =
          List<Map<String, dynamic>>.from(classSubjectResponse);

      if (classSubjects.isEmpty) {
        subject = [];
        update();
        return;
      }

      // 2. Extract subject IDs
      final List<int> subjectIds = classSubjects
          .map((item) => item['subject_id'] as int)
          .toList();

      print("Subject IDs: $subjectIds");

      // 3. Fetch actual subjects
      final response = await supabase
          .from('subject')
          .select()
          .inFilter('id', subjectIds);

      subject = List<Map<String, dynamic>>.from(response);

      print("Total subjects for class: ${subject.length}");
      print(subject);

      update();
    } catch (e) {
      print("Error fetching class subjects: $e");
    } finally {
      isloading = false;
      update();
    }
  }

  bool isloading = false;
  //insert new subject
  Future<void> addNewSubject({
    required String subjectName,
    required String subjectCode,
    required int credits,
    required String classId,
  }) async {
    try {
      isloading = true;
      update();
      final newSubject = await supabase
          .from('subject')
          .insert({
            'subject_name': subjectName,
            'subject_code': subjectCode,
            'credits': credits,
          })
          .select()
          .single();
      final int subjectId = newSubject['id'];

      print("New Subject ID: $subjectId");
      print("Class ID: $classId");

      // 2. Connect subject with class
      await supabase.from('class_subject').insert({
        'class_id': classId,
        'subject_id': subjectId,
      });

      Get.back();
    } catch (e) {
      print(e);
      CustomSnackbar.error(
        title: "Subject not created",
        message: "error while creating Subject",
      );
    } finally {
      isloading = false;
      update();
    }
  }

  int? loadingIndex;
  Future<void> deleteSubject(int id, int index, String classId) async {
    try {
      loadingIndex = index;
      update();
      await supabase
          .from('class_subject')
          .delete()
          .eq('class_id', classId)
          .eq('subject_id', id);

      await supabase.from('subject').delete().eq('id', id);

      CustomSnackbar.success(
        title: "Subject deleted",
        message: "Subject deleted successfully",
      );
      await fetchClassSubject(classId);
      // await fetchAllSubject();
    } catch (e) {
      print("Delete subject error: $e");

      CustomSnackbar.error(
        title: "Delete failed",
        message: "Unable to delete subject",
      );
    } finally {
      loadingIndex = null;
      update();
    }
  }
}
