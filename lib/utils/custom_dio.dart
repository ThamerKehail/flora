// import 'package:dio/dio.dart';
//
// class CustomDio {
//   late Dio _dio;
//   Future<Response> send(
//       {required String reqMethod,
//       required String path,
//       Function(int count, int total)? onSendProgress,
//       Function(int count, int total)? onReceiveProgress,
//       CancelToken? cancelToken,
//       Map<String, dynamic> body = const <String, dynamic>{},
//       Map<String, dynamic> query = const <String, dynamic>{},
//       String? saveDirPath}) async {
//     late Response res;
//
//     final _body = {}..addAll(body);
//     final _query = {}..addAll(query);
//
//     try {
//       switch (reqMethod.toUpperCase()) {
//         case 'POST':
//           res = await _dio.post(
//             path,
//             data: _body.cast(),
//             onReceiveProgress: onReceiveProgress,
//             onSendProgress: onSendProgress,
//             cancelToken: cancelToken,
//             queryParameters: _query.cast(),
//           );
//           break;
//         case 'PUT':
//           res = await _dio.put(
//             path,
//             data: _body.cast(),
//             onSendProgress: onSendProgress,
//             onReceiveProgress: onReceiveProgress,
//             cancelToken: cancelToken,
//             queryParameters: _query.cast(),
//           );
//           break;
//         case 'PATCH':
//           res = await _dio.patch(
//             path,
//             data: _body.cast(),
//             onSendProgress: onSendProgress,
//             onReceiveProgress: onReceiveProgress,
//             cancelToken: cancelToken,
//             queryParameters: _query.cast(),
//           );
//           break;
//         case 'DELETE':
//           res = await _dio.delete(
//             path,
//             data: _body.cast(),
//             cancelToken: cancelToken,
//             queryParameters: _query.cast(),
//           );
//           break;
//
//         case 'DOWNLOAD':
//           res = await _dio.download(
//             path,
//             saveDirPath,
//             cancelToken: cancelToken,
//             onReceiveProgress: onReceiveProgress,
//             queryParameters: _query.cast(),
//           );
//
//           break;
//         default:
//           throw ("reqMethod Not available ! ");
//       }
//
//       return res;
//     } on DioError catch (err) {
//       if (err.type == DioErrorType.other ||
//           err.type == DioErrorType.connectTimeout ||
//           err.type == DioErrorType.receiveTimeout ||
//           err.type == DioErrorType.sendTimeout) {}
//       rethrow;
//     } finally {
//       _dio.close();
//     }
//   }
// }
