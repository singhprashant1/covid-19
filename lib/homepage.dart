import 'dart:convert';
import 'package:corona/theme.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

import 'sizedbox.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var country;
  var newcase;
  var totalconfirm;
  var recover;
  var death;
  var totalrecover;
  var totaldeath;
  String date;
  var split;
  var time;
  var updatedt;
  var datetime;
  Future getData() async {
    http.Response response =
        await http.get("https://api.covid19api.com/summary");
    var result = jsonDecode(response.body);

    setState(() {
      var array = result['Countries'];

      // this.country = result["Countries"][2]["Country"];
      for (int i = 0; i < array.length; i++) {
        this.country = result["Countries"][i]["Country"];
        if (country == "India") {
          this.newcase = result["Countries"][i]["NewConfirmed"];
          this.totalconfirm = result["Countries"][i]["TotalConfirmed"];
          this.recover = result["Countries"][i]["NewRecovered"];
          this.death = result["Countries"][i]["NewDeaths"];
          this.totalrecover = result["Countries"][i]["TotalRecovered"];
          this.totaldeath = result["Countries"][i]["TotalDeaths"];
          this.date = result["Countries"][i]["Date"]; //2020-12-07T20:39:15Z
          // date = date.substring(10);
          split =date.split("T");
          time = split[1].toString().substring(0,split[1].toString().length-1);

          DateTime parseDt = DateTime.parse(split[0]);
          final newFormat = DateFormat("dd, MMM, yyy");
          updatedt = newFormat.format(parseDt);
this.datetime = updatedt + " " + time;
          // print(split[0] +" "+ time);
        }
      }
    });
  }


  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid-19 India"),
        actions:[Padding(
          padding: const EdgeInsets.only(top: 10,bottom: 10,right: 10,left: 10),
          child: LiteRollingSwitch(
            value: true,
            textOn: 'dark',
            textOff: 'light',
            colorOn: Colors.black45,
            colorOff: Colors.blue,
            iconOn: Icons.nightlight_round,
            iconOff: Icons.wb_sunny,
            onChanged: (bool position){
              print("the button is$position");
              if(position==true){
                _themeChanger.setTheme(ThemeData.light());
              }else{
                _themeChanger.setTheme(ThemeData.dark());
              }

            },
          ),
        )],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      datetime != null ? "Last update: $datetime": "loading",),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 3,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.blockSizeVertical * 3,
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 20,
                          width: SizeConfig.blockSizeVertical * 20,
                          decoration: BoxDecoration(
                              color: Colors.red[100],
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                "Confirmed",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                newcase != null ? newcase.toString() : "loading",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeVertical * 5,
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 20,
                          width: SizeConfig.blockSizeVertical * 20,
                          decoration: BoxDecoration(
                              color: Colors.blue[100],
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                "Total Confirmed",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                totalconfirm != null
                                    ? totalconfirm.toString()
                                    : "loading",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 6,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.blockSizeVertical * 3,
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 20,
                          width: SizeConfig.blockSizeVertical * 20,
                          decoration: BoxDecoration(
                              color: Colors.green[100],
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                "Recovered",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                recover != null ? recover.toString() : "loading",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeVertical * 5,
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 20,
                          width: SizeConfig.blockSizeVertical * 20,
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                "Deceased",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                death != null ? death.toString() : "loading",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 6,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: SizeConfig.blockSizeVertical * 3,
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 20,
                          width: SizeConfig.blockSizeVertical * 20,
                          decoration: BoxDecoration(
                              color: Colors.pink[100],
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                "Total Recovered",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                totalrecover != null
                                    ? totalrecover.toString()
                                    : "loading",
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeVertical * 5,
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical * 20,
                          width: SizeConfig.blockSizeVertical * 20,
                          decoration: BoxDecoration(
                              color: Colors.blueGrey[100],
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                "Total Deceased",
                                style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical * 3,
                              ),
                              Text(
                                totaldeath != null
                                    ? totaldeath.toString()
                                    : "loading",
                                style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
