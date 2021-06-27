import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riafymachinetest/insta_home.dart';
import 'package:riafymachinetest/insta_list.dart';
import 'package:riafymachinetest/services/api_services.dart';

import 'insta_stories.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyApp extends StatelessWidget {
  goBack(BuildContext context) {
    Navigator.pop(context);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              goBack(context);
            },
          ),
          title: Text('Comments', style: TextStyle(color: Colors.black)),
        ),
        body: new InstaComment(),
      ),
    );
  }
}

class InstaComment extends StatefulWidget {
  @override
  _InstaCommentState createState() => _InstaCommentState();
}

class _InstaCommentState extends State<InstaComment> {
  bool isPressed = false;

  Future getComments() async {
    return APIServices().getcomments();
  }

  @override
  void initState() {
    super.initState();
    getComments();
  }

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: FutureBuilder(
          future: getComments(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.toString() != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  for (int i = 0; i < snapshot.data.length; i++)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 5.0, 0.0, 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new NetworkImage(
                                      "https://googleflutter.com/sample_image.jpg")),
                            ),
                          ),
                          new SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: new Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: new TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: new TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        new TextSpan(
                                            text: snapshot.data[i]['username']
                                                .toString(),
                                            style: new TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        new TextSpan(text: " "),
                                        new TextSpan(
                                            text: snapshot.data[i]['comments']
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                  new IconButton(
                                    iconSize: 15.0,
                                    icon: new Icon(isPressed
                                        ? Icons.favorite
                                        : FontAwesomeIcons.heart),
                                    color:
                                        isPressed ? Colors.red : Colors.black,
                                    onPressed: () {
                                      setState(() {
                                        isPressed = !isPressed;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              );
            }
            return SizedBox(
              width: 100,
              height: 100,
              child: Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
