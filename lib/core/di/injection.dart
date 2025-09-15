import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependecies() async => getIt.init();
