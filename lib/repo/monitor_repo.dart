import 'package:monitors/api_call/monitors_api_call.dart';

import '../models/monitor.dart';

class MonitorsRepo {
  final MonitorsCall monitorsCall;

  MonitorsRepo(this.monitorsCall);
  Future<List<Monitor>> getMonitors(String url) async{
   return await monitorsCall.getMonitors(url);
  }
}
