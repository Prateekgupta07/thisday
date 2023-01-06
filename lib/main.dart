import 'dart:async';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFEF3966),
          automaticallyImplyLeading: false,
          title: const Text(
            'This Day',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2,
        ),
        body: SafeArea(
          child: GestureDetector(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 19,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const MyHomePage(title: "title")));
                  },
                  child: const Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color(0xFFEF3966),
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                      child: Text(
                        'Click here to view Mutiple Podcasts ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int pos = 0;

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late PageController _pageController;
  late Animation<double> animation;
  late AnimationController animationController;
  bool status = false;
  double containerheight = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static var url = 'https://www.rover.com/tos/';
  List image = [
    'assets/images/one.jpg',
    'assets/images/two.jpg',
    'assets/images/three.jpg',
    'assets/images/four.jpg',
    'assets/images/five.jpg',
    'assets/images/six.jpg'
  ];
  List link = [
    'https://web.thisday.app/story/lost-recipes-of-india-from-south-to-north-east-to-west-3670',
    'https://web.thisday.app/story/the-challenger-of-a-political-dynasty-2225',
    'https://web.thisday.app/story/the-man-who-went-the-other-way-230',
    'https://web.thisday.app/story/the-birth-of-the-coffee-house-culture-in-india-18373',
    'https://web.thisday.app/story/the-lost-cause-1616',
    'https://web.thisday.app/story/the-unmatched-queen-of-english-1546'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(vsync: this);
    _pageController = PageController();

    animationController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTapDown: (details) async {
          final double screenwidth = MediaQuery.of(context).size.width;
          final double screenheight = MediaQuery.of(context).size.height;
          final double dx = details.globalPosition.dx;

          if (dx < screenwidth / 3) {
            animationController.reset();
            animationController.forward();
            _pageController.animateToPage(pos - 1,
                duration: const Duration(microseconds: 5), curve: Curves.ease);
          } else if (dx > 2 * screenwidth / 3) {
            animationController.reset();
            animationController.forward();
            _pageController.animateToPage(pos + 1,
                duration: const Duration(microseconds: 5), curve: Curves.ease);
          } else {}
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: image.length,
          itemBuilder: (context, position) {
            pos = position;

            animationController.addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                setState(() {
                  _pageController.animateToPage(pos + 1,
                      duration: const Duration(microseconds: 5),
                      curve: Curves.ease);
                  animationController.reset();
                });
                if (position < 5) {
                  animationController.forward();
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Home()));
                }
              }
            });
            return Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(image[position]).image),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(Icons.keyboard_arrow_up),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  const Icon(Icons.link),
                                  const Text("Read more")
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 40.0),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      backgroundColor: Colors.black,
                      valueColor: const AlwaysStoppedAnimation(Colors.green),
                      value: animation.value,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                Share.share(link[pos]);
                              },
                              child: const Icon(Icons.share))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ]);
          },
        ),
        onVerticalDragEnd: (details) async {
          animationController.stop();
          showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                    height: 50,
                    color: Colors.white,
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(Icons.link),
                            url = link[pos],
                            Wrap(children: [Text("    Opening" + url)])
                          ],
                        ),
                        const LinearProgressIndicator()
                      ],
                    ),
                  ));
          setState(() {
            containerheight = MediaQuery.of(context).size.height / 10;
          });
          Future.delayed(const Duration(seconds: 2), () async {
            url = link[pos];
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            } else {
              throw 'Could not launch $url';
            }
          });
        },
      ),
    );
  }
}
