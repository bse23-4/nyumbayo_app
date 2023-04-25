import '/exports/exports.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeController(),
        ),
         BlocProvider(
          create: (context) => PowerConnectionController(),
        ),
      ],
      child: BlocBuilder<ThemeController, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:  theme.copyWith(
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
              bodyColor: theme.brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
              displayColor: theme.brightness == Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
            initialRoute: Routes.dashboard,
            routes: Routes.routes(context),
          );
        },
      ),
    ),
  );
}
