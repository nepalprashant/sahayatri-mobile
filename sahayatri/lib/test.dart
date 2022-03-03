import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:sahayatri/Components/flash_bar.dart';
import 'package:sahayatri/Helper_Classes/notification_helper.dart';

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

  void socket() async {}

  void pusher_cl() {
    var options = PusherOptions(
      host: 'http://192.168.254.57',
      cluster: 'ap2',
      encrypted: true,
      auth: PusherAuth(
        'http://192.168.254.57/api/broadcasting/auth',
        headers: {
          'Authorization': 'Bearer 6|KTmsireIOqWrdtwsItgCVUjYhLe7dI7xPfg2dq1t',
          'Content-Type': 'Application/Json',
          'Accept': '*/*'
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

      channel = pusher.subscribe('test');

      pusher.onConnectionStateChange((state) {
        log('previousState: ${state!.previousState}, currentState: ${state.currentState}');
      });

      pusher.onConnectionError((error) {
        log("error: ${error!.message}");
      });

      channel.bind('status-update', (event) {
        log(event!.data!);
      });
      
      channel.bind('test-test', (event) {
        displayFlash(context: context, text: event!.data!);
        NotificaitonHandler.displayNotificaiton(
          title: event.data!,
          body: 'aayo hai aayo',
        );
      });

      channel.bind('order-filled', (event) {
        log("Order Filled Event" + event!.data.toString());
      });
    } catch (e) {
      print("Error Connecting to Pusher");
    }
  }

  @override
  void initState() {
    super.initState();
    print('initstate');
    pusher_cl();
    // laravel();
    //socket io package
    // Dart client
    // IO.Socket socket = IO.io('http://192.168.254.57:6001/api/broadcast');

    // IO.Socket socket = IO.io(
    // 'ws://192.168.254.57:6001/app/pusherkey');
    // socket.connect();

    // socket.onConnect((_) {
    //   print('connect');
    //   socket.emit('msg', 'test');
    // });
    // socket.on('App\Events\Test', (data) => print(data));
    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));
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
                  _sendMessage();
                  setState(() {
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
    channel.cancelEventChannelStream();
    _controller.dispose();
    print('disposed');
    super.dispose();
  }
}
