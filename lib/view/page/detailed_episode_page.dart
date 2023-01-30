import 'package:flutter/material.dart';
import 'package:jobsity_test/core/extensions.dart';
import 'package:jobsity_test/view/model/tv_show_episode_view_model.dart';

class DetailedEpisodePage extends StatelessWidget {
  final TVShowEpisodeViewModel viewModel;

  const DetailedEpisodePage({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return _DetailedEpisodeView(viewModel);
  }
}

class _DetailedEpisodeView extends StatefulWidget {
  final TVShowEpisodeViewModel viewModel;

  const _DetailedEpisodeView(this.viewModel);

  @override
  State<_DetailedEpisodeView> createState() => _DetailedEpisodeViewState();
}

class _DetailedEpisodeViewState extends State<_DetailedEpisodeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Episode information',
          style: context.textTheme.titleMedium,
        ),
      ),
      body: Column(
        children: [
          Image.network(widget.viewModel.imageUrl),
          const SizedBox(height: 16),
          Text(
            'Season ${widget.viewModel.season}',
            style: context.textTheme.titleMedium,
          ),
          Text(
            '${widget.viewModel.number} - ${widget.viewModel.name}',
            style: context.textTheme.titleMedium,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.viewModel.summary,
              style: context.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
