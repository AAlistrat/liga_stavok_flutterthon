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
      child: ListTile(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context).headToHeadTitle),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: Icon(Icons.refresh, color: colorGreen),
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
                        child: Text(value, style: TextStyle(color: colorGreen)),
                      );
                    }).toList(),
                  ),
                ),
                Text('/ '),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    iconEnabledColor: colorGreen,
                    isDense: true,
                    value: team2Name,
                    onChanged: (value) => setState(() => team2Name = value),
                    items: [AppLocalizations.of(context).spain].map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: colorGreen)),
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
          ],
        ),
        subtitle: BlocBuilder<HeadToHeadBloc, HeadToHeadState>(
          builder: (context, state) {
            if (state is HeadToHeadInitial) {
              return Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Text(
                  AppLocalizations.of(context).headToHeadInitial,
                  textAlign: TextAlign.center,
                ),
              );
            }
            if (state is HeadToHeadLoading) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 78.0, horizontal: 156),
                child: CircularProgressIndicator(),
              );
            }
            if (state is HeadToHeadFailure) {
              return Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Text(
                  AppLocalizations.of(context).headToHeadFailure,
                ),
              );
            }
            if (state is HeadToHeadSuccess) {
              final headToHeadTable = state.headToHeadTable;

              return ListView.builder(
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
                              color: colorGreenDark,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width:
                                      0.24 * MediaQuery.of(context).size.width,
                                  child: Text(
                                    headToHeadTable
                                        .scoreTable[i - 1].seasonName,
                                    softWrap: true,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      0.2 * MediaQuery.of(context).size.width,
                                  child: Text(
                                    headToHeadTable.scoreTable[i - 1].date,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      0.15 * MediaQuery.of(context).size.width,
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
                                    width: 0.15 *
                                        MediaQuery.of(context).size.width,
                                    child: Text(
                                      headToHeadTable
                                          .scoreTable[i - 1].awayTeam,
                                      textAlign: TextAlign.left,
                                    )),
                              ],
                            ),
                          ],
                        );
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
