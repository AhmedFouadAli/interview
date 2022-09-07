import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interviewquestion/data.dart';
import 'package:meta/meta.dart';

part 'statecande_state.dart';

class StatecandeCubit extends Cubit<StatecandeState> {
  StatecandeCubit() : super(StatecandeInitial());
      static StatecandeCubit getInstance(context) => BlocProvider.of(context);


   void addAvalibility(String dateTime) {
    StoreData.addAvalibility(dateTime);
        emit(StatecandeUpdateDate());


   }
  void reserved(){
    emit(StatecandeUpdateDate());

  }
}
