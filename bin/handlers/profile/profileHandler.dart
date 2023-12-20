import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../../utils/helper/Request_auth_Handler_Utils .dart';

Future<Response> getProfileHandler(Request req) async {
  try {
    final Map<String, dynamic> body = json.decode(await req.readAsString());
    List<String> keyNames = ["email"];
    RequestAuthHandlerUtils.checkBody(body: body, keysCheck: keyNames);
    final results =
        await RequestAuthHandlerUtils.fetchUserInfoByEmail(body["email"]);
    return Response.ok(json.encode(results));
  } catch (error) {
    return RequestAuthHandlerUtils.handleErrors(error);
  }
}
