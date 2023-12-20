import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../configuration/supabase.dart';

class RequestAuthHandlerUtils {
  static final supabase = SupabaseIntegration.instant;
//////////////////////////////////
  static Future<Map> decodeRequestBody(Request req) async {
    return json.decode(await req.readAsString());
  }

///////////////////////////////////
  static void checkBody({
    required List<String> keysCheck,
    required Map body,
  }) {
    final List<String> keysNotFound = [];

    for (var element in keysCheck) {
      if (!body.containsKey(element)) {
        keysNotFound.add(element);
      }
    }
    if (keysCheck.length != body.length) {
      throw FormatException("The body should have these keys: $keysCheck");
    }
    if (keysNotFound.isNotEmpty) {
      throw FormatException("The body should have these keys: $keysNotFound");
    }
  }

////////////////////////////
  static Future<AuthResponse> createAndSignInUser(
    Map body,
  ) async {
    await supabase!.auth.admin.createUser(AdminUserAttributes(
        email: body["email"], password: body["password"], emailConfirm: true));
    AuthResponse user = await supabase!.auth
        .signInWithPassword(email: body["email"], password: body["password"]);
    body.remove("password");
    try {
      await supabase?.from('users').insert({
        "name": body['name'],
        "email": body['email'],
        "user_id": user.user!.id
      });
    } catch (e) {
      print('Error inserting user details: $e');
    }
    return user;
  }

//////////////////////////////////////////////
  static Future<void> insertUserDetails(Map body) async {
    await supabase?.from('users').insert(body);
  }

/////////
  static Response buildSuccessResponse(AuthResponse user) {
    return Response.ok(
        json.encode({
          "message": "Account Created Successfully",
          "token": user.session?.accessToken,
          "refreshToken": user.session?.refreshToken,
          "expires_at": user.session?.expiresAt,
          "token_type": user.session!.tokenType
        }),
        headers: {"Content-Type": "application/json"});
  }

  static Response handleErrors(dynamic error) {
    if (error is FormatException) {
      return Response.badRequest(body: error.message);
    } else if (error is AuthException) {
      return Response(int.parse(error.statusCode.toString()),
          body: error.message);
    } else if (error is PostgrestException) {
      return Response.badRequest(body: _getPostgrestErrorMessage(error));
    } else {
      return Response.internalServerError(body: 'An unknown error occurred');
    }
  }

  static String _getPostgrestErrorMessage(PostgrestException error) {
    if (error.code == "PGRST204") {
      return "There is an error with the password";
    }
    return 'Database error: ${error.message}';
  }

  ///
  static Future<AuthResponse> signInUser(Map body) async {
    return await supabase!.auth
        .signInWithPassword(email: body["email"], password: body["password"]);
  }

  ///////////
  static Future<Map<String, dynamic>> fetchUserInfoByEmail(String email) async {
    final response =
        await supabase?.from('users').select().eq('email', email).single();
    return response ?? {};
  }

  static Future<void> deleteUserAccount(String email) async {
    final userInfo = await fetchUserInfoByEmail(email);
    final uuid = userInfo['user_id'];
    if (uuid == null) {
      throw Exception('User not found for the provided email.');
    }
    await supabase?.from('users').delete().eq('email', email);
    await supabase?.auth.admin.deleteUser(uuid);
  }

  ////////////////
  static Future<void> updateUserInfo(
      String email, Map<String, dynamic> updates) async {
    await supabase?.from('users').update(updates).eq('email', email);
  }

  static Future<void> updateAuthUserEmail(
      String oldEmail, String newEmail) async {
    final userInfo = await fetchUserInfoByEmail(oldEmail);
    final uuid = userInfo['user_id'];
    if (uuid == null) {
      throw Exception('User not found for the provided email.');
    }
    await supabase?.auth.admin
        .updateUserById(uuid, attributes: AdminUserAttributes(email: newEmail));
  }
}
