import 'filter_item_model.dart';

class AppliedFilterModel {
  final String filterKey;
  final String? filterTitle;
  final List<FilterItemModel> applied;

  AppliedFilterModel({
    required this.filterKey,
    required this.applied,
    this.filterTitle,
  });

  Map<String, dynamic> toMap() {
    return ({
      'applied_filter': applied.map((e) => e.toMap()).toList(),
      'filter_key': filterKey,
      'filter_title': filterTitle,
    });
  }
}
