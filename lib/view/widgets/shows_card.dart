import 'package:flutter/material.dart';
import 'package:jobsity_test/core/extensions.dart';
import 'package:jobsity_test/core/theme.dart';
import 'package:jobsity_test/view/list_shows_view_mapper.dart';
import 'package:jobsity_test/view/model/list_shows_view_model.dart';
import 'package:jobsity_test/view/page/detailed_show_page.dart';

class ShowsCard extends StatelessWidget {
  final ListTVShowsViewModel showsViewModel;

  const ShowsCard({
    super.key,
    required this.showsViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => TVShowDetailedPage(
              viewModel:
                  ListTVShowsViewMapper.listViewToDetailedView(showsViewModel),
            ),
          ),
        );
      },
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        color: AppColors.lightPrimary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Hero(
                  tag: showsViewModel.imageUrl,
                  child: Image.network(
                    showsViewModel.imageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Hero(
                tag: showsViewModel.name + showsViewModel.id.toString(),
                child: Text(
                  showsViewModel.name,
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
