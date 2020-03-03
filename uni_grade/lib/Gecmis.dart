import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:uni_grade/information.dart';
import 'package:uni_grade/Notlar.dart';
import 'dart:core';

class GecmisDersler extends StatefulWidget {
  final UserDetails detailsUser;
  GoogleSignInAccount googleUser;
  GoogleSignIn gSignIn;

  GecmisDersler({Key key, @required this.detailsUser, @required this.gSignIn})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GecmisDersler();
  }
}

/*
Notlar mg = Notlar(1, 'As');
Information informationSample = Information('Ders 1', 3, mg);
Information informationSampleB = Information('Ders 2', 5, mg);
List<Information> informationSampleArray = [
  Information('Ders 1', 3, mg),
  Information('Ders 2', 5, mg)
];*/



class _GecmisDersler extends State<GecmisDersler> {

  List<Notlar> _companies = Notlar.getCompanies();
List<DropdownMenuItem<Notlar>> _dropdownMenuItems;
Notlar _selectedCompany;
Notlar s;
String x;
GlobalKey<_GecmisDersler> _key = GlobalKey();
File jsonFile;
var dir;
String fileName = "myFile.json";
bool fileExists = false;
Map<String, dynamic> fileContent;
List<Notlar> _selectedCompanys = [];
List<List<Notlar>> dersler = [];

List<List<String>> courseNames = [];
List<List<String>> courseCredits = [];

List<List<Information>> information = [];
List<String> saveFile = [];

List<ExpansionTile> list = [];
List<int> dersCount = [];
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
    //dir = getExternalStorageDirectory();
    getApplicationDocumentsDirectory().then((Directory directory) async {
      dir = await getExternalStorageDirectory();
      jsonFile = new File(dir.path + "/" + fileName);
      this.setState(  () => jsonReader());

      //print(jsonFile.path);
      //fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
  }

  void createFile(Map<String, dynamic> content, var dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    file.createSync();
    //fileExists = true;
    print('BUNDAN ÖNCE');
    x = jsonEncode(information);
    //print(x);
    file.writeAsStringSync(x);
  }

  void jsonReader() {
    String reader = File(dir.path + "/" + fileName).readAsStringSync();
    final jsonResponse = json.decode(reader);
    var add = jsonResponse.toString();
    print(jsonResponse[0][0]);
    jsonToInfo(jsonResponse);
  }

  void jsonToInfo(final jsonResponse) {
    for (int i = 0; i < jsonResponse.length; i++) {
      information.add([]);
      print(information.length);
      String courseNameTemp;
      int ectsTemp;
      Notlar notTemp;
      int idTemptoStr;
      int idTemp;
      String nameTemp;
      for (int j = 0; j < jsonResponse[i].length; j++) {
        courseNameTemp = jsonResponse[i][j]["courseName"];
        ectsTemp = jsonResponse[i][j]["ects"];
        idTemp = int.parse(jsonResponse[i][j]["grade"]["id"].toString());
        nameTemp = jsonResponse[i][j]["grade"]["name"];
        print('idTemp:$idTemp  --- nameTemp:' + nameTemp);
        information[i].add(new Information(
            courseNameTemp, ectsTemp, _dropdownMenuItems[idTemp - 1].value));
        // print(information[i][j].grade.id);
      }
    }
  }

  void writeToFile(String key, dynamic value) {
    print("Writing to file!");
    Map<String, dynamic> content = {key: value};
    if (fileExists) {
      print("File exists");
      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);

      x = jsonEncode(information);
      print(x);
      jsonFile.writeAsStringSync(x);
      //

      //
    } else {
      print("File does not exist!");
      createFile(content, dir, fileName);
    }
    //this.setState(() => fileContent = json.decode(jsonFile.readAsStringSync()));
    //print(fileContent);
    //print(jsonFile.path);
  }

  List<DropdownMenuItem<Notlar>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Notlar>> items = List();
    for (Notlar company in companies) {
      items.add(
        DropdownMenuItem(
          child: SizedBox(
            width: 40,
            child: Text(company.name, textAlign: TextAlign.right),
          ),
          value: company,
        ),
      );
    }
    return items;
  }

/*
  void save() async {
    final arac = await SharedPreferences.getInstance();
  }*/

  double harfNotuCevir(String str) {
    if (str == 'AA') {
      return 4.0;
    }
    if (str == 'BA') {
      return 3.5;
    }
    if (str == 'BB') {
      return 3.0;
    }
    if (str == 'CB') {
      return 2.5;
    }
    if (str == 'CC') {
      return 2.0;
    }
    if (str == 'DC') {
      return 1.5;
    }
    if (str == 'DD') {
      return 1.0;
    }
    if (str == 'FD') {
      return 0.5;
    }
    if (str == 'FF') {
      return 0.0;
    }
    if (str == 'F0') {
      return 0.0;
    }

    return 0.0;
  }

  int i = 0;
  double ort = 0;
  int ortEcts = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Uni-Grade'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  // list.add(...);
                  //_selectedCompanys.add(_dropdownMenuItems[0].value);
                  //dersler.add([_dropdownMenuItems[0].value]);
                  information.add(
                      [new Information('', 0, _dropdownMenuItems[0].value)]);
                  //print(information.length);
                  // dersCount.add(1);
                });
              },
              child: Icon(
                Icons.add,
                size: 30.00,
              ),
            ),
          ),
        ],
      ),
      drawer: new Container(
        width: MediaQuery.of(context).size.width * 0.72,
        child: new Drawer(
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(widget.detailsUser.userName),
                accountEmail: new Text(widget.detailsUser.userEmail),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: NetworkImage(widget.detailsUser.photoUrl),
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
              ),
              new ListTile(
                title: new Text("Profil"),
                trailing: new Icon(Icons.account_circle),
                onTap: () {},
              ),
              new Divider(),
              new ListTile(
                title: new Text("Hedef"),
                trailing: new Icon(Icons.trending_up),
              ),
              new Divider(),
              new ListTile(
                title: new Text("Çıkış Yap"),
                trailing: new Icon(Icons.exit_to_app),
                onTap: () {
                  widget.gSignIn.signOut();
                  print('Signed out');
                  Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new LoginScreenPage(),
                    ),
                  );
                },
              ),
              new Divider(),
            ],
          ),
        ),
      ),
      body: new ListView.builder(
          itemCount: information.length + 1,
          padding: EdgeInsets.all(20),
          shrinkWrap: true,
          itemBuilder: (context, int index) {
            if (index == information.length) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                for (int i = 0; i < information.length; i++) {
                                  for (int j = 0;
                                      j < information[i].length;
                                      j++) {
                                    saveFile.add(information[i][j].courseName +
                                        '*/*' +
                                        information[i][j].ects.toString() +
                                        '*/*' +
                                        information[i][j].grade.name);
                                  }
                                }
                                //print(saveFile);

                                writeToFile('hi', 'boi');
                              });
                            },
                            color: Colors.green,
                            child: Text(
                              "Kaydet",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                ort = 0;
                                ortEcts = 0;
                                for (int i = 0; i < information.length; i++) {
                                  for (int j = 0;
                                      j < information[i].length;
                                      j++) {
                                    ortEcts += information[i][j].ects;
                                    ort += information[i][j].ects *
                                        harfNotuCevir(
                                            information[i][j].grade.name);
                                  }
                                }
                                ort = ort / ortEcts;
                                print(ort);
                                //print(dersCount);
                              });
                            },
                            color: Colors.blue,
                            child: Text(
                              "Hesapla",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: RaisedButton(
                            onPressed: () {},
                            color: Colors.red,
                            child: Text(
                              "Sıfırla",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Ortalamanız: ' + ort.toStringAsFixed(2)),
                    ],
                  ),
                ],
              );
            } else {
              return Card(
                  borderOnForeground: true,
                  elevation: 6,
                  child: ExpansionTile(
                    title: Text((index + 1).toString() + '. Dönem'),
                    children: <Widget>[
                      ListView.builder(
                        itemCount: information[index].length,
                        padding: EdgeInsets.only(top: 5),
                        shrinkWrap: true,
                        itemBuilder: (context, int index2) {
                          final exp = Key(information[index].toString());
                          return SingleChildScrollView(
                            key: exp,
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              margin: EdgeInsets.all(5),
                              //decoration: BoxDecoration(
                              //  border: Border.all(color: Colors.black26),
                              //borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: 175,
                                    child: TextFormField(
                                      initialValue:
                                          information[index][index2].courseName,
                                      onChanged: (String str) {
                                        information[index][index2].courseName =
                                            str;
                                      },
                                      decoration: InputDecoration(
                                          semanticCounterText: 'hey',
                                          border: OutlineInputBorder(),
                                          labelText: ' Ders Adı'),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  SizedBox(
                                    width: 65,
                                    child: TextFormField(
                                      initialValue: information[index][index2]
                                          .ects
                                          .toString(),
                                      onChanged: (String ects) {
                                        information[index][index2].ects =
                                            int.parse(ects);
                                      },
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        WhitelistingTextInputFormatter
                                            .digitsOnly
                                      ],
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'ECTS'),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black26),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: SizedBox(
                                        height: 30,
                                        width: 65,
                                        child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                          value:
                                              information[index][index2].grade,
                                          items: _dropdownMenuItems,
                                          onChanged: (value) {
                                            setState(() {
                                              //dersler[index][index2] = value;
                                              information[index][index2].grade =
                                                  value;
                                              print(information[index][index2]
                                                  .courseName);
                                            });
                                          },
                                        )),
                                      )),
                                  SizedBox(width: 5),
                                  Container(
                                      height: 60,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          //color: Colors.grey[300],

                                          border:
                                              Border.all(color: Colors.black26),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            information[index].removeAt(index2);
                                            // dersler[index].removeAt(index2);
                                            print('index2=$index' +
                                                'index2=$index2');
                                          });
                                        },
                                        child: Icon(
                                          Icons.remove_circle,
                                          size: 25,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 5),
                          height: 50,
                          width: 350,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10)),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                // dersCount[index] = dersCount[index] + 1;
                                //dersler[index].add(_dropdownMenuItems[0].value);
                                information[index].add(new Information(
                                    '', 0, _dropdownMenuItems[0].value));
                              });
                            },
                            child: Icon(
                              Icons.add_box,
                              size: 35,
                            ),
                          )),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 30,
                          )
                        ],
                      ),
                    ],
                  ));
            }
          }),
    );
  }
}
