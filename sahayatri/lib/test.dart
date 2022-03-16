import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';

import 'package:dio/dio.dart' as Dio;
import 'package:sahayatri/services/dio_services.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final TextEditingController _controller = TextEditingController();
  String data = 'From testing page.';
  late PusherClient pusher;
  late Channel channel;
  String token = '87|iLlsEsVlhHOTHuDbYZnhEBeo06wSgyDXoxGKhPSM';

  void testing() async {
    try {
      Dio.Response response = await dio().post('/broadcasting/auth',
          data: {
            'channel_name': 'private-test.7',
            'socket_id': '9189.30113661'
          },
          options: Dio.Options(headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': '*/*',
          }));
      print(response.data);
    } on Dio.DioError catch (e) {
      print(e.message);
    }
  }

  int a = 1;

  void pushercl() {
    var options = PusherOptions(
      host: 'http://192.168.254.57',
      wsPort: 433,
      cluster: 'ap2',
      encrypted: true,
      auth: PusherAuth(
        'http://192.168.254.57/api/broadcasting/auth',
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      ),
    );

    try {
      pusher = PusherClient(
        '88a5867cc2cf108767c9',
        options,
        enableLogging: true,
      );

      pusher.connect();

      pusher.onConnectionStateChange((state) {
        log('previousState: ${state!.previousState}, currentState: ${state.currentState}');
      });

      pusher.onConnectionError((error) {
        log("error: ${error!.message}");
      });

      channel = pusher.subscribe('private-test.7');

      channel.bind('test-test', (event) {
        displayFlash(context: context, text: event!.data!);
        NotificationHandler.displayNotificaiton(
          title: event.data!,
          body: 'aayo hai aayo',
        );
      });
    } catch (e) {
      print("Error Connecting to Pusher");
    }
  }

  @override
  void initState() {
    super.initState();
    print('initstate');
    NotificationHandler.config();
    pushercl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(data),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: TextFormField(
                  controller: _controller,
                ),
              ),
              IconButton(
                onPressed: () {
                  pushercl();
                  testing();
                  a++;
                  if (a % 2 == 0) {}
                  _sendMessage();
                  setState(() {
                    pusher.disconnect();
                    data = _controller.text;
                  });
                },
                icon: Icon(Icons.ac_unit_outlined),
              ),
              SizedBox(height: 24),
              // StreamBuilder(
              //   stream: channel,
              //   builder: (context, snapshot) {
              //     print('changed');
              //     return Text(
              //         snapshot.hasData ? '${snapshot.data}' : 'No Data');
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      print('hello');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    print('disposed');
    super.dispose();
  }
}
