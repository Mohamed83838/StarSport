import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starsport/BusinessLogic/Members/MembersCubit.dart';
import 'package:starsport/BusinessLogic/SessionDetail/SessionDetailCubit.dart';
import 'package:starsport/BusinessLogic/groups/groupCubit.dart';
import 'package:starsport/BusinessLogic/sessions/SessionCubit.dart';
import 'package:starsport/BusinessLogic/student_detail/StudentDetailCubit.dart';
import 'package:starsport/route/route.dart';


void main() {
  runApp( MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  const MyApp({super.key,required this.appRouter});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GroupCubit>(
          create: (BuildContext context) => GroupCubit()..loadGroups(),
        ),
        BlocProvider<SessionCubit>(
          create: (BuildContext context) => SessionCubit(),
        ),
        BlocProvider<MemberCubit>(
          create: (BuildContext context) => MemberCubit(),
        ),
        BlocProvider<SessionDetailCubit>(
          create: (BuildContext context) => SessionDetailCubit(),
        ),
          BlocProvider<StudentDetailsCubit>(
          create: (BuildContext context) =>  StudentDetailsCubit(),
        ),

      ],
      child:



      MaterialApp(
      onGenerateRoute: appRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,

      ),

      )
    );
  }
}
