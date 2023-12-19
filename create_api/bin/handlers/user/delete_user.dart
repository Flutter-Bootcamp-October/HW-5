import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../../configs/supabase.dart';
import '../../helper/check_userdate.dart';

deleteUser(Request request) async {
  try {
    final Map body = jsonDecode(await request.readAsString());
    print(body);
    List<String> key = ["email"];
    await checkDelete(key: key, body: body);
    final user = SupabaseNet.supabases;
    final id =
        await SupabaseNet.supabases!.auth.getUser(request.headers["token"]);
    await user!
        .from("user_api")
        .delete()
        .match({"email": body["email"], "id_auth": id.user!.id});
    await user.auth.admin.deleteUser(id.user!.id.toString());
    return Response.ok(jsonEncode({"msg": "Success delete"}),
        headers: {"Content-Type": "application/json"});
  } on FormatException catch (e) {
    return Response.badRequest(
        body: jsonEncode({"meg": e.message}),
        headers: {"Content-Type": "application/json"});
  } catch (e) {
    return Response.badRequest(
        body: jsonEncode({"meg": "token invalid"}),
        headers: {"Content-Type": "application/json"});
  }
}
