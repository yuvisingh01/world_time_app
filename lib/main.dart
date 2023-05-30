import 'package:flutter/material.dart';
import 'package:world_time/pages/choose_location.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/home.dart';
import 'package:http/http.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',   //when the app is opened it will begin with home page..
  routes:{ //it just works like a stack, like if enter a new page it will just be pushed upon the another and likewise if we move back to previous page it wwll pop the top most page...
    '/':(context)=>Loading(), //this context object keeps track of where in the widget tree we are..
    '/home':(context)=>Home(),
    '/choose_location':(context)=>ChooseLocation(),
    //context will decide which page(widget) to open based on their mapped location
  }
));



