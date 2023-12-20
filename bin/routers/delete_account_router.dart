import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../handlers/delete_account_handler.dart';
import '../middlewares/check_authority.dart';

class DeleteAccountRouter {
  Handler get deleteAccountRouter {
    final deleteAccountRouter = Router();
    deleteAccountRouter.delete('/', deleteAccount);

    final pipline = Pipeline()
        .addMiddleware(checkAuthority())
        .addHandler(deleteAccountRouter);
    return pipline;
  }
}
