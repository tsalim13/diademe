import 'package:diademe/Bloc/AddUser/add_user_event.dart';
import 'package:diademe/Bloc/AddUser/add_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUserBloc extends Bloc<AddSalerEvent, AddSalerState> {
  
  AddUserBloc() : super(AddNewSalerState());

  @override
  Stream<AddSalerState> mapEventToState(event) async* {
    if (event is AddNewSalerEvent) {
      
    }
    
  }
}