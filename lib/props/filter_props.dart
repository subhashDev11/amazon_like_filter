import 'package:amazon_like_filter/props/filter_item_model.dart';
import 'package:amazon_like_filter/props/filter_list_model.dart';

class FilterProps {
  final List<FilterListModel> filters;
  final String? title;

  final Function(List<FilterItemModel> value, int index)? onFilterChange;

  FilterProps({
    required this.filters,
    this.onFilterChange,
    this.title,
  });
}
