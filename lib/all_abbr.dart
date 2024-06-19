import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<List<dynamic>> _data = [];
  List<List<dynamic>> foundAbbr = [];

 void _loadCSV()  async {
    final _rawData =  await rootBundle.loadString("assets/data/abbr_sheet.csv");
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
              (
                  element[0].toLowerCase().startsWith(key.trim().toLowerCase())
              )
      ).toList();

      if (resultAbbr.isEmpty){
        resultAbbr = _data.where(
                (element) =>
                    ( element[1].toLowerCase().startsWith(key.trim().toLowerCase())
                    )
        ).toList();
      }
      if (resultAbbr.isEmpty){
        resultAbbr = _data.where(
                (element) =>
            (
                element[0].toLowerCase().contains(key.trim().toLowerCase())
            )
        ).toList();
      }
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
                  color: Colors.blue.shade900,
                ),
                child:
                Text('  All Abbr according to JSSDM-2022  ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
              ),
              TextField(
                onChanged: (value) => _filterWords(value),
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Search Here",
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
                      child: ListTile(
                        leading: const Icon(Icons.light_mode),
                        title: Text(foundAbbr[index][0]),
                        subtitle: Text(foundAbbr[index][1],
                          style: const TextStyle( color: Colors.green, fontWeight: FontWeight.bold) ,),
                        // trailing: Text(foundWords[index]['id'].toString()),
                      ),
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


