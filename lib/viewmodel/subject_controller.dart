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
    fetchAllSubject();
    listenTosubject();
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

            fetchAllSubject();
          },
        )
        .subscribe();
  }

  Future<void> fetchAllSubject() async {
    try {
      final response = await supabase.from('subject').select();

      subject = List<Map<String, dynamic>>.from(response);

      print("Total subject: ${subject.length}");
      print(subject);

      update();
    } catch (e) {
      print("Error fetching subjects: $e");
    }
  }

  bool isloading = false;
  //insert new subject
  Future<void> addNewSubject({
    required String subjectName,
    required String subjectCode,
    required int credits,
  }) async {
    try {
      isloading = true;
      update();
      await supabase
          .from('subject')
          .insert({
            'subject_name': subjectName,
            'subject_code': subjectCode,
            'credits': credits,
          })
          .select()
          .single();
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
}
