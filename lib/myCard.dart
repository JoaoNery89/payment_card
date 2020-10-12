import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  MyCard({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: bottom),
        reverse: true,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0,12.0,12.0,0),
            child: Column(
              children: [
                Card(
                  child: Stack(
                    children: <Widget>[
                      Image.asset('assets/cardBg.png',fit: BoxFit.cover,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical:16.0),
                              child: Text(
                                "**** **** **** 6543",
                                style: TextStyle(
                                  fontSize: 28.0,
                                  color: Colors.white
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "Validade",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22.0
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "MM/YY",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "CVV",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22.0
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "***",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              "Titular",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28.0
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  elevation: 5.0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  semanticContainer: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

}