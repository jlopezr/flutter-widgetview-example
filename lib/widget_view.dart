import 'package:flutter/material.dart';
import 'package:widget_view/widget_view.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'package:widget_view Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'package:widget_view Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  MyHomePageController createState() => MyHomePageController();
}

class MyHomePageController extends State<MyHomePage> {
  int counter = 0;
  String text = "You have pushed the button this many times:";

  void incrementCounter() {
    setState(() {
      counter++;
    });
    if (counter == 10) {
      setText("Eres un pesaico. $text");
    }
  }

  void setText(String t) {
    setState(() {
      text = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return MyHomeExtraPageView(this);
    } else {
      return MyHomePageView(this);
    }
  }
}

class MyHomeExtraPageView
    extends StatefulWidgetView<MyHomePage, MyHomePageController> {
  const MyHomeExtraPageView(MyHomePageController controller, {Key? key})
      : super(controller, key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GestureDetector(
          onTap: controller.incrementCounter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                controller.text,
              ),
              Text(
                '${controller.counter}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePageView
    extends StatefulWidgetView<MyHomePage, MyHomePageController> {
  MyHomePageView(MyHomePageController controller, {Key? key})
      : super(controller, key: key) {
    //controller.setText("Has pulsado el botoncico:"); //TODO Esto se llama cada vez que cambia el estado... con lo cual queda fijo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(controller.text),
            Text(
              '${controller.counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
