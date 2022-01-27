import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
            )
          ])
      ) ,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), 
    );
  }
}
