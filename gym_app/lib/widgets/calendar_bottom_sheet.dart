import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neat_and_clean_calendar/flutter_neat_and_clean_calendar.dart';
import 'package:gym_app/service/calendar_service.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
// import 'package:omni_datetime_picker/omni_datetime_picker.dart';

void showCalendarBottomSheet(BuildContext context, DateTime selectedDate,
    {NeatCleanCalendarEvent? event}) {
  showMaterialModalBottomSheet(
    backgroundColor: const Color.fromARGB(255, 49, 47, 47),
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
    ),
    builder: (context) => CalendarBottomSheet(
        selectedDate: selectedDate, event: event), // selectedDate 전달
  );
}

class CalendarBottomSheet extends StatefulWidget {
  final DateTime selectedDate; // selectedDate를 받아옴
  final NeatCleanCalendarEvent? event;

  const CalendarBottomSheet(
      {super.key,
      required this.selectedDate,
      this.event}); // 생성자에서 selectedDate 받기

  @override
  State<CalendarBottomSheet> createState() => _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  DateTime? startTime;
  DateTime? endTime;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  CalendarService calendarService = CalendarService();

  @override
  void initState() {
    super.initState();
    if (widget.event != null) {
      startTime = widget.event!.startTime;
      endTime = widget.event!.endTime;
      _titleController.text = widget.event?.summary ?? '';
      _descriptionController.text = widget.event?.description ?? '';
    } else {
      startTime = DateTime.now().toLocal();
      endTime = DateTime.now().toLocal().add(Duration(hours: 1));
    }
  }

  void _openTimePicker(BuildContext context, String type) {
    BottomPicker.time(
      pickerTitle: Text(
        type == 'startTime' ? '시작 시간' : '종료 시간',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          // color: Colors.orange,
        ),
      ),
      onSubmit: (index) {
        print(index);
        setState(() {
          type == 'startTime' ? startTime = index : endTime = index;
        });
      },
      use24hFormat: true,
      initialTime: Time(
        hours: (type == 'startTime' ? startTime?.hour : endTime?.hour) ?? 0,
        minutes:
            (type == 'startTime' ? startTime?.minute : endTime?.minute) ?? 0,
      ),
      closeIconSize: 30,
      buttonWidth: 300,
      buttonStyle: BoxDecoration(
          color: Color.fromARGB(255, 159, 208, 213),
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      buttonContent: Text(
        '확인',
        textAlign: TextAlign.center,
        style: TextStyle(
          // color: Colors.white,
          fontSize: 16,
        ),
      ),
      // backgroundColor: Color.fromARGB(255, 49, 47, 47),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // 북마크 스낵바
                      Navigator.pop(context);
                    },
                    child: Text(
                      "취소",
                      style: TextStyle(
                          fontSize: 18,
                          color: const Color.fromARGB(255, 192, 191, 191)),
                    ),
                  ),
                ],
              ),
              Text(
                "${widget.selectedDate.year}년 ${widget.selectedDate.month}월 ${widget.selectedDate.day}일",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              labelText: '일정 제목',
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 159, 208, 213)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              floatingLabelStyle:
                  TextStyle(color: Color.fromARGB(255, 159, 208, 213)),
            ),
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '시작',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  _openTimePicker(context, 'startTime');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  // backgroundColor: HexColor('9FD0D5'),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: Text(
                  startTime != null
                      ? "${startTime!.hour}:${startTime!.minute.toString().padLeft(2, '0')}"
                      : '시작 시간 선택',
                ),
              ),
              // Expanded(
              //   child:
              // ),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '종료',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  _openTimePicker(context, 'endTime');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  // backgroundColor: HexColor('9FD0D5'),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: Text(
                  endTime != null
                      ? "${endTime!.hour}:${endTime!.minute.toString().padLeft(2, '0')}"
                      : '종료 시간 선택',
                ),
              ),
              // Expanded(
              //   child:
              // ),
            ],
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: '일정 내용',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.white),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 159, 208, 213)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              floatingLabelStyle:
                  TextStyle(color: Color.fromARGB(255, 159, 208, 213)),
            ),
            style: TextStyle(color: Colors.white),
            maxLines: 6,
          ),
          SizedBox(height: 16.0),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child:
          // ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (widget.event == null) {
                  bool result = await calendarService.insertPlan({
                    "planTime": startTime?.toIso8601String(),
                    "planEnd": endTime?.toIso8601String(),
                    "no": 0,
                    "userNo": 0,
                    "planName": _titleController.text,
                    "planContent": _descriptionController.text
                  });
                  if (result) {
                    Navigator.pop(context);
                    setState(() {});
                  }
                } else {
                  bool result = await calendarService.updatePlan({
                    "planTime": startTime?.toIso8601String(),
                    "planEnd": endTime?.toIso8601String(),
                    "no": widget.event!.id,
                    "userNo": 0,
                    "planName": _titleController.text,
                    "planContent": _descriptionController.text
                  });
                  if (result) {
                    Navigator.pop(context);
                    setState(() {});
                    // 북마크 새로 넣은 일정까지 다시 가져오기
                  }
                }
                // Navigator.pop(context);
              },
              child: Text('저장하기'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: HexColor('6A1ED0'),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
