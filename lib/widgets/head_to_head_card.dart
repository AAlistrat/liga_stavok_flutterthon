import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:liga_stavok_flutterthon/blocs/blocs.dart';
import 'package:liga_stavok_flutterthon/blocs/head_to_head_bloc.dart';
import 'package:liga_stavok_flutterthon/constants.dart';

class HeadToHeadCard extends StatefulWidget {
  @override
  _HeadToHeadCardState createState() => _HeadToHeadCardState();
}

class _HeadToHeadCardState extends State<HeadToHeadCard> {
  String team1Name = 'Croatia';
  String team2Name = 'Spain';

  @override
  Widget build(BuildContext context) {
    team1Name = AppLocalizations.of(context).croatia;
    team2Name = AppLocalizations.of(context).spain;
    Map<String, String> teamIds = {
      team1Name: 'sr:competitor:4715',
      team2Name: 'sr:competitor:4698',
    };
    return Card(
      child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      AppLocalizations.of(context).headToHeadTitle,
                      style: cardTitleTextStyle,
                    ),
                  ),
                  IconButton(
                    visualDensity: VisualDensity.compact,
                    icon: Icon(Icons.refresh, color: colorGreen, size: 24),
                    onPressed: () {
                      BlocProvider.of<HeadToHeadBloc>(context)
                          .add(HeadToHeadRequested(
                        langCode: Localizations.localeOf(context).languageCode,
                        team1id: teamIds[team1Name],
                        team2id: teamIds[team2Name],
                      ));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconEnabledColor: colorGreen,
                      isDense: true,
                      value: team1Name,
                      onChanged: (value) => setState(() => team1Name = value),
                      items: [AppLocalizations.of(context).croatia].map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: cardSubTitleTextStyle),
                        );
                      }).toList(),
                    ),
                  ),
                  Text('/ ', style: TextStyle(fontSize: 18)),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      iconEnabledColor: colorGreen,
                      isDense: true,
                      value: team2Name,
                      onChanged: (value) => setState(() => team2Name = value),
                      items: [AppLocalizations.of(context).spain].map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: cardSubTitleTextStyle),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Container(
                height: 0.5,
                width: double.infinity,
                color: colorGreenDark,
              ),
              Expanded(
                child: BlocBuilder<HeadToHeadBloc, HeadToHeadState>(
                  builder: (context, state) {
                    if (state is HeadToHeadInitial) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context).headToHeadInitial,
                          style: cardMessageTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    if (state is HeadToHeadLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is HeadToHeadFailure) {
                      return Center(
                        child: Text(
                          AppLocalizations.of(context).headToHeadFailure,
                          style: cardMessageTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    if (state is HeadToHeadSuccess) {
                      final headToHeadTable = state.headToHeadTable;

                      return ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: headToHeadTable.scoreTable.length + 1,
                        itemBuilder: (context, i) {
                          return i == 0
                              ? Text(
                            headToHeadTable.lastUpdated,
                            textAlign: TextAlign.right,
                          )
                              : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: 0.5,
                                width: double.infinity,
                                color: colorGreen60,
                              ),
                              SizedBox(height: 0.5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width:
                                    0.28 * MediaQuery.of(context).size.width,
                                    child: Text(
                                      headToHeadTable
                                          .scoreTable[i - 1].seasonName,
                                      softWrap: true,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                    0.12 * MediaQuery.of(context).size.width,
                                    child: Text(
                                      headToHeadTable.scoreTable[i - 1].date.substring(0,4)+'\n'+headToHeadTable.scoreTable[i - 1].date.substring(5,10),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                    0.19 * MediaQuery.of(context).size.width,
                                    child: Text(
                                      headToHeadTable.scoreTable[i - 1].homeTeam,
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                  SizedBox(
                                      width: 0.05 *
                                          MediaQuery.of(context).size.width,
                                      child: Text(
                                        headToHeadTable
                                            .scoreTable[i - 1].homeScore,
                                        textAlign: TextAlign.center,
                                      )),
                                  Text(':'),
                                  SizedBox(
                                      width: 0.05 *
                                          MediaQuery.of(context).size.width,
                                      child: Text(
                                        headToHeadTable
                                            .scoreTable[i - 1].awayScore,
                                        textAlign: TextAlign.center,
                                      )),
                                  SizedBox(
                                      width: 0.19 *
                                          MediaQuery.of(context).size.width,
                                      child: Text(
                                        headToHeadTable
                                            .scoreTable[i - 1].awayTeam,
                                        textAlign: TextAlign.left,
                                      )),
                                ],
                              ),
                              SizedBox(height: 0.5),
                            ],
                          );
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              ),
            ],
        ),
    );
  }
}
