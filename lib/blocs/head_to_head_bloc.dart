import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:liga_stavok_flutterthon/api_client/sportradar_api_client.dart';
import 'package:liga_stavok_flutterthon/models/models.dart';
import 'package:liga_stavok_flutterthon/blocs/blocs.dart';

class HeadToHeadBloc extends Bloc<HeadToHeadEvent, HeadToHeadState> {
  final SportRadarApiClient sportRadarApiClient;
  HeadToHeadBloc({@required this.sportRadarApiClient}) : assert(sportRadarApiClient!=null),super(HeadToHeadInitial());

  @override
  Stream<HeadToHeadState> mapEventToState(HeadToHeadEvent event) async* {
    if (event is HeadToHeadRequested) {
      yield HeadToHeadLoading();
      try {
        final HeadToHead headToHeadTable = await sportRadarApiClient.getHeadToHead(event.langCode,event.team1id, event.team2id);
        yield HeadToHeadSuccess(headToHeadTable: headToHeadTable);
      } catch (_) {
        yield HeadToHeadFailure();
      }
    }
  }
}