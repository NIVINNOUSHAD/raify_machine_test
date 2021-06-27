import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:riafymachinetest/insta_comment.dart';
import 'package:riafymachinetest/services/api_services.dart';

import 'insta_stories.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstaList extends StatefulWidget {
  @override
  _InstaListState createState() => _InstaListState();
}

class _InstaListState extends State<InstaList> {
  bool isPressed = false;
  bool save = false;

  Future getalldata() async {
    return APIServices().getallpostdata();
  }

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
          future: getalldata(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data.toString() != null) {
              return Column(
                children: [
                  new SizedBox(
                    child: new InstaStories(),
                    height: deviceSize.height * 0.15,
                  ),
                  for (int i = 0; i < snapshot.data.length; i++)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    new Container(
                                      height: 40.0,
                                      width: 40.0,
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(snapshot
                                                .data[i]['high thumbnail']
                                                .toString())),
                                      ),
                                    ),
                                    new SizedBox(
                                      width: 10.0,
                                    ),
                                    new Text(
                                      snapshot.data[i]['channelname']
                                          .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                new IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: null,
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: new Image.network(
                            snapshot.data[i]['high thumbnail'].toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new IconButton(
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
                                  new SizedBox(
                                    width: 3.0,
                                  ),
//                                  new Icon(FontAwesomeIcons.comment),
                                  new IconButton(
                                    icon: const Icon(FontAwesomeIcons.comment),
                                    color: Colors.black,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MyApp()));
                                    },
                                  ),
                                  new SizedBox(
                                    width: 5.0,
                                  ),
                                  new Icon(FontAwesomeIcons.paperPlane),
                                ],
                              ),
                              new IconButton(
                                icon: new Icon(FontAwesomeIcons.bookmark),
                                color: Colors.black,
                                onPressed: () {
                                  setState(() {
                                    save = !save;
                                  });
                                  final scaffold =
                                      ScaffoldMessenger.of(context);
                                  scaffold.showSnackBar(
                                    SnackBar(
                                      content: const Text('Saved'),
                                    ),
                                  );
                                  saveFeed(snapshot.data[i]);
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            "Liked by pawankumar, pk and 528,331 others",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          child: Row(
                            children: [

                              Flexible(
                                child: ReadMoreText(
                                  snapshot.data[i]['channelname'].toString() +
                                      ":  " +
                                      snapshot.data[i]['title'].toString(),
                                  trimLength: 45,
                                  colorClickableText: Colors.black,
                                  trimMode: TrimMode.Length,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: ' Show less',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                                  moreStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                  lessStyle:TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700) ,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 5.0, 0.0, 8.0),
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
                                      image: new NetworkImage(snapshot.data[i]
                                              ['medium thumbnail']
                                          .toString())),
                                ),
                              ),
                              new SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: new TextField(
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Add a comment...",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text("1 Day Ago",
                              style: TextStyle(color: Colors.grey)),
                        )
                      ],
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

  void saveFeed(var item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List previousList = [];
    var previousItem = prefs.getString('saved');
    if (previousItem != null) {
      print('previous value $previousItem');
      previousList = json.decode(previousItem);
    }
    previousList.add(item);

    var list = json.encode(previousList);
    prefs.setString('saved', list);

//    print('available list ${await getSavedFeed()}');
  }
}
