import 'package:uni_grade/Notlar.dart';

class Information {
  String courseName;
  int ects;
  Notlar grade;

  Information(this.courseName, this.ects, this.grade);

  Map toJson() {
    Map grade = this.grade != null ? this.grade.toJson() : null;

    return {'courseName': courseName, 'ects': ects, 'grade': grade};
  }
}