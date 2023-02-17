import 'package:equatable/equatable.dart';

class FilterItemModel extends Equatable {
  final String filterTitle;
  final String filterKey;

  const FilterItemModel({
    required this.filterTitle,
    required this.filterKey,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        filterTitle,
        filterKey,
      ];
}
