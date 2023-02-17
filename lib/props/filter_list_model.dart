import 'package:amazon_like_filter/props/filter_item_model.dart';
import 'package:equatable/equatable.dart';

class FilterListModel extends Equatable {
  final String? title;
  final List<FilterItemModel> filterOptions;
  final List<FilterItemModel> previousApplied;

  const FilterListModel({
    this.title,
    required this.filterOptions,
    required this.previousApplied,
  });

  FilterListModel copyWith({
    List<FilterItemModel>? filterOptions,
    List<FilterItemModel>? previousApplied,
    String? title,
  }) {
    return FilterListModel(
      title: title ?? this.title,
      filterOptions: filterOptions ?? this.filterOptions,
      previousApplied: previousApplied ?? this.previousApplied,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        title,
        filterOptions,
        previousApplied,
      ];
}
