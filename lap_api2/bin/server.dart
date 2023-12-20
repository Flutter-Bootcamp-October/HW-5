import 'dart:io';

import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';

import 'configuration/supabase.dart';
import 'routes/mainroutes.dart';


void main() async {
  // withHotreload(
  //   () => createServer(),
  //   onReloaded: () => print('Reload!'),
  //   onHotReloadNotAvailable: () => print('No hot-reloassd :('),
  //   onHotReloadAvailable: () => print('Yay! Hot-reload :)'),
  //   onHotReloadLog: (log) => print('Reload Log: ${log.message}'),
  //   logLevel: Level.INFO,
  // );
    await createServer();
}

Future<HttpServer> createServer() async {
  SupabaseIntegration().supabase;
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment["PORT"] ?? '8080');

  final server = await serve(MainRoutes().route, ip, port);
  print('http://${server.address.host}:${server.port}');
  return server;
}
