import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:meta/meta.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final InternetConnection _internetConnection;
  StreamSubscription<InternetStatus>? _internetConnectionSubscription;

  InternetCubit(this._internetConnection) : super(const InternetState()) {
    _listenForConnectivityChanges();
  }

  void _listenForConnectivityChanges() {
    _internetConnectionSubscription = _internetConnection.onStatusChange.listen(
      (event) {
        switch (event) {
          case InternetStatus.connected:
            emit(const InternetState(isConnected: true));
            break;
          case InternetStatus.disconnected:
            emit(const InternetState(isConnected: false));
            break;
        }
      },
    );
  }

  @override
  Future<void> close() async {
    await _internetConnectionSubscription?.cancel();
    return super.close();
  }
}
