import 'package:flutter/material.dart';
import 'package:izukbs/drawer.dart';
import 'package:izukbs/widgets/custom_appbar.dart';

class Course {
  final String name;
  String grade;
  final int credit;

  Course({
    required this.name,
    required this.grade,
    required this.credit,
  });

  Map<String, String> toMap() {
    return {name: grade};
  }
}

class transkript extends StatefulWidget {
  const transkript({super.key});

  @override
  State<transkript> createState() => _TranskriptState();
}

class _TranskriptState extends State<transkript> {
  late Map<String, List<Course>> semesters;

  final Map<String, List<Course>> originalSemesters = {
    '1. Yarıyıl': [
      Course(name: 'Veri Yapıları', grade: 'AA', credit: 6),
      Course(name: 'Algoritmalar', grade: 'BB', credit: 5),
      Course(name: 'Matematik', grade: 'BA', credit: 5),
    ],
    '2. Yarıyıl': [
      Course(name: 'Olasılık ve İstatistik', grade: 'CC', credit: 6),
      Course(name: 'Makine Öğrenmesi', grade: 'BA', credit: 6),
      Course(name: 'Mobil Programlama', grade: 'BB', credit: 6),
    ],
    '3. Yarıyıl': [
      Course(name: 'Veri Tabanı Yönetimi', grade: 'AA', credit: 6),
      Course(name: 'Yapay Zeka', grade: 'BB', credit: 5),
      Course(name: 'WEB Programlama', grade: 'BA', credit: 5),
    ],
    '4. Yarıyıl': [
      Course(name: 'Veri Yapıları', grade: 'AA', credit: 6),
      Course(name: 'Algoritmalar', grade: 'BB', credit: 5),
      Course(name: 'Matematik', grade: 'BA', credit: 5),
      Course(name: 'Matematik', grade: 'BA', credit: 5),
    ],
    '5. Yarıyıl': [
      Course(name: 'Veri Yapıları', grade: 'AA', credit: 6),
      Course(name: 'Algoritmalar', grade: 'BB', credit: 5),
      Course(name: 'Matematik', grade: 'BA', credit: 5),
      Course(name: 'Matematik', grade: 'BA', credit: 5),
      Course(name: 'Matematik', grade: 'BA', credit: 5),
      Course(name: 'Matematik', grade: 'BA', credit: 5),
    ],
  };

  @override
  void initState() {
    super.initState();
    semesters = _deepCopy(originalSemesters);
  }

  Map<String, List<Course>> _deepCopy(Map<String, List<Course>> source) {
    return source.map((key, value) => MapEntry(
      key,
      value
          .map((course) => Course(
        name: course.name,
        grade: course.grade,
        credit: course.credit,
      ))
          .toList(),
    ));
  }

  double calculateGPA() {
    double totalPoints = 0;
    int totalCredits = 0;
    final gradePoints = {
      'AA': 4.0,
      'BA': 3.5,
      'BB': 3.0,
      'CB': 2.5,
      'CC': 2.0,
      'DC': 1.5,
      'DD': 1.0,
      'FD': 0.5,
      'FF': 0.0,
    };

    semesters.forEach((semester, courses) {
      for (var course in courses) {
        if (gradePoints.containsKey(course.grade)) {
          totalPoints += gradePoints[course.grade]! * course.credit;
          totalCredits += course.credit;
        }
      }
    });

    return totalCredits > 0 ? totalPoints / totalCredits : 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final gpa = calculateGPA();

    return Scaffold(
      backgroundColor: Color(0xFFF0F0F0),
      appBar: const CustomAppBar(title: "Transkript"),
      drawer: drawer(),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/circles.png',
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'AGNO:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B2231),
                      ),
                    ),
                    Text(
                      gpa.toStringAsFixed(2),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8B2231),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {
                        semesters = _deepCopy(originalSemesters);
                      });
                    },
                    child: ListView(
                      children: semesters.keys.map((semester) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ExpansionTile(
                            title: Text(semester,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            children: semesters[semester]!
                                .asMap()
                                .entries
                                .map((entry) {
                              final course = entry.value;
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Card(
                                  color: Color(0xFFF6F6F6).withValues(alpha: 0.8),
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: ListTile(
                                    title: Text(
                                      course.name,
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                    subtitle: Text(
                                      '${course.credit} AKTS',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600]),
                                    ),
                                    trailing: DropdownButton<String>(
                                      value: course.grade,
                                      underline: SizedBox(),
                                      icon: Icon(Icons.edit,size: 20, color: Color(0xFF8B2231)),
                                      items: [
                                        'AA',
                                        'BA',
                                        'BB',
                                        'CB',
                                        'CC',
                                        'DC',
                                        'DD',
                                        'FD',
                                        'FF'
                                      ].map((String grade) {
                                        return DropdownMenuItem<String>(
                                          value: grade,
                                          child: Text(grade),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          setState(() {
                                            course.grade = newValue;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}