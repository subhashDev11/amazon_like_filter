import 'package:amazon_like_filter/props/applied_filter_model.dart';
import 'package:amazon_like_filter/props/filter_list_model.dart';

class FilterProps {
  final List<FilterListModel> filters;
  final String? title;

  final Function(List<AppliedFilterModel> appliedFilterModel)? onFilterChange;

  FilterProps({
    required this.filters,
    this.onFilterChange,
    this.title,
  });
}
