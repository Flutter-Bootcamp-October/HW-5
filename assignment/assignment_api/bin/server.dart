import 'dart:io';

import 'package:shelf/shelf_io.dart';

import 'routes/mainRoute.dart';
import 'supabase/supabase.dart';

void main() async {
  // withHotreload(
  //   () => createServer(),
  //   onReloaded: () => print('Reload!'),
  //   onHotReloadNotAvailable: () => print('No hot-reload :('),
  //   onHotReloadAvailable: () => print('Yay! Hot-reload :)'),
  //   onHotReloadLog: (log) => print('Reload Log: ${log.message}'),
  //   logLevel: Level.INFO,
  // );
  createServer();
}

Future<HttpServer> createServer() async {
  SupabaseIntegration().supabase;
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment["PORT"] ?? "8080");
  print(port);
  final server = await serve(MainRoute().route, ip, port);
  print("http://${server.address.host}:${server.port}");

  return server;
}
