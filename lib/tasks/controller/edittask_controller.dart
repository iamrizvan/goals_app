import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';
import '../../services/apiservice.dart';
import 'package:my_goals/tasks/controller/tasks_controller.dart';
import 'package:my_goals/tasks/model/task.dart';
import 'package:my_goals/tasks/view/home.dart';

class UpdateTaskController extends GetxController {
  RxBool checkboxvalue = false.obs;
  RxString title = RxString('');
  RxString description = RxString('');
  Rx<Task> currentTask = null.obs;

  TaskController taskController = Get.find<TaskController>();

  @override
  Future<void> onInit() async {
    super.onInit();
    currentTask.value = await taskController.fetchCurrentTask();
  }

  void updateTasks() async {
    final Map<String, dynamic> updatedtask = {
      "title": title,
      "description": description,
      "completed": checkboxvalue,
      "created_date": DateTime.now().toString()
    };
    APIService.updateTask(updatedtask, currentTask.value.id.toString())
        .then((createdtask) {
      if (createdtask != null) {
        Get.offAll(HomePage());
        Get.snackbar('Create Task', 'Task has been created successfully.');
      } else {
        Get.snackbar('Create Task', 'Task creation failed.');
      }
    });
  }
}
