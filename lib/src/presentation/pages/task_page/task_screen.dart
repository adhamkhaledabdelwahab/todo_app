import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/src/core/components/app_bar_widget.dart';
import 'package:todo_app/src/core/constants/task_model_const.dart';
import 'package:todo_app/src/core/routes/routes.dart';
import 'package:todo_app/src/core/utils/screen_onresume_task_notification.dart';
import 'package:todo_app/src/data/models/task_model.dart';
import 'package:todo_app/src/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:todo_app/src/presentation/widgets/task_page_widgets/task_field_info_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    TaskModel task = ModalRoute.of(context)!.settings.arguments as TaskModel;
    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (AppBloc.get(context).appLaunchTask != null) {
          onAppResumeFromTaskNotificationSelect(
            taskScreenRoute,
            context,
          ).then(
            (value) => AppBloc.get(context).add(
              AppUpdateSelectedTaskNotificationEvent(null),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: MyAppBar(
            text: "Task Info",
            isBoardScreen: false,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: const [
                    Text(
                      'Hello',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF121212),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'You have a new reminder',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF121212),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: taskColors[task.color],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TaskFieldInfo(
                        iconData: Icons.text_format,
                        subtitle: task.title,
                        title: 'Title',
                      ),
                      task.description.isNotEmpty
                          ? TaskFieldInfo(
                              iconData: Icons.text_format,
                              subtitle: task.description,
                              title: 'Description',
                            )
                          : Container(),
                      TaskFieldInfo(
                        iconData: Icons.calendar_today_outlined,
                        subtitle: task.date,
                        title: 'Date',
                      ),
                      TaskFieldInfo(
                        iconData: Icons.access_time,
                        subtitle: task.startTime,
                        title: 'Start Time',
                      ),
                      TaskFieldInfo(
                        iconData: Icons.access_time,
                        subtitle: task.endTime,
                        title: 'End Time',
                      ),
                      TaskFieldInfo(
                        iconData: task.isFavourite == 1
                            ? Icons.favorite_outlined
                            : Icons.favorite_outline,
                        subtitle: '${task.isFavourite == 1}',
                        title: 'Favourite',
                      ),
                      TaskFieldInfo(
                        iconData: task.isCompleted == 0
                            ? Icons.downloading
                            : Icons.download_done,
                        subtitle:
                            task.isCompleted == 1 ? 'Completed' : 'Uncompleted',
                        title: 'Task State',
                      ),
                      TaskFieldInfo(
                        iconData: task.isCompleted == 0
                            ? Icons.downloading
                            : Icons.download_done,
                        subtitle: getRepeat(task.repeat),
                        title: 'Task Repeat',
                      ),
                      TaskFieldInfo(
                        iconData: Icons.audio_file_outlined,
                        subtitle: task.audioPath.isNotEmpty
                            ? task.audioPath.split("/").last
                            : "No Sound Selected",
                        title: 'Task Notification Sound',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
