import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsity_test/core/extensions.dart';
import 'package:jobsity_test/core/injector.dart';
import 'package:jobsity_test/core/theme.dart';
import 'package:jobsity_test/view/bloc/tv_show_episodes_bloc.dart';
import 'package:jobsity_test/view/model/tv_show_detailed_view_model.dart';
import 'package:jobsity_test/view/page/detailed_episode_page.dart';

class TVShowDetailedPage extends StatelessWidget {
  final TVShowDetailedModel viewModel;

  const TVShowDetailedPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TVShowEpisodesBloc(serviceLocator()),
      child: _TVShowDetailedView(viewModel),
    );
  }
}

class _TVShowDetailedView extends StatefulWidget {
  final TVShowDetailedModel viewModel;

  const _TVShowDetailedView(this.viewModel);

  @override
  State<_TVShowDetailedView> createState() => _TVShowDetailedViewState();
}

class _TVShowDetailedViewState extends State<_TVShowDetailedView> {
  late final TVShowEpisodesBloc tvShowEpisodesBloc;

  @override
  void initState() {
    super.initState();
    tvShowEpisodesBloc = context.read<TVShowEpisodesBloc>()
      ..getTvShowEpisodes(widget.viewModel.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TVShowEpisodesBloc, TVShowEpisodesState>(
        bloc: tvShowEpisodesBloc,
        builder: (context, state) {
          return DefaultTabController(
            length:
                state is TVShowEpisodesSuccessState ? state.shows.length : 0,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      widget.viewModel.imageUrl,
                      fit: BoxFit.fill,
                    ),
                    stretchModes: const [StretchMode.fadeTitle],
                    collapseMode: CollapseMode.pin,
                    centerTitle: true,
                  ),
                  centerTitle: true,
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        widget.viewModel.name,
                        style: context.textTheme.titleLarge,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: TVShowInformation(
                    genres: widget.viewModel.genres,
                    scheduledTime: widget.viewModel.scheduledTime,
                    summary: widget.viewModel.summary,
                  ),
                ),
                if (state is TVShowEpisodesLoadingState)
                  const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                if (state is TVShowEpisodesFailedState)
                  SliverToBoxAdapter(
                    child: Text(
                      state.error,
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                if (state is TVShowEpisodesSuccessState) ...[
                  SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    sliver: SliverToBoxAdapter(
                      child: Text(
                        'Seasons',
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: TabBar(
                      tabs: state.shows.entries
                          .map(
                            (show) => Tab(
                              text: '${show.key}',
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ]
              ],
              body: state is TVShowEpisodesSuccessState
                  ? TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: state.shows.entries
                          .map(
                            (show) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: show.value
                                    .map(
                                      (episode) => Flexible(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    DetailedEpisodePage(
                                                  viewModel: episode,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Card(
                                            color: AppColors.lightPrimary,
                                            child: Center(
                                              child: Text(
                                                episode.name,
                                                style: context
                                                    .textTheme.bodyMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}

class TVShowInformation extends StatelessWidget {
  final Iterable<String> genres;
  final String scheduledTime;
  final String summary;

  const TVShowInformation({
    super.key,
    required this.genres,
    required this.scheduledTime,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            scheduledTime,
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Genre(s):',
            style: context.textTheme.titleMedium,
          ),
          for (final genre in genres) Text(genre),
          const SizedBox(height: 8),
          Text(summary),
        ],
      ),
    );
  }
}
