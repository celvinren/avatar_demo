import 'package:avatar_demo/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:provider/provider.dart';

import 'people.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => HomeScreenProvider(),
        ),
      ],
      builder: (ctx, widget) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<HomeScreenProvider>(context, listen: false)
        .getDataFromAPI(context);
  }

  String avatarStr = "";
  List<People> list;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context, p, w) {
        list = p.getPeopleList;
        print(list);
        if (list == null || list.length == 0) {
          return Container();
        }
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxHeight: 80),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: getCustomAvatar(list[index], index),
                          );
                        }),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      avatarStr,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getCustomAvatar(People people, int index) {
    return CircularProfileAvatar(
      people.image,
      //'https://pic.3gbizhi.com/2020/0826/20200826123917742.jpg', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
      radius: 30, // sets radius, default 50.0
      initialsText: Text(people.id),
      showInitialTextAbovePicture: true,
      backgroundColor:
          Colors.transparent, // sets background color, default Colors.white
      borderWidth: 2, // sets border, default 0.0
      borderColor: Colors.blueGrey, // sets border color, default Colors.white
      elevation:
          5.0, // sets elevation (shadow of the profile picture), default value is 0.0
      // foregroundColor: Colors.brown.withOpacity(
      //     0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
      cacheImage: true, // allow widget to cache image against provided url
      onTap: () {
        // print('adil');
        // setState(() {
        //   avatarStr = "User ID is " + list[index].id;
        // });
      }, // sets on tap
      progressIndicatorBuilder: (
        context,
        url,
        progress,
      ) {
        if (progress.progress == 1)
          return CircleAvatar(radius: 50, backgroundImage: NetworkImage(url));
        return Center(
          child: CircularProgressIndicator(value: progress.progress),
        );
      },
    );
  }
}
