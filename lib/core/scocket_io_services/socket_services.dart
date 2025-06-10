import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import '../cache_helper/cache_helper.dart';

enum SocketType { chat, notifications }

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() => _instance;

  SocketService._internal();

  late io.Socket chatSocket;
  // late io.Socket notificationsSocket;

  static String baseUrl = '${dotenv.env['API_BASE_URL']}';

  final chatSocketUrl = '$baseUrl/chat';
  // final notificationsSocketUrl = '$baseUrl/notification';

  void init() {
    chatSocket = io.io(
      chatSocketUrl,
      io.OptionBuilder()
          .setTransports(['websocket']) // required for Flutter
          .setExtraHeaders({
            'authorization': 'Bearer ${CacheHelper.token}'
          }) // <-- pass token here
          .disableAutoConnect()
          .build(),
    );
    // notificationsSocket = io.io(
    //   notificationsSocketUrl,
    //   io.OptionBuilder()
    //       .setTransports(['websocket']) // required for Flutter
    //       .setExtraHeaders({
    //         'authorization': 'Bearer ${CacheHelper.token}'
    //       }) // <-- pass token here
    //       .disableAutoConnect()
    //       .build(),
    // );

    chatSocket.connect();
    // notificationsSocket.connect();
    chatSocket.onConnect((_) {
      log('✅ Connected to Chat Socket');
    });
    // notificationsSocket.onConnect((_) {
    //   log('✅ Connected to Notifications Socket');
    // });
    //
    // chatSocket.onDisconnect((_) {
    //   print('❌ Disconnected from $baseUrl');
    // });
    //
    chatSocket.onError((data) {
      print('⚠️ Socket Error: $data');
    });
    // notificationsSocket.onError((data) {
    //   print('⚠️ Socket Error: $data');
    // });
    //
    // chatSocket.onReconnect((_) => print('🔄 Reconnecting...'));
    // chatSocket.onReconnectError((data) => print('❌ Reconnect error: $data'));
    // chatSocket.onReconnectAttempt((data) => print('🔁 Reconnect attempt: $data'));
  }

  void emit(String event, dynamic data, [SocketType type = SocketType.chat]) {
    // if (type == SocketType.notifications) {
    //   notificationsSocket.emit(event, data);
    //   return;
    // }
    chatSocket.emit(event, data);
  }

  void on(String event, Function(dynamic) handler,
      [SocketType type = SocketType.chat]) {
    // if (type == SocketType.notifications) {
    //   notificationsSocket.on(event, handler);
    //   return;
    // }
    chatSocket.on(event, handler);
  }

  void disconnect([SocketType type = SocketType.chat]) {
    // if (type == SocketType.notifications) {
    //   notificationsSocket.disconnect();
    //   return;
    // }
    chatSocket.disconnect();
  }

  void reconnect([SocketType type = SocketType.chat]) {
    // if (type == SocketType.notifications) {
    //   notificationsSocket.connect();
    //   return;
    // }
    chatSocket.connect();
  }

  bool getStatus([SocketType type = SocketType.chat]) {
    // if (type == SocketType.notifications) {
    //   return notificationsSocket.connected;
    // }
    return chatSocket.connected;
  }
}
