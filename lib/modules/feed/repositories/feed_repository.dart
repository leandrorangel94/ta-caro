import 'package:ta_caro/shared/models/order_model.dart';

abstract class IFeedRepository {
  Future<List<OrderModel>> getAll();
}
