//import 'dart:async';

//import 'package:flutter/cupertino.dart';
/*
class SessionTimeOutListner extends StatefulWidget {
  Widget child;
  Duration duration;
  VoidCallback onSessionTimeOut;

  SessionTimeOutListner({super.key, required this.child, required this.duration, required this.onSessionTimeOut});

  @override
  State<SessionTimeOutListner> createState() => _SessionTimeOutListnerState();
}

class _SessionTimeOutListnerState extends State<SessionTimeOutListner> {
  Timer? _timer;
  _startTimer()
  {
   print("Timer reset");
    if(_timer!=null)
      {
        _timer?.cancel();
        _timer=null;
      }
    _timer =Timer(widget.duration, () {
      print("Elapsed");
      widget.onSessionTimeOut();
    });
  }
  @override
  void initState() {
    _startTimer();
    super.initState();
  }
  @override
  void dispose() {
    if(_timer!=null)
    {
      _timer?.cancel();
      _timer=null;
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_)
      {
        _startTimer();
      },
      child: widget.child,
    );
  }
}

*/

