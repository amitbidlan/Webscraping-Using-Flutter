import 'package:flutter/material.dart';
import 'package:monitors/models/monitor.dart';
import 'package:monitors/repo/monitor_repo.dart';

class MonitorProvider extends ChangeNotifier {
  final MonitorsRepo monitorsRepo;

  MonitorProvider(this.monitorsRepo);
  List<Monitor> monitors = [];
  bool isLoaded = false;
  getMonitors(String url) async {
    monitors = await monitorsRepo.getMonitors(url);
    notifyListeners();
  }
}
