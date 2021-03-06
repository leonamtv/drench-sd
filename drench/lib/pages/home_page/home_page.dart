import 'package:drench/features/drench_game/drench_multiplayer/drench_multiplayer_connection_service.dart';
import 'package:drench/features/multiplayer/components/connection_dialog/connection_dialog_service.dart';
import 'package:drench/features/multiplayer/connection_params.model.dart';
import 'package:drench/features/drench_game/drench_component.dart';
import 'package:drench/features/drench_game/drench_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ConnectionDialogService _connectionDialogService =
      ConnectionDialogService();

  final DrenchMultiplayerConnectionService _drenchMultiplayerConnectionService =
      DrenchMultiplayerConnectionService();

  final DrenchController drenchController = DrenchController();

  _HomePageState() {
    this
        .drenchController
        .setMultiplayerConnectionService(_drenchMultiplayerConnectionService);
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
        this.drenchController.newGame(true);
      },
    );
  }

  Widget _body() {
    return DrenchComponent(controller: drenchController);
  }

  void showConnectionDialog() async {
    ConnectionParams connectionParams =
        await _connectionDialogService.show(this.context);

    if (connectionParams == null) {
      return;
    }

    this._drenchMultiplayerConnectionService.connect(connectionParams);
  }
}
