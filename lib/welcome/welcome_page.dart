import 'dart:convert';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/models/product.dart';
import 'package:flutter_app_backend/singup_login/sing_in.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _totalDots = 3;
  double _currentPosition = 0.0;

  @override
  void initState() {
    super.initState();
  }

  double _validPosition(double position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1.0;
    return position;
  }

  void _updatePosition(double position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  Widget _buildRow(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets,
      ),
    );
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPosition = _currentPosition.ceilToDouble();
      // _updatePosition(max(--_currentPosition, 0));
      _updatePosition(index.toDouble());
      print(index);
      print(_currentPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height / 2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/background.png"),
                      fit: BoxFit.fill)),
            ),
            _buildRow([
              DotsIndicator(
                dotsCount: _totalDots,
                position: _currentPosition,
                axis: Axis.horizontal,
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
                onTap: (pos) {
                  setState(() => _currentPosition = pos);
                },
              )
            ]),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                      height: 50,
                      bottom: 50,
                      left: (MediaQuery.of(context).size.width - 200) / 2,
                      right: (MediaQuery.of(context).size.width - 200) / 2,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignIn()));
                          },
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color(0xFF7000000),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Get Started',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  ),
                                ],
                              ))))
                ],
            ))
          ],
        ));
  }
}
