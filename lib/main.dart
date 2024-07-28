import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tosbi/languages.dart';
import 'package:tosbi/tosbi_app.dart';
import 'package:tosbi/tosbi_contoller.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      SafeArea(child: Myapp()),
    );
  });
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  final TosbiController controller = Get.put(TosbiController());
  @override
  Widget build(BuildContext context) {
    double scaleWidth(double size) {
      final screenWidth = MediaQuery.of(context).size.width;
      const double baselineWidth = 412;
      return size * (screenWidth / baselineWidth);
    }
    return GetMaterialApp(
        useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      home: const Tosbi(),
      translations: Languages(),
      locale: controller.language.value,

      themeMode: controller.currentTheme.value,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        hintColor: Colors.black54,
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(scaleWidth(20)),
            side: BorderSide(
              color: Colors.white
            ),
          )
        )
      )
    );
  }
}
