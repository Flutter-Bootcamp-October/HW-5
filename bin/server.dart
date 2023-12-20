import 'dart:io';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';
import 'routers/main_router.dart';
import 'services/supabase_configretion.dart';

void main() async {
  // withHotreload(
  // () =>
  createServer();
  // );
}

Future<HttpServer> createServer() async {
  SupabaseConfigretion.supabase;
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(MainRouter().mainRouter, ip, port);
  print('http://${server.address.host}:${server.port}');
  return server;
}
