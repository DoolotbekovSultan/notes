import 'package:logger/web.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    colors: false,
    printEmojis: true,
    lineLength: 120,
  ),
  level: Level.debug,
);
