import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data={};

  @override
  Widget build(BuildContext context) {
    data=data.isNotEmpty?data :ModalRoute.of(context)!.settings.arguments as Map;
    print(data);

    //set background
    String bgImage=data['isDayTime']?'day.png':'night.png';
    Color bgColor=data['isDayTime']?Colors.blue:Colors.indigo;

    return Scaffold(
      backgroundColor: bgColor,
        body: SafeArea(    //safeArea is used to cover the notification panel by the app
            child: Container(
              decoration:BoxDecoration(
                image:DecorationImage(
                  image:AssetImage('assets/$bgImage'),
                  fit:BoxFit.cover,

                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 120.0,0,0),
                child: Column(
                    //We are putting everything under a single column because in the end we need the widgets to be arranged in the column only.
                    children: <Widget>[
                      TextButton.icon(
                        onPressed: () async{
                          //on pressing the textButton navogator will push a directed address to the context..
                          dynamic result =await Navigator.pushNamed(context,'/choose_location');   //this pushNamed() is used to push a screen on the top of the others.. by adding pushing a location into the context object.
                          setState(() {
                            data={
                              'time':result['time'],
                              'location':result['location'],
                              'isDaytime':result['isDayTime'],
                              'flag':result['flag'],
                            };
                          });
                          //NOTE: we can move back to same window
                        },
                        icon:Icon(
                            Icons.edit_location,
                            color: Colors.grey[300],
                        ),
                        label: Text(
                            'Edit Location',
                          style: TextStyle(
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            data['location'],
                            style: TextStyle(
                              fontSize:28.0,
                              letterSpacing: 2.0,
                              color: Colors.white,
                            )
                          )
                        ],
                      ),
                      SizedBox(height:20.0),
                      Text(
                        data['time'],
                        style: TextStyle(
                          fontSize: 60.0,
                              color: Colors.white,
                        ),
                      )
                    ]
                ),
              ),
            )
        ),
    );
  }
}
