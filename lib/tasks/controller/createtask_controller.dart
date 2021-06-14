import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import '../../services/apiservice.dart';
import 'package:my_goals/tasks/view/home.dart';

class CreateTaskController extends GetxController {
  RxString title = ''.obs;
  RxString description = ''.obs;

  void createTasks() async {
    final Map<String, dynamic> newtask = {
      "title": title,
      "description": description,
      "completed": false,
      "created_date": DateTime.now().toString()
    };
    APIService.createTask(newtask).then((createdtask) {
      if (createdtask != null) {
        Get.offAll(HomePage());
        Get.snackbar('Create Task', 'Task has been created successfully.');
      } else {
        Get.snackbar('Create Task', 'Task creation failed.');
      }
    });
  }
}
