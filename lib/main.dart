import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  TestPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  TestPageState createState() => new TestPageState();
}

class TestPageState extends State<TestPage> {
  List<LatLng> marks = [LatLng(31, 114)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        toolbarHeight: 0,
      ),
      body: FlutterMap(
        options: MapOptions(
            center: LatLng(31, 114),
            minZoom: 1,
            maxZoom: 18,
            onTap:( tapPosition,  point){
              print(point);
            },
            onLongPress:( tapPosition,  point){
              print('添加成功');
              setState(() {
                marks.add(point);
              });

            }
        ),
        nonRotatedChildren: [
          TileLayerWidget(
            options: TileLayerOptions(
              urlTemplate:
              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
              backgroundColor: const Color(0x00000000),
              maxNativeZoom: 18,
            ),
          ),
          Center(child: Icon(Icons.add),),
          MarkerLayerWidget(options: MarkerLayerOptions(markers: marks.map((e) => Marker(builder: (BuildContext context) {
            return  Icon(Icons.add,color: Colors.red,);
          }, point: e)).toList()))
        ],
      ),
    );
  }


}
