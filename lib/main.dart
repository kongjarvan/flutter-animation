import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnimationPage(),
    );
  }
}

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  var alignment = Alignment.bottomLeft;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: AnimatedAlign(
                alignment: alignment,
                duration: Duration(seconds: 1),
                curve: Curves.bounceOut,
                child: FadeTransition(
                  opacity: _animation,
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  alignment = alignment == Alignment.bottomLeft
                      ? Alignment.topRight
                      : Alignment.bottomLeft;
                  print('clicked');
                });
              },
              child: Container(
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                    color: Color(0xFFFFBA5F),
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: Color(0xFFFF7545), width: 2)),
                child: Center(
                  child: Text('Press to move object'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
