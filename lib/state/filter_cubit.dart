import 'package:amazon_like_filter/props/applied_filter_model.dart';
import 'package:amazon_like_filter/props/filter_item_model.dart';
import 'package:amazon_like_filter/props/filter_list_model.dart';
import 'package:amazon_like_filter/props/filter_props.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit({
    required this.filterProps,
  }) : super(
          FilterState.init(
            filters: filterProps.filters,
            activeFilterIndex: 0,
          ),
        );

  final FilterProps filterProps;

  bool checked(List<FilterItemModel> items, FilterItemModel item) {
    return items.contains(item);
  }

  onFilterTitleTap(int index) {
    emit(state.copyWith(
      activeFilterIndex: index,
    ));
  }

  void onFilterItemCheck(FilterItemModel item) {
    List<FilterListModel> filterModels = [...state.filters];
    FilterListModel filterItem = filterModels[state.activeFilterIndex];
    final checkedItems = [...filterItem.previousApplied];
    if (checkedItems.contains(item)) {
      checkedItems.remove(item);
    } else {
      checkedItems.add(item);
    }
    final updatedItem = filterItem.copyWith(
      previousApplied: checkedItems,
    );
    filterModels[state.activeFilterIndex] = updatedItem;
    emit(state.copyWith(
      filters: filterModels,
    ));
  }

  void onFilterSubmit() {
    final appliedFilters = <AppliedFilterModel>[];
    for (var element in state.filters) {
      appliedFilters.add(AppliedFilterModel(
        filterKey: element.filterKey,
        applied: element.previousApplied,
        filterTitle: element.title,
      ));
    }
    if (filterProps.onFilterChange != null) {
      filterProps.onFilterChange!(appliedFilters);
    }
  }

  void onFilterRemove() {
    final clearFilterList = <FilterListModel>[];
    final filtered = [...state.filters];
    for (var element in filtered) {
      final newModel = element.copyWith(
        previousApplied: [],
      );
      clearFilterList.add(newModel);
    }
    emit(state.copyWith(
      filters: clearFilterList,
    ));
    if (filterProps.onFilterChange != null) {
      filterProps.onFilterChange!([]);
    }
  }
}
