import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:journeytothewest/src/viewmodel/scenario_add_viewmodel.dart';

class ScenarioDetailPage extends StatelessWidget {
  final ScenarioAddViewModel model;

  ScenarioDetailPage({this.model});

  Future _selectDateStart(BuildContext context) async {
    final DateTime datePicked = await showDatePicker(
        context: null,
        initialDate: null,
        firstDate: null,
        lastDate: null
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}