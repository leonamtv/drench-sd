import 'package:drench/features/multiplayer/socket/connection_params.model.dart';

class SocketConnectionService {
  void connect(ConnectionParams connectionParams) {
    print(connectionParams.toJson());
  }
}
