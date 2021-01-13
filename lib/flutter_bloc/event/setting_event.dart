import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/*SETTING EVENT
* switch thay đổi từ độ C => độ F
*
* */

abstract class SettingEvent extends Equatable{
}

class SettingEventToggleUnit extends SettingEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}