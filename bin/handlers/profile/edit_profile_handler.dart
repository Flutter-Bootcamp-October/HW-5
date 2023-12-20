import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../../utils/helper/Request_auth_Handler_Utils .dart';

Future<Response> postProfileHandler(Request req) async {
  try {
    final decodedBody = await RequestAuthHandlerUtils.decodeRequestBody(req);
    final Map<String, dynamic> body = decodedBody as Map<String, dynamic>;
    List<String> keyNames = ["name", "email", "bio"];
    RequestAuthHandlerUtils.checkBody(body: body, keysCheck: keyNames);
    final email = body['email'];
    await RequestAuthHandlerUtils.updateUserInfo(email, body);
    return Response.ok(json.encode({"message": "Successfully updated"}),
        headers: {"Content-Type": "application/json"});
  } catch (error) {
    return RequestAuthHandlerUtils.handleErrors(error);
  }
}
