import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ohmi/bloc/getPerson.dart';
import 'package:ohmi/modals/personResponse.dart';
import 'package:ohmi/widgets/loadingIndicator.dart';
import '../constant.dart' as Style;

class PopularPersons extends StatefulWidget {
  PopularPersons({Key key}) : super(key: key);

  @override
  _PopularPersonState createState() => _PopularPersonState();
}

class _PopularPersonState extends State<PopularPersons> {
  @override
  void initState() {
    personBloc..getPersons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Trending Person Of the Week',
              style: TextStyle(
                color: Style.ColorTheme.titleColor.withOpacity(0.7),
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 7,
          ),
          StreamBuilder<PersonResponse>(
            stream: personBloc.subject,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.error.isEmpty &&
                    snapshot.data.error.length > 0) {
                  return _buildErrorWidget(snapshot.data.error);
                } else {
                  if (snapshot.data.persons.isEmpty) {
                    return Text('No person');
                  }
                  return _buildPersonWidget(snapshot.data);
                }
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error);
              } else {
                return LoadingIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPersonWidget(PersonResponse response) {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return response.persons[index].profileImage == null
              ? Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Style.ColorTheme.secondColor,
                      ),
                      child: Icon(EvaIcons.person),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Actor Name',
                      style: TextStyle(
                        color: Style.ColorTheme.titleColor.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Known For',
                      style: TextStyle(
                        color: Style.ColorTheme.titleColor.withOpacity(0.7),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                Style.ColorTheme.secondColor.withOpacity(0.8),
                          ),
                          child: Icon(EvaIcons.person),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w200${response.persons[index].profileImage}'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 100,
                      child: Text(
                        '${response.persons[index].name}',
                        style: TextStyle(
                          color: Style.ColorTheme.titleColor.withOpacity(0.9),
                        ),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Trending For ${response.persons[index].known}',
                      style: TextStyle(
                        color: Style.ColorTheme.titleColor.withOpacity(0.5),
                        fontWeight: FontWeight.w300,
                        fontSize: 10,
                      ),
                    ),
                  ],
                );
        },
        itemCount: response.persons.length,
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Text(
        error,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
