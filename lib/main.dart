import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Animasyon Ekleme'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Animasyonu Yönetme'),
              ),
            ],
          ),
          title: Text('Lottie Animasyonları'),
        ),
        body: TabBarView(
          children: [
            AnimationImportTab(),
            ControlLottieAnimationTab(),
          ],
        ),
      ),
    );
  }
}

class AnimationImportTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/world_loading.json',
              width: 200,
              height: 200,
            ),
            Lottie.network(
              'https://assets10.lottiefiles.com/datafiles/HN7OcWNnoqje6iXIiZdWzKxvLIbfeCGTmvXmEm1h/data.json',
              width: 200,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}

class ControlLottieAnimationTab extends StatefulWidget {
  @override
  _ControlLottieAnimationTabState createState() =>
      _ControlLottieAnimationTabState();
}

class _ControlLottieAnimationTabState extends State<ControlLottieAnimationTab>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();
  }

  // animasyonu oynatmamızı sağlayan fonksiyon
  _handlePlayAnimation() {
    // animasyon bitmiş mi diye kontrol ediyoruz
    if (_animationController.isCompleted) {
      // eğer bitmişse ve tekrardan butona basmışsak animasyonu tersten oynatıyoruz
      _animationController
        ..duration = Duration(seconds: 1)
        ..reverse();
    } else {
      // eğer bitmemişse ve butona basmışsak animasyonu ileri doğru oynatıyoruz
      _animationController
        ..duration = Duration(seconds: 1)
        ..forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Lottie.asset(
            'assets/drawer_toggle.json',
            controller: _animationController,
          ),
          InkWell(
            // animasyonu butona bastığımızda çağırıyoruz
            onTap: _handlePlayAnimation,
            child: Container(
              color: Colors.blue,
              width: 200,
              height: 50,
              child: Center(
                child: Text(
                  'Animasyonu Oynat',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
