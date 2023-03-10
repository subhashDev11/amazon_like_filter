/// Main widget for filtering data
/// Required parametter is FilterProps  

import 'package:amazon_like_filter/filter_style_mixin.dart';
import 'package:amazon_like_filter/state/filter_cubit.dart';
import 'package:amazon_like_filter/props/filter_props.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter_checkbox_title.dart';
import 'filter_text.dart';
import 'filter_text_button.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({
    Key? key,
    required this.filterProps,
  }) : super(key: key);

  final FilterProps filterProps;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FilterCubit(
        filterProps: filterProps,
      ),
      child: const Filter(),
    );
  }
}

class Filter extends StatefulWidget {
  const Filter({
    Key? key,
  }) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> with FilterStyleMixin {
  late FilterCubit _filterCubit;

  final _searchValueNotifier = ValueNotifier<String>('');
  final _searchController = TextEditingController();

  @override
  void initState() {
    _filterCubit = context.read<FilterCubit>();
    super.initState();
  }

  void _clearSearch() {
    _searchValueNotifier.value = '';
    _searchController.clear();
    _filterCubit.clearSearch();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (_, state) {
        final themeProps = _filterCubit.filterProps.themeProps;
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FilterText(
                      title: _filterCubit.filterProps.title ?? 'Filters',
                      style: themeProps?.titleStyle,
                      fontColor: themeProps?.titleColor,
                    ),
                    Visibility(
                      visible: (_filterCubit.filterProps.showCloseIcon ?? true),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        visualDensity: const VisualDensity(
                          horizontal: -4,
                          vertical: -4,
                        ),
                        onPressed: () {
                          if (_filterCubit.filterProps.onCloseTap != null) {
                            _filterCubit.filterProps.onCloseTap!();
                          }
                          Navigator.of(context).pop();
                        },
                        icon: _filterCubit.filterProps.closeIcon ??
                            const Icon(Icons.close),
                      ),
                    )
                  ],
                ),
              ),
              themeProps?.divider ??
                  Divider(
                    height: 1,
                    thickness: themeProps?.dividerThickness ?? 1,
                    color: themeProps?.dividerColor ?? getDividerColor(context),
                  ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            ...List.generate(state.filters.length, (index) {
                              final e = state.filters[index];
                              return GestureDetector(
                                onTap: () {
                                  _clearSearch();
                                  _filterCubit.onFilterTitleTap(index);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                    top: 10,
                                  ),
                                  child: FilterText(
                                    title: e.title,
                                    fontSize: 17,
                                    style: (index == state.activeFilterIndex)
                                        ? themeProps?.activeFilterTextStyle
                                        : themeProps?.inActiveFilterTextStyle,
                                    fontWeight: FontWeight.w500,
                                    fontColor: (index ==
                                            state.activeFilterIndex)
                                        ? themeProps?.activeFilterTextColor ??
                                            getTheme(context).primaryColor
                                        : themeProps?.inActiveFilterTextColor,
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                    themeProps?.divider ??
                        Container(
                          height: double.maxFinite,
                          width: themeProps?.dividerThickness ?? 1,
                          color: themeProps?.dividerColor ??
                              getDividerColor(context),
                        ),
                    Expanded(
                      flex: 6,
                      child: Builder(builder: (context) {
                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(10),
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 7,
                                ),
                                child: ValueListenableBuilder<String>(
                                    valueListenable: _searchValueNotifier,
                                    builder: (context, searchValue, child) {
                                      return TextFormField(
                                        controller: _searchController,
                                        style: themeProps
                                            ?.searchBarViewProps?.textStyle,
                                        decoration: InputDecoration(
                                            hintText: themeProps
                                                    ?.searchBarViewProps
                                                    ?.searchHint ??
                                                'Search',
                                            /*contentPadding:
                                                const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 10,
                                            ),*/
                                            hintStyle: themeProps
                                                ?.searchBarViewProps?.hintStyle,
                                            fillColor: themeProps
                                                    ?.searchBarViewProps
                                                    ?.fillColor
                                                    ?.withOpacity(0.8) ??
                                                Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.1),
                                            filled: themeProps
                                                    ?.searchBarViewProps
                                                    ?.filled ??
                                                true,
                                            border: themeProps
                                                    ?.searchBarViewProps
                                                    ?.inputBorder ??
                                                OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: themeProps
                                                            ?.searchBarViewProps
                                                            ?.fillColor ??
                                                        getTheme(context)
                                                            .primaryColor,
                                                  ),
                                                ),
                                            suffixIcon: searchValue.isNotEmpty
                                                ? IconButton(
                                                    onPressed: () {
                                                      _clearSearch();
                                                    },
                                                    icon: themeProps
                                                            ?.searchBarViewProps
                                                            ?.clearIcon ??
                                                        Icon(Icons.close,
                                                            color: themeProps
                                                                ?.searchBarViewProps
                                                                ?.clearIconColor),
                                                  )
                                                : IconButton(
                                                    onPressed: () {
                                                      _filterCubit
                                                          .filterBySearch(
                                                              _searchController
                                                                  .text);
                                                    },
                                                    icon: themeProps
                                                            ?.searchBarViewProps
                                                            ?.searchIcon ??
                                                        Icon(
                                                          Icons.search,
                                                          color: themeProps
                                                              ?.searchBarViewProps
                                                              ?.searchIconColor,
                                                        ),
                                                  )),
                                        onFieldSubmitted: (value) {},
                                        textInputAction: TextInputAction.search,
                                        onChanged: (value) {
                                          _searchValueNotifier.value = value;
                                          if (value.isEmpty) {
                                            _clearSearch();
                                          } else {
                                            _filterCubit.filterBySearch(
                                                _searchController.text);
                                          }
                                        },
                                      );
                                    }),
                                /*FilterText(
                                  title:
                                      'Showing for ${state.filters[state.activeFilterIndex].title ?? ''}',
                                  style: themeProps?.activeFilterHeaderStyle ??
                                      getTitle2Theme(context)?.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            themeProps?.activeFilterHeaderColor,
                                      ),
                                ),*/
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Builder(
                                builder: (_) {
                                  final list = state
                                      .filters[state.activeFilterIndex]
                                      .filterOptions;
                                  if (list.isNotEmpty) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: list.length,
                                      itemBuilder: (_, index) {
                                        final item = list[index];
                                        return FilterCheckboxTitle(
                                          checkBoxTileThemeProps: themeProps
                                              ?.checkBoxTileThemeProps,
                                          selected: _filterCubit.checked(
                                            state
                                                .filters[
                                                    state.activeFilterIndex]
                                                .previousApplied,
                                            item,
                                          ),
                                          title: item.filterTitle,
                                          onUpdate: (bool? value) {
                                            _filterCubit
                                                .onFilterItemCheck(item);
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),
          bottomSheet: SizedBox(
            height: 60,
            child: Card(
              color: getTheme(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilterTextButton(
                    text: 'Reset',
                    isSecondary: true,
                    onTap: () {
                      _filterCubit.onFilterRemove();
                      Navigator.of(context).pop();
                    },
                    style: themeProps?.resetButtonStyle,
                    txtColor: themeProps?.resetButtonColor,
                  ),
                  FilterTextButton(
                    text: 'Apply',
                    txtColor: themeProps?.submitButtonColor ??
                        getTheme(context).colorScheme.secondary,
                    onTap: () {
                      _filterCubit.onFilterSubmit();
                      Navigator.of(context).pop();
                    },
                    style: themeProps?.submitButtonStyle,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchValueNotifier.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
