import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_goals/tasks/model/task.dart';
import 'package:get/get.dart';
import '../../services/apiservice.dart';

class TaskController extends GetxController {
  RxList<Task> rxTasks = RxList<Task>();
  RxBool isLoading = RxBool(true);
  RxInt currentIndex = RxInt(0);
  Rx<Task> currentTask = Rx<Task>(null);

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() async {
    try {
      isLoading.value = true;
      var taskList = await APIService.getTasks();
      if (taskList != null) {
        rxTasks.value = taskList;
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void deleteTask(position) async {
    var result = await APIService.deleteTask(rxTasks[position].id.toString());
    if (result != null) {
      fetchTasks();
      Get.snackbar('Result', 'Task has been deleted.',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('Result', 'Task deletion failed.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void updateCurrentTask() async {
    currentTask.value = rxTasks[currentIndex.value];
  }
}
