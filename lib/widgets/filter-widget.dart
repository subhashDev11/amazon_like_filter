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

  @override
  void initState() {
    // TODO: implement initState
    _filterCubit = context.read<FilterCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (_, state) {
        final themeProps = _filterCubit.filterProps.themeProps;
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: FilterText(
                  title: _filterCubit.filterProps.title ?? 'Filters',
                  style: themeProps?.titleStyle,
                  fontColor: themeProps?.titleColor,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              themeProps?.divider ??
                  Divider(
                    height: 1,
                    thickness: themeProps?.dividerThickness ?? 1,
                    color: themeProps?.dividerColor ?? getDividerColor(context),
                  ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
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
                      flex: 8,
                      child: Builder(builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 17,
                                  horizontal: 10,
                                ),
                                child: FilterText(
                                  title:
                                      'Showing for ${state.filters[state.activeFilterIndex].title ?? ''}',
                                  style: themeProps?.activeFilterHeaderStyle ??
                                      getTitle2Theme(context)?.copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            themeProps?.activeFilterHeaderColor,
                                      ),
                                ),
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
                                    return Expanded(
                                      child: ListView.builder(
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
                                      ),
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
}
