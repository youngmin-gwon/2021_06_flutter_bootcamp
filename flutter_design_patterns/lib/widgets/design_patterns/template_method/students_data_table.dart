import 'package:flutter/material.dart';
import 'package:flutter_design_patterns/constants/layout_constants.dart';

import 'package:flutter_design_patterns/design_patterns/template-method/student.dart';

class StudentsDataTable extends StatelessWidget {
  const StudentsDataTable({
    Key? key,
    required this.students,
  }) : super(key: key);

  final List<Student> students;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: LayoutConstants.spaceM,
        horizontalMargin: LayoutConstants.marginM,
        headingRowHeight: LayoutConstants.spaceXL,
        dataRowHeight: LayoutConstants.spaceXL,
        columns: const <DataColumn>[
          DataColumn(
            label: Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
          ),
          DataColumn(
            label: Text(
              'Age',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'Height',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'Weight',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'BMI',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            ),
            numeric: true,
          ),
        ],
        rows: <DataRow>[
          for (var student in students)
            DataRow(cells: <DataCell>[
              DataCell(Text(student.fullName)),
              DataCell(Text(student.age.toString())),
              DataCell(Text(student.height.toString())),
              DataCell(Text(student.weight.toString())),
              DataCell(
                Text(
                  student.bmi.toStringAsFixed(2),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ])
        ],
      ),
    );
  }
}
