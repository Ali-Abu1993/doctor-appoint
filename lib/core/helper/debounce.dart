import 'dart:async';
import 'dart:ui';

class Debounce {
 final int milliseconds;
  Timer? timer;

  Debounce({this.milliseconds=500});

  void call(VoidCallback action ){
timer?.cancel();
timer=
Timer(Duration(milliseconds: milliseconds),action );
  }
  void cancel(){
    timer?.cancel();
  }
  void dispose(){
    timer?.cancel();
    timer=null;
  }
}