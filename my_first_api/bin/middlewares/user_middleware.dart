import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

Middleware checkToken() => (innerHandler) => (Request req) async {
      try {
        final jwt = JWT.verify(
            req.headers['token']!,
            SecretKey(
                "Dx/SldB6D7ImwpcHEQEQAVOvAoJ/QpY3jxcaodSTR2aO2T/QEy05TB37DfgS7eQkGoXp2spP9Jb32I5I2/Dp/g=="));

        return innerHandler(req);
      } catch (err) {
        return Response.unauthorized(
            "Token is Not Correct or Unavailable -- Try Adding [token] in Headers");
      }
    };
