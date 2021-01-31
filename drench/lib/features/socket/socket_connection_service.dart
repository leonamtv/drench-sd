import 'package:drench/features/socket/connection_params_model.dart';

class SocketConnectionService {
  void connect(ConnectionParams connectionParams) {
    print(connectionParams.toJson());
  }
}
