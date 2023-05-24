// import 'package:ward/utils/global.dart';
//
// import '../../dio/dio_client.dart';
// import '../../models/all_address_model.dart';
//
// class AllAddressApi {
//   late final DioClient dioClient;
//   AllAddressApi(this.dioClient);
//   Future<List<OrdersCheack>> getAllAddress() async {
//     try {
//       final response = await dioClient.dio.get('api/orders_rate/$userId');
//       var data = OrdersCheack.asListFromJson(response.data);
//
//       return data;
//     } catch (e) {
//       print(e);
//       return Future.error(e);
//     }
//   }
// }
