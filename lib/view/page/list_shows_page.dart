import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_test/core/extensions.dart';
import 'package:jobsity_test/core/injector.dart';
import 'package:jobsity_test/view/bloc/list_shows_bloc.dart';
import 'package:jobsity_test/view/widgets/shows_card.dart';

class ListTVShowsPage extends StatelessWidget {
  const ListTVShowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ListTVShowsBloc(serviceLocator(), serviceLocator()),
      child: const _ListTVShowsView(),
    );
  }
}

class _ListTVShowsView extends StatefulWidget {
  const _ListTVShowsView();

  @override
  State<_ListTVShowsView> createState() => __ListTVShowsView();
}

class __ListTVShowsView extends State<_ListTVShowsView> {
  late final ListTVShowsBloc listTVShowsBloc;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    listTVShowsBloc = context.read<ListTVShowsBloc>()..getShows();
    controller = TextEditingController()
      ..addListener(() {
        if (controller.text.isEmpty) {
          listTVShowsBloc.getShows();
        } else {
          listTVShowsBloc.getFilteredShows(controller.value.text);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ListTVShowsBloc, ListTVShowsState>(
        bloc: listTVShowsBloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              slivers: [
                _ListShowsAppBar(controller: controller),
                if (state is ListTVShowsLoadingState)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                if (state is ListTVShowsSuccessState)
                  if (state.shows.isEmpty)
                    SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'No show was found.',
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                    )
                  else
                    SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 12,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (_, index) => ShowsCard(
                          showsViewModel: state.shows.elementAt(index),
                        ),
                        childCount: state.shows.length,
                      ),
                    )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ListShowsAppBar extends StatelessWidget {
  final TextEditingController controller;

  const _ListShowsAppBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      expandedHeight: 100,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 8),
        title: Column(
          children: [
            const SizedBox(height: kToolbarHeight),
            Flexible(
              child: Text(
                'TV shows',
                style: context.textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: TextField(
                controller: controller,
                style: context.textTheme.bodyMedium,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
        stretchModes: const [StretchMode.fadeTitle],
        collapseMode: CollapseMode.pin,
        centerTitle: true,
      ),
      centerTitle: true,
    );
  }
}
