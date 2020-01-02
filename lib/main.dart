import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: "this is my first flutter app",
      home: new RandomEnglishWords(),
    );
  }
}

class RandomEnglishWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new RandomEnglishWordsState();
  }
}

class RandomEnglishWordsState extends State<RandomEnglishWords> {
  final _words = <WordPair>[];
  final _checkedWords = new Set<WordPair>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("list of name random"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.list),
            onPressed: _pushToSavedWordsScreen,
          )
        ],
      ),
      body: new ListView.builder(itemBuilder: (context, index) {
        if (index >= _words.length) {
          _words.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_words[index], index);
      }),
    );
  }

  Widget _buildRow(WordPair wordPair, index) {
    final color = index % 2 == 0 ? Colors.red : Colors.blue;
    final isChecked = _checkedWords.contains(wordPair);
    return new ListTile(
        leading: new Icon(
          isChecked ? Icons.check_box : Icons.check_box_outline_blank,
          color: color,
        ),
        title: new Text(
          wordPair.asUpperCase,
          style: new TextStyle(fontSize: 18.0, color: color),
        ),
        onTap: () {
          setState(() {
            if (isChecked) {
              _checkedWords.remove(wordPair);
            } else {
              _checkedWords.add(wordPair);
            }
          });
        });
  }

  _pushToSavedWordsScreen() {
    final pageRoute = new MaterialPageRoute(builder: (context) {
      final listTiles = _checkedWords.map((wordPair) {
        return new ListTile(
            title: new Text(wordPair.asUpperCase,
                style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue)));
      });
      return new Scaffold(
          appBar: new AppBar(title: new Text("List choosed")),
          body: new ListView(
            children: listTiles.toList(),
          ));
    });
    Navigator.of(context).push(pageRoute);
  }
}
