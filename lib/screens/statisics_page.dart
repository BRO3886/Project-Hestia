import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_hestia/Profile/My%20Chats/myChatRequests.dart';
import 'package:project_hestia/Profile/My%20Chats/otherChatRequests.dart';
import 'package:project_hestia/Profile/chatScreen.dart';
import 'package:project_hestia/model/util.dart';
import 'package:flutter/foundation.dart';
import 'package:project_hestia/screens/show_shop_suggestios.dart';
import 'package:project_hestia/screens/world_statistics.dart';
import 'package:project_hestia/services/shared_prefs_custom.dart';
import 'package:project_hestia/widgets/cust_sliver_app_bar.dart';
import 'package:project_hestia/widgets/my_back_button.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key key}) : super(key: key);

  @override
  StatisticsPageState createState() => StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  @override
  void initState() {
    super.initState();
    getValues();
  }

  int userID;

  getValues() async {
    userID = await SharedPrefsCustom().getUserId();
    setState(() {
      userID;
    });
  }

  void AllAction() {
    setState(() {
      pressAttentionAll = true;
      pressAttentionAllText = true;
      pressAttentionMy = false;
      pressAttentionMyText = false;
    });
  }

  void MyAction() {
    setState(() {
      pressAttentionAllText = false;
      pressAttentionMy = true;
      pressAttentionMyText = true;
      pressAttentionAll = false;
    });
  }

  bool pressAttentionAll = false;
  bool pressAttentionMy = true;
  bool pressAttentionAllText = false;
  bool pressAttentionMyText = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Theme.of(context).canvasColor,
        ),
        body: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: SizedBox(
                      //height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ),
                  MySliverAppBar(
                    title: 'Statistics',
                    isReplaced: false,
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.68,
                              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              decoration: new BoxDecoration(
                                  color: colorWhite,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      MyAction();
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width * 0.34,
                                        padding: EdgeInsets.all(5.0),
                                        decoration: new BoxDecoration(
                                            border: Border.all(
                                              width: 1.0,
                                              color: pressAttentionMy
                                                  ? mainColor
                                                  : colorWhite,
                                            ),
                                            borderRadius:
                                                new BorderRadius.all(Radius.circular(5)),
                                            color: pressAttentionMy
                                                ? mainColor
                                                : colorWhite),
                                        child: Text(
                                          'World',
                                          style: TextStyle(
                                              color: pressAttentionMyText
                                                  ? colorWhite
                                                  : colorBlack,
                                              fontSize: 13.0),
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AllAction();
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width * 0.34,
                                        padding: EdgeInsets.all(5.0),
                                        decoration: new BoxDecoration(
                                            border: Border.all(
                                              width: 1.0,
                                              color: pressAttentionAll
                                                  ? mainColor
                                                  : colorWhite,
                                            ),
                                            borderRadius:
                                                new BorderRadius.all(Radius.circular(5)),
                                            color: pressAttentionAll
                                                ? mainColor
                                                : colorWhite),
                                        child: Text(
                                          'Country',
                                          style: TextStyle(
                                              color: pressAttentionAllText
                                                  ? colorWhite
                                                  : colorBlack,
                                              fontSize: 13.0),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            pressAttentionMy == true
                                ? WorldStatsPage(
                                  )
                                : OtherRequestsChatsPage(
                                    userID: userID,
                                  )
                            
                          ])

                    ) 
                    ),
                  /*SliverFillRemaining(
                    child : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.68,
                              margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              decoration: new BoxDecoration(
                                  color: colorWhite,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      MyAction();
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width * 0.34,
                                        padding: EdgeInsets.all(5.0),
                                        decoration: new BoxDecoration(
                                            border: Border.all(
                                              width: 1.0,
                                              color: pressAttentionMy
                                                  ? mainColor
                                                  : colorWhite,
                                            ),
                                            borderRadius:
                                                new BorderRadius.all(Radius.circular(5)),
                                            color: pressAttentionMy
                                                ? mainColor
                                                : colorWhite),
                                        child: Text(
                                          'World',
                                          style: TextStyle(
                                              color: pressAttentionMyText
                                                  ? colorWhite
                                                  : colorBlack,
                                              fontSize: 13.0),
                                        )),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      AllAction();
                                    },
                                    child: Container(
                                        alignment: Alignment.center,
                                        width: MediaQuery.of(context).size.width * 0.34,
                                        padding: EdgeInsets.all(5.0),
                                        decoration: new BoxDecoration(
                                            border: Border.all(
                                              width: 1.0,
                                              color: pressAttentionAll
                                                  ? mainColor
                                                  : colorWhite,
                                            ),
                                            borderRadius:
                                                new BorderRadius.all(Radius.circular(5)),
                                            color: pressAttentionAll
                                                ? mainColor
                                                : colorWhite),
                                        child: Text(
                                          'Country',
                                          style: TextStyle(
                                              color: pressAttentionAllText
                                                  ? colorWhite
                                                  : colorBlack,
                                              fontSize: 13.0),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            pressAttentionMy == true
                                ? WorldStatsPage(
                                  )
                                : OtherRequestsChatsPage(
                                    userID: userID,
                                  )
                            
                          ])
                  ),*/
                  ],
              ));
  }
}
