import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_app/provider/user_provider.dart';
import 'package:gym_app/result.dart';
import 'package:gym_app/screens/calendar_screen.dart';
import 'package:gym_app/screens/changePw.dart';
import 'package:gym_app/screens/find_id_screen.dart';
import 'package:gym_app/screens/find_pw_screen.dart';
import 'package:gym_app/screens/home_screen.dart';
import 'package:gym_app/screens/join.dart';
import 'package:gym_app/screens/login.dart';
import 'package:gym_app/screens/my_page.dart';
import 'package:gym_app/screens/my_page_info.dart';
import 'package:gym_app/screens/pay_screen.dart';
import 'package:gym_app/screens/ptList_screen.dart';
import 'package:gym_app/screens/ptTicket_screen.dart';
import 'package:gym_app/screens/reservation_insert_screen.dart';
import 'package:gym_app/screens/ticketList_screen.dart';
import 'package:gym_app/screens/ticket_screen.dart';
import 'package:gym_app/screens/trainer_screen.dart';
import 'package:provider/provider.dart';

//  메인 수정했을지도?
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ✅ 필수!
  // 먼저 UserProvider 인스턴스를 생성한 후 autoLogin 호출
  final userProvider = UserProvider();
  await userProvider.autoLogin(); // autoLogin을 여기서 먼저 실행합니다.

  runApp(
    ChangeNotifierProvider(
      create: (context) => userProvider, // 생성한 userProvider를 Provider로 전달
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '네비게이션 위젯',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/pay': (context) => PayScreen(),
        '/result': (context) => ResultPage(),
        '/home': (context) => HomeContent(),
        '/ticket': (context) => TicketScreen(),
        '/trainer': (context) => TrainerScreen(),
        '/reservationInsert': (context) => ReservationInsertScreen(),
        '/ptList': (context) => PtlistScreen(),
        '/calendar': (context) => CalendarScreen(),
        '/ptTicket': (context) => PtTicketScreen(),
        '/login': (context) => Login(),
        '/join': (context) => Join(),
        '/findId': (context) => FindIdScreen(),
        '/findPw': (context) => FindPwScreen(),
        '/changePw': (context) => Changepw(),
        '/myPage': (context) => MyPage(),
        '/myPageInfo': (context) => MyPageInfo(),
        '/ticketList': (context) => TicketlistScreen()
      },
    );
  }
}
