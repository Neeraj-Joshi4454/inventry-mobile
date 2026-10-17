import 'package:dio/dio.dart';
import '../../../core/network/api_exception.dart';
import 'models/app_notification.dart';

class NotificationApi {
  NotificationApi(this._dio);

  final Dio _dio;

  Future<({List<AppNotification> notifications, int unreadCount})> listNotifications({
    int page = 1,
    bool unreadOnly = false,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/notifications',
        queryParameters: {'page': page, 'limit': 20, if (unreadOnly) 'unreadOnly': true},
      );
      final data = response.data!['data'] as Map<String, dynamic>;
      final notifications = (data['notifications'] as List<dynamic>)
          .map((e) => AppNotification.fromJson(e as Map<String, dynamic>))
          .toList();
      return (notifications: notifications, unreadCount: (data['unreadCount'] as num).toInt());
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> markRead(String id) async {
    try {
      await _dio.patch<void>('/notifications/$id/read');
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }

  Future<void> markAllRead() async {
    try {
      await _dio.patch<void>('/notifications/read-all');
    } on DioException catch (e) {
      throw mapDioException(e);
    }
  }
}
