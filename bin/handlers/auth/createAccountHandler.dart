import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../utils/helper/Request_auth_Handler_Utils .dart';

Future<Response> createAccountHandler(Request req) async {
  try {
    final body = await RequestAuthHandlerUtils.decodeRequestBody(req);
    List<String> keyNames = ["name", "email", "password"];
    RequestAuthHandlerUtils.checkBody(body: body, keysCheck: keyNames);
    AuthResponse user = await RequestAuthHandlerUtils.createAndSignInUser(body);
    return RequestAuthHandlerUtils.buildSuccessResponse(user);
  } on FormatException catch (error) {
    return Response.badRequest(body: error.message);
  } on AuthException catch (error) {
    return Response(int.parse(error.statusCode.toString()),
        body: error.message);
  } on PostgrestException catch (error) {
    return Response.badRequest(
        body: RequestAuthHandlerUtils.handleErrors(error));
  } catch (error) {
    print(error);
    return Response.internalServerError(
        body: 'An unknown error occurred test    ');
  }
}
