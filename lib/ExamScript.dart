import 'dart:math';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mil_abbr/landing_page.dart';

class ExamScript extends StatefulWidget {
  final int ques;
  final String type;
  const ExamScript({super.key, required this.ques, required this.type});


  @override
  State<ExamScript> createState() => _ExamScriptState();
}

class _ExamScriptState extends State<ExamScript> {
  List finalQues = [];
  List quesIndex = [];
  List quesSet = [];
  List<List<dynamic>> data = [];
  Random random = new Random();

  void createQues()  async {
    final _rawData =  await rootBundle.loadString("assets/data/abbr_sheet.csv");
    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(_rawData);
    data = _listData;

    print(data.length);
    int i=0;
    while(quesIndex.length != widget.ques){
      int random_number = random.nextInt(1791);
      if (!quesIndex.contains(random_number)) {quesIndex.add(random_number);}
      quesSet.add(data[quesIndex[i++]]);
    }

  if(widget.type == "deabbr"){

      for(int i = 0; i<widget.ques; i++){
        String a = quesSet[i][0];
        String b = quesSet[i][1];
        quesSet[i][0]= b;
        quesSet[i][1] = a;
      }
    }

    print(quesSet);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createQues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: CustomBar(barName: "QUIZ TEST",),
      ),
      body: Container(
          child: Center(
            child: Text("Exam: "+ widget.ques.toString() + widget.type),
          )
      ),
    );
  }
}



