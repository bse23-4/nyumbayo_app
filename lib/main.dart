import '/exports/exports.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeController(),
        ),
      ],
      child: BlocBuilder<ThemeController, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: Routes.dashboard,
            routes: Routes.routes(context),
          );
        },
      ),
    ),
  );
}
