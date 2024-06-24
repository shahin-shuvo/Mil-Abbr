import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmdtAbbr extends StatefulWidget {
  const AmdtAbbr({super.key});

  @override
  State<AmdtAbbr> createState() => _AmdtAbbrState();
}

class _AmdtAbbrState extends State<AmdtAbbr> {
  List<List<dynamic>> _data = [];
  List<List<dynamic>> foundAbbr = [];

  void _loadCSV()  async {
    final _rawData =  await rootBundle.loadString("assets/data/amdt_abbr.csv");
    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(_rawData);
    setState(() {
      _data = _listData;
      foundAbbr = _listData;

    });

  }

  List<Map<String, dynamic>> foundWords = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCSV();


  }
  void _filterWords(String key){

    List<List<dynamic>> resultAbbr = [];

    if(key.isEmpty) {
      resultAbbr = _data;
    }
    else{
      resultAbbr = _data.where(
              (element) =>
          ( element[0].split(' ')[0].toLowerCase().contains(key.trim().toLowerCase())
          )
              ||
              ( element[1].split(' ')[0].toLowerCase().contains(key.trim().toLowerCase())
              )
              ||
              ( element[2].split(' ')[0].toLowerCase().contains(key.trim().toLowerCase())
              )

      ).toList();
    }


    setState(() {
      foundAbbr = resultAbbr;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),


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
                  color: Colors.green.shade900,

                ),

                  child:
                  Text('  NEWLY AMDT ABBR  ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),


              ),
              Container(
                child:
                Text('  AS PER JSSDM-2022  ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),


              ),

              TextField(
                  onChanged: (value) => _filterWords(value),
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                      labelText: "Find Modified Abbr Here",
                      labelStyle: TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        fontSize: 15,
                      ),
                      suffixIcon: Icon(Icons.search, color: Colors.black),
                      prefixIcon: Icon(Icons.list, color: Colors.black,)
                  )

              ),

              Expanded(child: foundAbbr.isNotEmpty ?
              ListView.builder(
                  itemCount: foundAbbr.length,
                  itemBuilder: (context, index){
                    return Card(
                      key: ValueKey(foundAbbr[index]),
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.draw_sharp),
                            title: Text(foundAbbr[index][0], style: TextStyle(),),
                            subtitle: Container(
                                child: Row(
                                  children: [
                                    Text(foundAbbr[index][1] + "   ", style: TextStyle(color: Colors.red.shade900),),
                                    Icon(Icons.arrow_right_alt),
                                    Text("   "+foundAbbr[index][2], style: TextStyle(color: Colors.green.shade600, fontWeight: FontWeight.bold))
                                  ],
                                )
                            ),
                          ),
                        ],
                      )
                    );

                  }):  const Center(child: Text("Nothing Found"))
              )
            ],
          ),
        ),

      ),

    );
  }
}
