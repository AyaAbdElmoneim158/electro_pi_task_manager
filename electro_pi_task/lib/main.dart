import 'package:electro_pi_task/core/service_locator.dart';
import 'package:electro_pi_task/core/utils/app_bloc_observer.dart';
import 'package:electro_pi_task/core/utils/shared_preferences_service.dart';
import 'package:electro_pi_task/electro_pi_task_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //TODO: At.fun 
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferencesService.init();
  await initServiceLocator();
    Bloc.observer = AppBlocObserver();


  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  ).then((_) => runApp(const ElectroPiTaskApp()));
}

// ayaabdelmon@gmail.com - Ayhb756@