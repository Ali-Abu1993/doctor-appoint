import 'package:flutter_bloc/flutter_bloc.dart';


class NavigationCubit extends Cubit<NavigatioState> {
  NavigationCubit() : super(NavigationInitialState(0));
  int currentIndex=0;

  void changeIndex(int newIndex) { currentIndex=newIndex;
  emit(NavigationInitialState(currentIndex));}
}

class NavigatioState{}
class NavigationInitialState extends NavigatioState{
 final int index;
  NavigationInitialState(this.index);
} 

