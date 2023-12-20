import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../config/supabase.dart';
import '../handlers/user_root_handler.dart';

class UserRoute {
  Handler get route {
    final appRoute = Router();
    appRoute.post('/profile', userProfile);

    final handler = Pipeline()
        .addMiddleware(
          (innerHandler) => (Request req) async {
            try {
              if (req.headers["authorization"] == null) {
                return Response.unauthorized("unauthorized, null value");
              }
              final token = req.headers["authorization"]?.split(" ")[1];
              final jwt = JWT.verify(
                  token!,
                  SecretKey(
                      "62dmGL0Csl7roArfUoW3w3Wo0/1zWJ60WElNYrPSoVBJcOox4r43Lcdc4auPxtoc6NHGN2w+3p9A8WrQ5fB04g=="));

              // final user = await SupabaseClass.intense?.auth.getUser(token);

              return innerHandler(req);
            } catch (e) {
              return Response.unauthorized("unauthorized");
            }
          },
        )
        .addHandler(appRoute);

    return handler;
  }
}
