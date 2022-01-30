import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("次のページ"),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.red,
        child: Center(
          child: ElevatedButton(
            child: const Text('戻る'),
            onPressed: (){
              // 1つ前に戻る
              Navigator.pop(context);
            },
          ),
      ),
      )
    );
  }
}