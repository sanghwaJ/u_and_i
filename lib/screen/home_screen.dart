import 'package:flutter/cupertino.dart'; // iOS와 비슷한 디자인을 사용할 때 import
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime now = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[100], // 밝기 default 500
      // SafeArea => 노치를 가리지 않도록 지정
      body: SafeArea(
        // 아래 부분만 SafeArea를 적용하지 않도록 지정
        bottom: false,
        child: Container(
          // MediaQuery => 아래의 Column을 화면 중앙으로 이동 (가로 기준)
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              _TopPart(
                now: now,
                selectedDate: selectedDate,
                onPressed: onHeartPressed,
              ),
              _BottomPart(),
            ],
          ),
        ),
      ),
    );
  }

  void onHeartPressed(){
      // dialog (팝업과 비슷..?)
      showCupertinoDialog(
        // iOS와 비슷한 디자인을 사용할 때 import
        context: context,
        // dialog 바깥을 클릭하면 dialog가 닫힘
        barrierDismissible: true, // default는 false
        // showCupertinoDialog는 builder가 있어야 widget을 만들 수 있음
        builder: (BuildContext context) {
          // Flutter의 특징 => 만일 특정 widget이 어디에 정렬해야할지 알 수 없으면 최대한의 사이즈를 차지함
          // 그럴땐, 아래처럼 Align을 사용하면 됨
          return Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              height: 300.0,
              // iOS DatePicker
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                // 초기 DateTime 지정
                initialDateTime: selectedDate,
                // 최대 설정 가능한 DateTime 지정
                maximumDate: DateTime(
                  now.year,
                  now.month,
                  now.day,
                ),
                // 날짜나 시간이 바뀌었을 때 on 함수
                onDateTimeChanged: (DateTime date) {
                  // 변수를 변경할 때, build를 다시 실행할 땐 => setState
                  setState(() {
                    selectedDate = date;
                  });
                },
              ),
            ),
          );
        },
      );
  }
}

// private 선언
class _TopPart extends StatelessWidget {
  final DateTime now;
  final DateTime selectedDate;
  final VoidCallback onPressed;

  // 생성자
  _TopPart({required this.now, required this.selectedDate, required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 위젯 트리 상 가장 가까운 theme을 가져옴
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;


    // Expanded => 현재 차지할 수 있는 최대한으로 크기 지정
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'U&I',
            style: textTheme.displayLarge,
          ),
          Column(
            children: [
              Text(
                '우리 처음 만난 날',
                style: textTheme.bodyMedium,
              ),
              Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate.day}',
                style: textTheme.bodySmall,
              ),
            ],
          ),
          IconButton(
            iconSize: 60.0,
            onPressed: onPressed,
            icon: Icon(
              // 하트 아이콘
              Icons.favorite,
              color: Colors.red,
            ),
          ),
          Text(
            'D ${returnDateCal(now, selectedDate)}',
            style: textTheme.displayMedium,
          ),
        ],
      ),
    );
  }

  String returnDateCal(DateTime now, DateTime selectedDate) {
    int dateCal = now.difference(selectedDate).inDays + 1;

    if (dateCal < 0) {
      return '- ${dateCal.abs().toString()}';
    }
    return '+ ${dateCal.toString()}';
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Expanded => 현재 차지할 수 있는 최대한으로 크기 지정
    return Expanded(
      child: Image.asset(
        'asset/img/middle_image.png',
      ),
    );
  }
}
