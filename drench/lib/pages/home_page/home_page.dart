import 'package:drench/features/multiplayer/components/connection_dialog/connection_dialog_service.dart';
import 'package:drench/features/multiplayer/socket/connection_params.model.dart';
import 'package:drench/features/multiplayer/socket/socket_connection_service.dart';
import 'package:drench/pages/home_page/components/drench/drench.dart';
import 'package:drench/pages/home_page/components/drench/drench_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ConnectionDialogService _connectionDialogService =
      ConnectionDialogService();

  final SocketConnectionService _socketConnectionService =
      SocketConnectionService();

  final DrenchController drenchController = DrenchController();

  _HomePageState() {
    this.drenchController.setSocketConnectionService(_socketConnectionService);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Drench"),
      actions: _appBarActions(),
    );
  }

  List<Widget> _appBarActions() {
    return [
      _connectToDeviceActionButton(),
      _newGameActionButton(),
    ];
  }

  IconButton _connectToDeviceActionButton() {
    return IconButton(
      icon: Icon(
        Icons.offline_share,
        color: Colors.white,
      ),
      onPressed: this.showConnectionDialog,
    );
  }

  IconButton _newGameActionButton() {
    return IconButton(
      icon: Icon(
        Icons.refresh,
        color: Colors.white,
      ),
      onPressed: () {
        this.drenchController.newGame();
      },
    );
  }

  Widget _body() {
    return Drench(controller: drenchController);
  }

  void showConnectionDialog() async {
    ConnectionParams connectionParams =
        await _connectionDialogService.show(this.context);

    if (connectionParams == null) {
      return;
    }

    this._socketConnectionService.connect(connectionParams);
  }
}
