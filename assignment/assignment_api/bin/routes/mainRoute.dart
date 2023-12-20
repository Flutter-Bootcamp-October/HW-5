import 'package:content_length_validator/content_length_validator.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_helmet/shelf_helmet.dart';
import 'package:shelf_rate_limiter/shelf_rate_limiter.dart';
import 'package:shelf_router/shelf_router.dart';

import 'authRoute.dart';
import 'userRoute.dart';

class MainRoute {
  Handler get route {
    final appRoutes = Router();
    appRoutes
      ..get("/", (Request req) {
        return Response.ok("body");
      })
      ..mount('/user', UserRoutes().route)
      ..mount('/auth', AuthRoutes().route)
      ..all('/<ignore|.*>', (Request req) {
        return Response.notFound("Sorry not found you page");
      });

    final memoryStorage = MemStorage();
    final rateLimiter = ShelfRateLimiter(
        storage: memoryStorage,
        duration: Duration(seconds: 60),
        maxRequests: 15);

    final pipeline = Pipeline()
        .addMiddleware(rateLimiter.rateLimiter())
        .addMiddleware(helmet())
        .addMiddleware(
          maxContentLengthValidator(
            maxContentLength: 1 * 1024 * 1024,
          ),
        )
        .addHandler(appRoutes);
    return pipeline;
  }
}
