import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../config/supabase.dart';
import '../auth_handlers/logic/check_body.dart';

uploadAvatarHandler(Request req) async {
  try {
    final Map<String, dynamic> body = jsonDecode(await req.readAsString());
    checkBody(keys: ['image'], body: body);

    //Get user object
    final UserResponse user = await SupaBaseIntegration()
        .getUserByToken(token: req.headers['token']!);

    //upload user avatar in [profile] table
    SupaBaseIntegration().uploadUserAvatar(
        user: user,
        bucket: 'images',
        path: 'users',
        extension: '.png',
        body: body);

    return Response.ok("Profile Updated");
  } on PostgrestException catch (err) {
    return Response.badRequest(
        body: "${err.message} -- try making the field [image] as Uint8List");
  } catch (err) {
    return Response.ok(err.toString());
  }
}
