import 'package:shelf_router/shelf_router.dart';

import '../handlers/public_handlers/get_profile_handler.dart';
import '../handlers/public_handlers/get_uint_image_handler.dart';

class PublicRoute {
  Router get route {
    return Router()
      ..get("/teachers", getPublicDataHandler)
      ..get("/image-Uint8List", getUintImageHandler);
  }
}
