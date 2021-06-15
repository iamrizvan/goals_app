import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import 'package:my_goals/tasks/model/task.dart';
import '../../services/apiservice.dart';
import 'package:my_goals/tasks/controller/tasks_controller.dart';
import 'package:my_goals/tasks/view/home.dart';

class UpdateTaskController extends GetxController {
  RxBool checkboxvalue = RxBool(false);
  RxString title = RxString('');
  RxString description = RxString('');
  TaskController taskController = Get.find<TaskController>();

  @override
  Future<void> onInit() async {
    super.onInit();
    checkboxvalue.value = taskController.currentTask.value.completed;
  }

  void updateTasks() async {
    final Map<String, dynamic> editedtask = {
      "title": title.value,
      "description": description.value,
      "completed": checkboxvalue.value,
      "created_date": DateTime.now().toString()
    };
    var taskId = taskController.currentTask.value.id;
    Task updatedTask =
        await APIService.updateTask(editedtask, taskId.toString());
    if (updatedTask != null) {
      taskController.fetchTasks();
      Get.offAll(HomePage());
      Get.snackbar('Update Task', 'Task has been created successfully.',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Update Task', 'Task creation failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
