import 'package:flutter_bloc/flutter_bloc.dart';


class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationInitialState(0));
  int currentIndex=0;

  void changeIndex(int newIndex) { currentIndex=newIndex;
  emit(NavigationInitialState(currentIndex));}
}

class NavigationState{}
class NavigationInitialState extends NavigationState{
 final int index;
  NavigationInitialState(this.index);
} 

