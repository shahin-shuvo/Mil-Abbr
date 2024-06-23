import 'dart:math';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mil_abbr/landing_page.dart';
import 'package:mil_abbr/quiz.dart';

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
  String typeHd ="";
  int quesnumHd = 0;
  int score = 0;
  List<List<dynamic>> data = [];
  Random random = new Random();
  List TextCtrl = [];

  void createQues()  async {
    final _rawData =  await rootBundle.loadString("assets/data/abbr_sheet.csv");
    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(_rawData);
    data = _listData;
    setState(() {
      if(widget.type == "abbr") typeHd = "ABBR";
      else typeHd = "DEABBR";
      quesnumHd = widget.ques;

      for (int i = 1; i<=widget.ques; i++){
        TextEditingController ctrl$i = new TextEditingController();
        TextCtrl.add(ctrl$i);
      }


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
    });
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
        preferredSize: Size.fromHeight(80),
        child: CustomBar(barName: "QUIZ TEST",),
      ),
      body:
      Container(
        child:
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.yellow,
                ),
                child:
                RichText(
                  text: TextSpan(
                    text: '   WRITE THE ',
                    style:  TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: '$typeHd', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(text: ' OF FOL '),
                      TextSpan(text: '$quesnumHd', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                      TextSpan(text: ' WORDS    '),
                    ],
                  ),
                )
              ),
              Expanded(child: quesSet.isNotEmpty ?
              ListView.builder(
                  itemCount: quesSet.length,
                  itemBuilder: (context, index){
                    var cnt = index+1;
                    return Card(
                      key: ValueKey(quesSet[index]),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Text('$cnt',  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold) ),
                        title: Text(quesSet[index][0]),
                        subtitle: TextFormField(
                          controller: TextCtrl[index],
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Your Answer',
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }):  const Center(child: Text("Nothing"))
              ),

              FloatingActionButton.extended(
                label: Text('SUBMIT', style: TextStyle(color: Colors.white),), // <-- Text
                backgroundColor: Colors.black,
                icon: Icon( // <-- Icon
                  Icons.check_circle_outline,
                  size: 24.0,
                  color: Colors.white,
                ),
                onPressed: () {
                  List wrongAns =[];
                for (int i=0; i< quesnumHd;i++){
                  if(quesSet[i][1] == TextCtrl[i].text.trim())
                    {
                      score++;
                    }
                  else{
                    if(TextCtrl[i].text.trim() != ""){
                        wrongAns.add(quesSet[i][1]+"=>  Your Ans:"+TextCtrl[i].text.trim()+ ",  Corect Ans:"+ quesSet[i][0]);
                    }
                  }
                }
                print("SCORE:"+ score.toString());
                print(wrongAns);

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>  CustomDialogWidget(score: score.toString(), wrongAns: wrongAns),
                );
                },
              ),

            ],
          ),
        ),

      ),
    );
  }
}

class CustomDialogWidget extends StatelessWidget {
  final String score;
  final List wrongAns;

  const CustomDialogWidget({super.key, required this.score, required this.wrongAns});


  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color:Colors.pink,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("YOUR SCORE", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),),
            SizedBox(height: 10,),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(score, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 64)),
              maxRadius: 60,
            ),
            SizedBox(height: 10,),

            SizedBox(height: 10,),
            FloatingActionButton.extended(
              label: Text('CLOSE', style: TextStyle(color: Colors.white),),
              backgroundColor: Colors.black,
              icon: Icon( // <-- Icon
                Icons.clear_rounded,
                size: 24.0,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => const LandingPage(initNavIndex: 3,)
                ));

              },
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}


