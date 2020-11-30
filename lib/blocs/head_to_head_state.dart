import 'package:liga_stavok_flutterthon/models/head_to_head.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class HeadToHeadState extends Equatable {
  const HeadToHeadState();

  @override
  List<Object> get props => [];
}

class HeadToHeadInitial extends HeadToHeadState {}
class HeadToHeadLoading extends HeadToHeadState {}
class HeadToHeadSuccess extends HeadToHeadState {
  final HeadToHead headToHeadTable;
  const HeadToHeadSuccess({@required this.headToHeadTable}) : assert(headToHeadTable!=null);
  @override
  List<Object> get props => [headToHeadTable];
}
class HeadToHeadFailure extends HeadToHeadState {}