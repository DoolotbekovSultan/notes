import 'package:logger/web.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    colors: true,
    printEmojis: true,
    lineLength: 120,
  ),
  level: Level.debug,
);
