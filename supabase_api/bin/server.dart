import 'dart:io';

import 'package:shelf/shelf_io.dart';

import 'configuration/supabase_config.dart';
import 'routes/main_route.dart';

void main() async {
  HttpServer server = await createServer();
  print("http://${server.address.host}:${server.port}");
}

Future<HttpServer> createServer() async {
  SupabaseConfig().supabaseConfig;
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? "8080");

  final server = await serve(MainRoutes().route, ip, port);
  return server;
}
