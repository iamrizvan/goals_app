import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:my_goals/tasks/controller/tasks_controller.dart';
import '../../services/apiservice.dart';
import 'package:my_goals/tasks/view/home.dart';

class CreateTaskController extends GetxController {
  RxString title = ''.obs;
  RxString description = ''.obs;
  TaskController taskController = Get.find<TaskController>();

  void createTasks() async {
    final Map<String, dynamic> newtask = {
      "title": title.value,
      "description": description.value,
      "completed": false,
      "created_date": DateTime.now().toString()
    };
    APIService.createTask(newtask).then((createdtask) {
      if (createdtask != null) {
        taskController.fetchTasks();
        Get.offAll(HomePage());
        Get.snackbar('Create Task', 'Task has been created successfully.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Create Task', 'Task creation failed.',
            snackPosition: SnackPosition.BOTTOM);
      }
    });
  }
}
