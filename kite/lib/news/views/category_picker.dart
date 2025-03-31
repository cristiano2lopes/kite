import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kite/common/views/ui_constants.dart';
import 'package:kite/news_category/models/category.dart';
import 'package:pull_down_button/pull_down_button.dart';

class CategoryPickerViewModel {
  final Category? selectedCategory;
  final List<Category> categories;
  final Function(Category category) goToCategory;
  final Function() refreshAction;

  CategoryPickerViewModel({
    required this.selectedCategory,
    required this.categories,
    required this.goToCategory,
    required this.refreshAction,
  });

  String getButtonTitle() {
    return selectedCategory?.name ?? "Pick Category";
  }

  Iterable<Category> getRegionalCategories() {
    return categories.where((c) => c.isForCountry);
  }

  Iterable<Category> getCategories() {
    return categories.where((c) => !c.isForCountry);
  }

  IconData getButtonIcon(Category? cat) {
    return switch (cat?.name ?? "") {
      "World" => Icons.language,
      "Business" => Icons.business,
      "OnThisDay" => Icons.history,
      "Gaming" => Icons.gamepad,
      "Sports" => Icons.scoreboard,
      "Science" => Icons.science,
      "Linux & OSS" || "Technology" => Icons.computer,
      "Crypto" => Icons.currency_bitcoin,
      _ => Icons.tag,
    };
  }
}

class CategoryPicker extends StatelessWidget {
  final CategoryPickerViewModel viewModel;

  const CategoryPicker(this.viewModel, {super.key});

  PullDownMenuEntry categoryBuilder(Category cat){
    final buttonIcon = viewModel.getButtonIcon(cat);
    return PullDownMenuItem(
      onTap: () {
        viewModel.goToCategory(cat);
      },
      title: cat.name,
      icon: buttonIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonTitle = viewModel.getButtonTitle();
    final buttonIcon = viewModel.getButtonIcon(viewModel.selectedCategory);
    return PullDownButton(
      itemBuilder: (context) {
        final cats = viewModel.getCategories().map(categoryBuilder).toList();
        final regions = viewModel.getRegionalCategories().map(categoryBuilder,).toList();
        return [
          const PullDownMenuDivider.large(),
          PullDownMenuActionsRow.medium(
            items: [
              PullDownMenuItem(
                onTap: () {
                  viewModel.refreshAction();
                },
                title: 'Refresh',
                icon: CupertinoIcons.refresh,
              ),
            ],
          ),
          const PullDownMenuDivider.large(),
          const PullDownMenuTitle(title: Text('Global')),
          ...cats,
          const PullDownMenuDivider.large(),
          const PullDownMenuTitle(title: Text('Regional')),
          ...regions,
        ];
      },
      position: PullDownMenuPosition.automatic,
      buttonBuilder:
          (context, showMenu) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: showMenu,
                child: Row(
                  spacing: 5,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(buttonIcon, size: appBarIconSize,),
                    Text(buttonTitle, style: Theme.of(context).textTheme.displayMedium,),
                    Icon(Icons.arrow_downward, size: appBarIconSize),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
