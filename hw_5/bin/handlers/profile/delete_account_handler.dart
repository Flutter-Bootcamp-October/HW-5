import 'package:shelf/shelf.dart';
import '../../utils/helper/Request_auth_Handler_Utils .dart';

deleteAccountHandler(Request req) async {
  try {
    final body = await RequestAuthHandlerUtils.decodeRequestBody(req);
    List<String> keyNames = ["email"];
    RequestAuthHandlerUtils.checkBody(body: body, keysCheck: keyNames);
    await RequestAuthHandlerUtils.deleteUserAccount(body["email"]);
    return Response.ok("The account deleted successfully");
  } catch (e) {
    return RequestAuthHandlerUtils.handleErrors(e);
  }
}
