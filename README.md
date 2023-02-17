
# AmazonLikeFilter

AmazonLikeFilter is an widget that is used to build Filter UI like as amazon app.

## Motivation
Main motivation behind this package was one of my project feature is required to add filter UI with multiple filter options.
## Authors

- [@subhashDev11](https://github.com/subhashDev11)


## Demo



## Features

- Nested filter option
- Filter result on change
- Reset filter 
- Submit filter
- View can be open through scaffold, dialog or bottom sheet

## Documentation

## Usage/Examples

```dart
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
                    onFilterChange: (value) {
                      setState(() {
                        applied = value;
                      });
                      print('Applied filer - ${value.map((e) => e.toMap())}');
                    },
                    filters: const [
                      FilterListModel(
                        filterOptions: [
                          FilterItemModel(filterTitle: 'Education', filterKey: 'education'),
                          FilterItemModel(
                            filterTitle: 'Information Technology',
                            filterKey: 'it',
                          ),
                          FilterItemModel(filterTitle: 'Sports', filterKey: 'sports'),
                          FilterItemModel(filterTitle: 'Transport', filterKey: 'transport'),
                        ],
                        previousApplied: [],
                        title: 'Industry',
                        filterKey: 'industry',
                      ),
                      FilterListModel(
                        filterOptions: [
                          FilterItemModel(filterTitle: 'Utter Pradesh', filterKey: 'up'),
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

```

## 🚀 About Me
I'm a flutter developer...


## 🔗 Links
[![portfolio](https://img.shields.io/badge/my_portfolio-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://subhashdev121.github.io/subhash/#/)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/subhashcs)
[![medium](https://img.shields.io/badge/medium-000?style=for-the-badge&logo=medium&logoColor=white)](https://medium.com/@subhashchandrashukla)

![Logo](https://i.ibb.co/2szbbHF/code-xposer.png)


## License

[MIT](https://choosealicense.com/licenses/mit/)

