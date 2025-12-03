import 'package:demo/Bloc/Event.dart';
import 'package:demo/Bloc/State.dart';
import 'package:demo/Network/Api_Service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';





// For JWT
// LoginBloc.dart


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginPressed);
  }

  Future<void> _onLoginPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) async {

    emit(LoginLoading());

    print("Calling login API with email: $event.email, password: $event.password");

    try {
      final response = await ApiService.loginApi(
        email: event.email,
        password: event.password,
      );

      print("bloc response ${response}");

      if (response['success'] == true) {
        final token = response['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", token);
        
        print("token save by sharedPref");
        
        emit(LoginSuccess(token: token));
      } else {
        emit(LoginFailed(error: response['message'].toString()));
      }
    } catch (e) {
      emit(LoginFailed(error: "Error: ${e.toString()}"));
    }
  }
}


class FetchBloc extends Bloc<fetchDetailsEvent, FetchState>{
  FetchBloc():super(FetchInitial()){
    on<FetchEvent>(_onFetchFunction);
  }

  Future<void> _onFetchFunction(FetchEvent event, Emitter <FetchState> emit)async{
    emit(FetchInitial());

    try{
    
      emit(FetchLoading());
    
      final response = await ApiService.fetchApi();


      print("response in bloc page ${response}");

      if(response!['success'] ==true ){
        emit(FetchSuccess(data: response['data']['users']));
      } else if (response!['success'] == false){
        emit(FetchFailed(error: "Failed to fetch"));
      }
    } catch(e){
      emit(FetchFailed(error: "Error is ${e.toString()}"));
    }
  }
}