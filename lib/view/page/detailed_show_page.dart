// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:jobsity_test/core/extensions.dart';
import 'package:jobsity_test/core/injector.dart';
import 'package:jobsity_test/core/theme.dart';
import 'package:jobsity_test/view/bloc/tv_show_episodes_bloc.dart';
import 'package:jobsity_test/view/model/tv_show_detailed_view_model.dart';
import 'package:jobsity_test/view/model/tv_show_episode_view_model.dart';
import 'package:jobsity_test/view/page/detailed_episode_page.dart';

class TVShowDetailedPage extends StatelessWidget {
  final TVShowDetailedModel viewModel;

  const TVShowDetailedPage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TVShowEpisodesBloc(serviceLocator()),
      child: Builder(
        builder: (context) {
          return BlocBuilder<TVShowEpisodesBloc, TVShowEpisodesState>(
            builder: (context, state) => DefaultTabController(
              length:
                  state is TVShowEpisodesSuccessState ? state.shows.length : 0,
              child: Builder(
                builder: (context) {
                  return _TVShowDetailedView(viewModel);
                },
              ),
            ),
          );
        },
      ),
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
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tvShowEpisodesBloc = context.read<TVShowEpisodesBloc>()
      ..getTvShowEpisodes(widget.viewModel.id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!DefaultTabController.of(context).hasListeners) {
      DefaultTabController.of(context).addListener(() {
        setState(() {
          _currentTabIndex = DefaultTabController.of(context).index;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TVShowEpisodesBloc, TVShowEpisodesState>(
        bloc: tvShowEpisodesBloc,
        builder: (context, state) {
          return Builder(
            builder: (context) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  _DetailedShowAppBar(imageUrl: widget.viewModel.imageUrl),
                  _DetailedShowTitle(
                    id: widget.viewModel.id,
                    name: widget.viewModel.name,
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          'Seasons',
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: TabBar(
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: state.shows.entries
                              .map(
                                (show) => Tab(
                                  text: '${show.key}',
                                ),
                              )
                              .toList(),
                          labelStyle: context.textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ]
                ],
                body: state is TVShowEpisodesSuccessState
                    ? _DetailedShowEpisodeList(
                        episodes: state.shows[_currentTabIndex + 1]!,
                      )
                    : const SizedBox.shrink(),
              );
            },
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

class _DetailedShowAppBar extends StatelessWidget {
  final String imageUrl;

  const _DetailedShowAppBar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: imageUrl,
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        stretchModes: const [StretchMode.fadeTitle],
        collapseMode: CollapseMode.pin,
        centerTitle: true,
      ),
      centerTitle: true,
    );
  }
}

class _DetailedShowTitle extends StatelessWidget {
  final String name;
  final int id;

  const _DetailedShowTitle({
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverToBoxAdapter(
        child: Center(
          child: Hero(
            tag: name + id.toString(),
            child: Text(
              name,
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _DetailedShowEpisodeList extends StatelessWidget {
  final List<TVShowEpisodeViewModel> episodes;

  const _DetailedShowEpisodeList({required this.episodes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: episodes.length,
      itemBuilder: (context, index) {
        final episode = episodes[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 2,
          ),
          child: InkWell(
            splashFactory: NoSplash.splashFactory,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => DetailedEpisodePage(
                    viewModel: episode,
                  ),
                ),
              );
            },
            child: Card(
              color: AppColors.lightPrimary,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Hero(
                    tag: episode.name,
                    child: Text(
                      episode.name,
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
