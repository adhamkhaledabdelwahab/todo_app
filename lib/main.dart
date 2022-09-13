import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todo_app/src/core/routes/routes.dart';
import 'package:todo_app/src/core/utils/isolates_update.dart';
import 'package:todo_app/src/injection_container.dart';
import 'package:todo_app/src/presentation/bloc/bloc.dart';
import 'package:todo_app/src/presentation/pages/add_task_page/add_task_screen.dart';
import 'package:todo_app/src/presentation/pages/board_page/board_screen.dart';
import 'package:todo_app/src/presentation/pages/schedule_page/scheduled_task_screen.dart';
import 'package:todo_app/src/presentation/pages/splash_page/splash_screen.dart';
import 'package:todo_app/src/presentation/pages/task_page/task_screen.dart';

//TODO refractor ui widgets and separate each one
//TODO schedule notification based on month day number so even if day was 31 and next is 30 or 29 it shout only notify on last day on month

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  restartNotificationUpdateIsolate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<BoardBloc>(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO App',
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        initialRoute: splashScreenRoute,
        routes: {
          splashScreenRoute: (_) => const SplashScreen(),
          boardScreenRoute: (_) => const BoardScreen(),
          createTaskScreenRoute: (_) => const AddTaskScreen(),
          taskScreenRoute: (_) => const TaskScreen(),
          scheduledTasksScreenRoute: (_) => const ScheduledTasksScreen(),
        },
      ),
    );
  }
}
