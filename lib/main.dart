import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'opinion_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        // 初期画面のclassを指定
        '/': (context) => const MyHomePage(title: 'ha',),
        // 次ページのclassを指定
        '/next': (context) => const NextPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String _question = "question";

  // void _addOpinion() {
  //   setState(() {
  //     _question;
  //   });
  // }
  final messageTextController1 = TextEditingController();
  final messageTextController2 = TextEditingController();

  String _question = '';
  String _answer = '';
  List<String> _opinions = [];

  void _handleText(String e) {
    setState(() {
      _question = e;
    });
  }

  void _handleText2(String e) {
    setState(() {
      _answer = e;
    });
  }

  void _addOpinion() async {
                // ドキュメント作成
                await FirebaseFirestore.instance
                    .collection('opinions') // コレクションID
                    .doc() // ここは空欄だと自動でIDが付く
                    .set({
                  'question': _question,
                  'answer': _answer,
                  'userId': 1
                });
                messageTextController1.clear(); //questionを空欄に
                messageTextController2.clear(); //answerを空欄に
                
  }

  void _getOpinion() async {
    final opinions = await FirebaseFirestore.instance.collection("opinions").get();
    List<String> answers = [];
    for (var opinion in opinions.docs) {
      setState(() {
              // リスト追加
              answers.add(opinion.get("answer"));
            });
    }
    _opinions = answers;
    print(_opinions);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            // Text(
            //   _text,
            //   style: const TextStyle(
            //       color: Colors.blueAccent,
            //       fontSize: 30.0,
            //       fontWeight: FontWeight.w500
            //   ),
            // ),
            TextField(
              enabled: true,
              // 入力数
              maxLength: 50,
              style: const TextStyle(color: Colors.black),
              obscureText: false,
              maxLines: null ,
              decoration: const InputDecoration(
              icon: Icon(Icons.question_answer),
              hintText: 'Put a question',
              labelText: 'Question',
              ),
              controller: messageTextController1,
              onChanged: _handleText,
            ),
            TextField(
              enabled: true,
              // 入力数
              maxLength: 50,
              style: const TextStyle(color: Colors.black),
              obscureText: false,
              maxLines: null ,
              decoration: const InputDecoration(
              icon: Icon(Icons.question_answer),
              hintText: 'Put an answer',
              labelText: 'Answer',
              ),
              controller: messageTextController2,
              onChanged: _handleText2,
            ),
            ElevatedButton
          (
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: const Text('Add Opinion'),
              onPressed: _addOpinion,
            ),
            ElevatedButton(
          child: const Text('Next'),
          onPressed: (){
            // 押したら反応するコードを書く
            Navigator.pushNamed(
              context,
              '/next'
              // MaterialPageRoute(builder: (context) => const NextPage(),
            );
          }
          ),
          ElevatedButton
          (
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text('Get Opinion'),
              onPressed: _getOpinion,
            ),
            ListView.builder(
              shrinkWrap: true,   //追加
           physics: const NeverScrollableScrollPhysics(),  
        itemCount: _opinions.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(_opinions[index]),
            ),
          );
        },
      ),
      //       ListView(
      //   children: _opinions.map(
      //     (opinion) {
      //       return Card(
      //         child: ListTile(
      //           title: Text(opinion),
      //           subtitle: Text(opinion),
      //         ),
      //       );
      //     },
      //   ).toList()
      // ),
//       ListView(
//   children: const <Widget>[
//     Text('Item 1'),
//     Text('Item 2'),
//     Text('Item 3'),
//   ],
// )
          ]
          )
      ) ,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), 
    );
  }
}
