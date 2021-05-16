import 'package:flutter/material.dart';
import 'package:flutter_firebase_codelab/app/dependency_injection.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/app_state.dart';

void main() {
  dependencyInjection();

  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => App(),
    ),
  );
}
