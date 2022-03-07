import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterheritageolympiad/modal/classicquestion/ClassicQuestion.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

void main() => runApp(Mcq());

class Mcq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Data quiz;
  late List<Question> results;
  late Color c;
  Random random = Random();
  @override
  void initState() {
    super.initState();
    fetchQuestions("81");
  }
Future<dynamic> fetchquestions(BuildContext context) async {
    return fetchQuestions("83");

  }
  Future fetchQuestions(String quiz_id) async {
    var res = await http.post(Uri.parse("http://3.108.183.42/api/questions"),
        body: {
          'quiz_id': quiz_id.toString(),
        });
    var decRes = jsonDecode(res.body);
    print(decRes);
    c = Colors.black;
    quiz = Data.fromJson(decRes);
   // results = quiz.results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz App"),
        elevation: 0.0,
      ),
      body: RefreshIndicator(
        onRefresh:() => fetchquestions(context),
        child: FutureBuilder(
            future: fetchQuestions("83"),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Text('Press button to start.');
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError) return errorData(snapshot);
                  return questionList();
              }
            }),
      ),
    );
  }

  Padding errorData(AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Error: ${snapshot.error}',
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            child: Text("Try Again"),
            onPressed: () {
              fetchQuestions("83");
              setState(() {});
            },
          )
        ],
      ),
    );
  }

  ListView questionList() {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => Card(
        color: Colors.white,
        elevation: 0.0,
        child: ExpansionTile(
          title: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  results[index].id.toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text(results[index].option1.toString()),
                        onSelected: (b) {},
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      FilterChip(
                        backgroundColor: Colors.grey[100],
                        label: Text(
                          results[index].option2.toString(),
                        ),
                        onSelected: (b) {},
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          // leading: CircleAvatar(
          //   backgroundColor: Colors.grey[100],
          //   child: Text(results[index].type.startsWith("m") ? "M" : "B"),
          // ),
          // children: results[index].option1Media?.map((m) {
          //   return AnswerWidget(results, index, m);
          // }).toList(),
        ),
      ),
    );
  }
}

// class AnswerWidget extends StatefulWidget {
//   final List<Question> results;
//   final int index;
//   final String m;
//
//   AnswerWidget(this.results, this.index, this.m);
//
//   @override
//   _AnswerWidgetState createState() => _AnswerWidgetState();
// }
//
// class _AnswerWidgetState extends State<AnswerWidget> {
//   Color c = Colors.black;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () {
//         setState(() {
//           if (widget.m == widget.results[widget.index].rightOption) {
//             c = Colors.green;
//           } else {
//             c = Colors.red;
//           }
//         });
//       },
//       title: Text(
//         widget.m,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           color: c,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }