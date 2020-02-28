import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GecmisDersler extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GecmisDersler();
  }
}

double _width = 300;
double _height = 50;
BorderRadiusGeometry _borderRadius = BorderRadius.circular(55);

class Dersler {
  double width;
  double height;
  AnimatedContainer animatedContainer;

  Dersler(double width, double height, AnimatedContainer animatedContainer) {
    this.width = width;
    this.height = height;
    this.animatedContainer = animatedContainer;
  }
}

class Notlar {
  int id;
  String name;

  Notlar(this.id, this.name);

  static List<Notlar> getCompanies() {
    return <Notlar>[
      Notlar(1, 'AA'),
      Notlar(2, 'BA'),
      Notlar(3, 'BB'),
      Notlar(4, 'CB'),
      Notlar(5, 'CC'),
      Notlar(6, 'DC'),
      Notlar(7, 'DD'),
      Notlar(8, 'FD'),
      Notlar(9, 'FF'),
      Notlar(10, 'F0'),
    ];
  }
}

class Information {
  String courseName;
  int ects;
  Notlar grade;

  Information(this.courseName, this.ects, this.grade);
}

List<Notlar> _companies = Notlar.getCompanies();
List<DropdownMenuItem<Notlar>> _dropdownMenuItems;
Notlar _selectedCompany;
Notlar s;

class _GecmisDersler extends State<GecmisDersler> {
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  Notlar selectedCompany;

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

  void save() async {
    final arac = await SharedPreferences.getInstance();

    
  }

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
  }

  var currentSelectedValue;

  List<Notlar> _selectedCompanys = [];
  List<List<Notlar>> dersler = [];

  List<List<String>> courseNames = [];
  List<List<String>> courseCredits = [];

  List<List<Information>> information = [];

  int i = 0;
  List<ExpansionTile> list = [];
  List<int> dersCount = [];

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
                  _selectedCompanys.add(_dropdownMenuItems[0].value);
                  dersler.add([_dropdownMenuItems[0].value]);
                  information.add(
                      [new Information('', 0, _dropdownMenuItems[0].value)]);
                  dersCount.add(1);
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
      body: new ListView.builder(
          itemCount: _selectedCompanys.length + 1,
          padding: EdgeInsets.all(20),
          shrinkWrap: true,
          itemBuilder: (context, int index) {
            if (index == _selectedCompanys.length) {
              return Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: RaisedButton(
                            onPressed: () {},
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
                        itemCount: dersCount[index],
                        padding: EdgeInsets.only(top: 5),
                        shrinkWrap: true,
                        itemBuilder: (context, int index2) {
                          return SingleChildScrollView(
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
                                          value: dersler[index][index2],
                                          items: _dropdownMenuItems,
                                          onChanged: (value) {
                                            setState(() {
                                              dersler[index][index2] = value;
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
                                            dersler[index].removeAt(index2);
                                            information[index].removeAt(index2);
                                            dersCount[index] =
                                                dersCount[index] - 1;
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
                                dersCount[index] = dersCount[index] + 1;
                                dersler[index].add(_dropdownMenuItems[0].value);
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
