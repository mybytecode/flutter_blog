import 'package:flutter/material.dart';
import 'package:flutter_blog/constants/Constants.dart';
import 'package:flutter_blog/widgets/ThemeProvider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_version/get_version.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AboutUsState();
}

class AboutUsState extends State<AboutUs> {
  String _platformVersion = 'Unknown';
  String _projectVersion = '';
  String _projectCode = '';
  String _projectAppID = '';
  String _projectName = '';

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme.getTheme(),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                  width: 200,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ListTile(
                title: Text("Version " + _projectVersion),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  launch("mailto:" +
                      Config.gAuthorMail +
                      "?Subject=Work%20with%20us.");
                },
                leading: Icon(
                  Icons.attach_money,
                  color: Colors.orangeAccent,
                ),
                title: Text(
                  "Advertise with us",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  launch("mailto:" + Config.gAuthorMail);
                },
                leading: Icon(
                  Icons.mail,
                  color: Colors.red,
                ),
                title: Text(
                  "Contact us",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  launch(Config.gFacebookPageUrl);
                },
                leading: Icon(
                  FontAwesomeIcons.facebook,
                  color: Colors.blue,
                ),
                title: Text(
                  "Like us on facebook",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  launch(Config.gInstagramUrl);
                },
                leading: Icon(
                  FontAwesomeIcons.instagram,
                  color: Colors.deepOrange,
                ),
                title: Text(
                  "Follow us on Instagram",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  launch("https://play.google.com/store/apps/details?id=" +
                      _projectAppID);
                },
                leading: Icon(
                  FontAwesomeIcons.googlePlay,
                  color: Colors.blue,
                ),
                title: Text(
                  "Rate us on playstore",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    platformVersion = await GetVersion.platformVersion;

    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    projectVersion = await GetVersion.projectVersion;

    String projectCode;
    projectCode = await GetVersion.projectCode;

    String projectAppID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    projectAppID = await GetVersion.appID;

    String projectName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    projectName = await GetVersion.appName;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _projectVersion = projectVersion;
      _projectCode = projectCode;
      _projectAppID = projectAppID;
      _projectName = projectName;
    });
  }
}
