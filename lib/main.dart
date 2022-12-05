import 'package:flutter/material.dart';
import 'package:monitors/api_call/monitors_api_call.dart';
import 'package:monitors/provider/monitor_provider.dart';
import 'package:monitors/repo/monitor_repo.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MonitorsCall monitorsCall;
  late MonitorsRepo monitorsRepo;
  late MonitorProvider monitorProvider;
  @override
  void initState() {
    monitorsCall = MonitorsCall();
    monitorsRepo = MonitorsRepo(monitorsCall);
    monitorProvider = MonitorProvider(monitorsRepo);
    monitorProvider.getMonitors(
        "https://www.sigma-computer.com/category?id=4&cname=Monitors");
    print('Inside Init ${monitorProvider.monitors}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: ChangeNotifierProvider(
      create: (BuildContext context) => monitorProvider,
      child: const HomePage(),
    ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final monitorProvider = Provider.of<MonitorProvider>(context);
    f1(monitorProvider.monitors);
    return Scaffold(
      appBar: AppBar(
        title: Text("APP"),
      ),
      body: Column(children: [
        Expanded(
            child: ListView.builder(
                itemCount: monitorProvider.monitors.length,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      Image.network("https://www.sigma-computer.com/" +
                          monitorProvider.monitors[index].imgUrl),
                      Text(monitorProvider.monitors[index].title),
                      Text(monitorProvider.monitors[index].price.toString())
                    ],
                  );
                })))
      ]),
    );
  }
}

void f1(List list) {
  print('Outside Init ${list.length}');
}
