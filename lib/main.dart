import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/services.dart';

void main() {
  runApp(const SLC());
}

class SLC extends StatelessWidget {
  const SLC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '물리량 계산기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Menu(),
    );
  }
}

class Menu extends StatefulWidget {

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('물리량 계산기')),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Material(
                elevation:10,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ Text('별 수명 계산기', style: TextStyle(fontSize: 20)),
                    ElevatedButton(onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => StarLife() ),), child: Text('이동')),
                  ]
                  ),
                ),
              ),

            ],
          ),
        )
    );
  }
}




class StarLife extends StatefulWidget {

  @override
  State<StarLife> createState() => _StarLifeState();
}

class _StarLifeState extends State<StarLife> {
  TextEditingController starmass = TextEditingController();
  TextEditingController starradius = TextEditingController();
  TextEditingController startemper = TextEditingController();

  dynamic L = 0;
  dynamic E = 0;
  dynamic SL = 0;
  dynamic SLY = 0;
  dynamic ET = 0;
  double M = 0;
  double T = 0;
  double R = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('별 수명 계산기')),
      ),
      body: Column(
        children: [
          Container(height: 10),
          Material(
            elevation:8,
            child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(height: 10),
                      Container(child: Text('별의 정보', style: TextStyle(fontSize: 20)),),
                      Container(height: 15),
                      Container(
                        child: Row( children: [Text('별의 질량 : ', style: TextStyle(fontSize: 18)), Container(width: 10),
                          Flexible(child: Container(child: Padding(child: TextField(inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9e+-]')),
                          ],
                            controller: starmass, decoration: InputDecoration(hintText: '이 별은 얼마나 무거운가요?',),), padding: EdgeInsets.only(left:10, right: 10)))),
                          Text('Kg', style: TextStyle(fontSize: 18)), Container(width: 20),],),
                      ),
                      Container(height: 15),
                      Container(
                        child: Row( children: [Text('별의 반지름 : ', style: TextStyle(fontSize: 18)), Container(width: 10),
                          Flexible(child: Container(child: Padding(child: TextField(inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9e+-]')),
                            ], controller: starradius, decoration: InputDecoration(hintText: '이 별은 얼마나 큰가요?',),), padding: EdgeInsets.only(left:10, right: 10)))),
                          Text('Km', style: TextStyle(fontSize: 18)), Container(width: 20),],),
                      ),
                      Container(height: 15),
                      Container(
                        child: Row( children: [Text('별의 표면온도 : ', style: TextStyle(fontSize: 18)), Container(width: 10),
                          Flexible(child: Container(child: Padding(child: TextField(inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9e+-]')),
                          ], controller: startemper, decoration: InputDecoration(hintText: '이 별은 얼마나 뜨거운가요?',),), padding: EdgeInsets.only(left:10, right: 10)))),
                          Text('K ', style: TextStyle(fontSize: 18)), Container(width: 28),],),
                      ),

                      Container(height: 30),
                      Container(child: Column(children: [ Row(children: [Text('핵융합 질량 결손 비율 : 0.7%', style: TextStyle(fontSize: 13))],), Container(height: 5), Row(children: [Text('핵융합 참여 수소 비율 : 10%', style: TextStyle(fontSize: 13))],), Container(height: 5), Row(children: [Text('빛의 속도 : 3 * 10^8 m/s', style: TextStyle(fontSize: 13))],),Container(height: 5), Row(children: [Text('1년 : 3 * 10^7 s,  ', style: TextStyle(fontSize: 13)), Text('π : 3.14', style: TextStyle(fontSize: 13))],)],)),
                      Row(children: [Text('* 입력되는 값을 예시처럼 고쳐주세요 \nex) 3 * 10^7 => 3e+7 (e+n = 10^n)', style: TextStyle(fontSize: 13)),],),
                    ]
                )
            ),
          ),
          Container(height: 25),
          SizedBox(
            height: 40,
            width: 40,
            child: IconButton(onPressed: () =>
                setState(() {
                  R = double.parse(starradius.value.text);
                  M = double.parse(starmass.value.text);
                  T = double.parse(startemper.value.text);
                  L = Star_light(R, T);
                  dynamic c = 3 * pow(10, 8);
                  E = 0.007 * 0.1 * M * pow(c, 2);
                  ET = 5.670 * pow(10, -8) * pow(T, 4);
                  SL = Star_life(E, L);
                  dynamic Y = 3 * pow(10, 7);
                  SLY = SL / Y;

                }),
                icon: Icon(Icons.arrow_downward_rounded, size: 35, color: Colors.blue)),
          ),
          Container(height: 30),
          Material(
            elevation:8,
            child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(height: 10),
                      Container(child: Text('이 별은...', style: TextStyle(fontSize: 20)),),
                      Container(height: 25),
                      Container(
                        child: Row( children: [Text('광도가 ${L} W 이고 ', style: TextStyle(fontSize: 18)), Container(width: 10),
                        ],),
                      ),
                      Container(height: 25),
                      Container(
                        child: Row( children: [Text('단위 시간당 방출 에너지는 \n${ET} W * m^-2 이고', style: TextStyle(fontSize: 18)), Container(width: 10),
                        ],),
                      ),
                      Container(height: 25),
                      Container(
                        child: Row( children: [Text('수명이 ${SL} 초 \n또는 ${SLY} 년 입니다.', style: TextStyle(fontSize: 18)), Container(width: 10),
                        ],),
                      ),
                      Container(height: 20),
                    ]
                )
            ),
          ),

        ],
      ),
    );
  }
}


dynamic Star_light(a, b){
  return 4 * 3.14 * pow(a, 2) * 5.670 * pow(10, -8) * pow(b, 4) ;
}

dynamic Star_life(a, b){
  return a/b;
}
