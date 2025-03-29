import 'package:get/get.dart';
import '../views/task_list_view.dart';
import '../views/task_create_view.dart';
import '../views/task_edit_view.dart';

class AppRoutes {
  static const String HOME = '/';
  static const String CREATE_TASK = '/create-task';
  static const String EDIT_TASK = '/edit-task/:id';

  static List<GetPage> routes = [
    GetPage(
      name: HOME,
      page: () => TaskListView(),
    ),
    GetPage(
      name: CREATE_TASK,
      page: () => CreateTaskView(),
    ),
    GetPage(
      name: EDIT_TASK,
      page: () => EditTaskView(),
    ),
  ];
}
