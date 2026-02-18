import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MaterialApp(home: KingTapNative()));

class KingTapNative extends StatefulWidget {
  @override
  _KingTapNativeState createState() => _KingTapNativeState();
}

class _KingTapNativeState extends State<KingTapNative> with TickerProviderStateMixin {
  // بيانات اللعبة المستخرجة من كودك
  int gold = 0;
  int pwr = 1;
  int seconds = 0;

  // قائمة التطويرات كما وردت في الكود الخاص بك
  List<Map<String, dynamic>> upgrades = [
    {'name': "خنجر خشبي", 'cost': 50, 'gain': 2, 'req': 0},
    {'name': "سيف فولاذي", 'cost': 500, 'gain': 10, 'req': 1000},
    {'name': "فأس ذهبي", 'cost': 5000, 'gain': 50, 'req': 10000},
    {'name': "درع المليار", 'cost': 100000, 'gain': 500, 'req': 50000},
  ];

  @override
  void initState() {
    super.initState();
    // عداد الوقت المستخرج من منطق لعبتك
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() => seconds++);
    });
  }

  void handleTap() {
    setState(() {
      gold += pwr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E293B), // نفس روح ألوان متجرك
      appBar: AppBar(
        title: Text('نقرة الملك 👑 Native'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // لوحة المعلومات (Info Bar)
          Text('$gold', style: TextStyle(fontSize: 70, color: Colors.amber, fontWeight: FontWeight.bold)),
          Text('وقت اللعب: ${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}', style: TextStyle(color: Colors.white70)),
          Text('القوة: $pwr ⚔️', style: TextStyle(fontSize: 18, color: Colors.white)),
          
          SizedBox(height: 40),
          
          // الزر الرئيسي (العملة)
          GestureDetector(
            onTap: handleTap,
            child: Container(
              width: 180, height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [Colors.yellow, Colors.orange.shade800]),
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 15, offset: Offset(0, 8))],
                border: Border.all(color: Color(0Box78350F), width: 6),
              ),
              child: Center(child: Text('🪙', style: TextStyle(fontSize: 80))),
            ),
          ),
          
          SizedBox(height: 40),

          // قائمة المتجر (Upgrades)
          Expanded(
            child: ListView.builder(
              itemCount: upgrades.length,
              itemBuilder: (context, i) {
                bool canBuy = gold >= upgrades[i]['cost'];
                bool isLocked = gold < upgrades[i]['req'];
                return Opacity(
                  opacity: isLocked ? 0.3 : 1.0,
                  child: Card(
                    color: Color(0xFF334155),
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: ListTile(
                      title: Text(upgrades[i]['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      subtitle: Text('${upgrades[i]['cost']} 💰 | +${upgrades[i]['gain']} قوة', style: TextStyle(color: Colors.amber)),
                      trailing: ElevatedButton(
                        onPressed: canBuy ? () {
                          setState(() {
                            gold -= upgrades[i]['cost'] as int;
                            pwr += upgrades[i]['gain'] as int;
                            upgrades[i]['cost'] = (upgrades[i]['cost'] * 2).toInt();
                          });
                        } : null,
                        child: Text('تطوير'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
