import 'package:amazon_like_filter/amazon_like_filter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Amazon like filter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<AppliedFilterModel> applied = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Visibility(
              visible: applied.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: Text(
                  'Applied filters',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            ...applied
                .map(
                  (e) => ExpansionTile(
                    title: Text(e.filterTitle ?? '${e.filterKey.split('_')}'),
                    children: e.applied
                        .map((fil) => ListTile(
                              title: Text(fil.filterTitle),
                            ))
                        .toList(),
                  ),
                )
                .toList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return FilterWidget(
                  filterProps: FilterProps(
                themeProps: ThemeProps(
                    checkBoxTileThemeProps: CheckBoxTileThemeProps(
                      activeCheckBoxColor: Colors.green,
                    ),
                    dividerThickness: 5,
                    searchBarViewProps: SearchBarViewProps(
                      filled: false,
                    )),
                onFilterChange: (value) {
                  setState(() {
                    applied = value;
                  });
                  print('Applied filer - ${value.map((e) => e.toMap())}');
                },
                filters: const [
                  FilterListModel(
                    filterOptions: [
                      FilterItemModel(
                          filterTitle: 'Education', filterKey: 'education'),
                      FilterItemModel(
                        filterTitle: 'Information Technology',
                        filterKey: 'it',
                      ),
                      FilterItemModel(
                          filterTitle: 'Sports', filterKey: 'sports'),
                      FilterItemModel(
                          filterTitle: 'Transport', filterKey: 'transport'),
                    ],
                    previousApplied: [],
                    title: 'Industry',
                    filterKey: 'industry',
                  ),
                  FilterListModel(
                    filterOptions: [
                      FilterItemModel(
                          filterTitle: 'Utter Pradesh', filterKey: 'up'),
                      FilterItemModel(
                        filterTitle: 'Madhya Pradesh',
                        filterKey: 'mp',
                      ),
                      FilterItemModel(filterTitle: 'Hariyana', filterKey: 'hr'),
                      FilterItemModel(filterTitle: 'Bihar', filterKey: 'bihar'),
                    ],
                    previousApplied: [],
                    title: 'State',
                    filterKey: 'state',
                  )
                ],
              ));
            },
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
