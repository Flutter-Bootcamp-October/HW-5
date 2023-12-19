import 'dart:io';

import 'package:shelf/shelf_io.dart';

import 'config/supabase.dart';
import 'routes/main_route.dart';

void main(List<String> args) async {
  SupabaseClass().supabase;
  final ip = InternetAddress.anyIPv4;
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(MainRoute().route, ip, port);
  print('http://${server.address.host}:${server.port}');
}
