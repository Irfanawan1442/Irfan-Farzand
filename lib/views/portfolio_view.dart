import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:irfan_portfolio/views/project_section.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'about_view.dart';
import 'contact_section.dart';
import 'experience_section.dart';


class PortfolioView extends StatefulWidget {
  const PortfolioView({Key? key}) : super(key: key);

  @override
  _PortfolioViewState createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  late AnimationController _profileAnimation;
  late Animation<double> _profileScale;
  late Animation<double> _profileOpacity;
  bool _showFab = false;

  final List<String> _roles = [
    'Flutter Developer',
    'Python Developer',
    'Tech Enthusiast',
    'Problem Solver'
  ];

  final Map<String, String> _socialLinks = {
    'LinkedIn': 'https://linkedin.com/in/yourprofile',
    'GitHub': 'https://github.com/yourusername',
    'Email': 'mailto:your.email@domain.com',
    'Facebook': 'https://twitter.com/yourhandle'
  };

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setupScrollListener();
    _profileAnimation.forward();
  }

  void _initializeControllers() {
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
    _profileAnimation = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _profileScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _profileAnimation, curve: Curves.easeOutBack),
    );
    _profileOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _profileAnimation, curve: Curves.easeIn),
    );
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      setState(() {
        _showFab = _scrollController.offset > 100;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _profileAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: _buildScrollToTopButton(),
    );
  }

  Widget _buildBody() {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxScrolled) => [
          _buildSliverAppBar(),
        ],
        body: TabBarView(
          controller: _tabController,
          children: const [
            AboutSection(),
            ProjectsSection(),
            ExperienceSection(),
            SkillsSection(),
          ],
        ),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification scrollNotification) {
    if (scrollNotification is ScrollUpdateNotification) {
      setState(() {
        _showFab = _scrollController.offset > 100;
      });
    }
    return true;
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      stretch: true,
      backgroundColor: Theme.of(context).primaryColor,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: _buildAppBarBackground(),
      ),
      bottom: _buildTabBar(),
    );
  }

  Widget _buildAppBarBackground() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildBackgroundImage(),
        _buildBackgroundOverlay(),
        _buildProfileContent(),
      ],
    );
  }

  Widget _buildBackgroundImage() {
    return Hero(
      tag: 'banner',
      child: CachedNetworkImage(
        imageUrl: 'image/b.jpg',
        fit: BoxFit.cover,
        placeholder: (context, url) => _buildImagePlaceholder(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(color: Colors.white),
    );
  }

  Widget _buildBackgroundOverlay() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.2),
              Colors.black.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent() {
    return Positioned(
      bottom: 100,
      left: 20,
      right: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileImage(),
          const SizedBox(height: 20),
          _buildName(),
          const SizedBox(height: 10),
          _buildRoleAnimation(),
          const SizedBox(height: 15),
          _buildSocialButtons(),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return ScaleTransition(
      scale: _profileScale,
      child: FadeTransition(
        opacity: _profileOpacity,
        child: Hero(
          tag: 'profile',
          child: Material(
            elevation: 12,
            shadowColor: Colors.black45,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(75),
            ),
            child: _buildProfileImageContainer(),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImageContainer() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.transparent,
        child: _buildProfileImageNetwork(),
      ),
    );
  }

  Widget _buildProfileImageNetwork() {
    return CachedNetworkImage(
      imageUrl: 'image/irfan.jpg',
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.person),
    );
  }

  Widget _buildName() {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).colorScheme.secondary,
        ],
      ).createShader(bounds),
      child: const Text(
        'Irfan Farzand',
        style: TextStyle(
          color: Colors.white,
          fontSize: 36,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildRoleAnimation() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: AnimatedTextKit(
        animatedTexts: _roles.map((role) => TypewriterAnimatedText(
          role,
          textStyle: const TextStyle(
            color: Colors.white70,
            fontSize: 20,
            letterSpacing: 1.1,
          ),
          speed: const Duration(milliseconds: 100),
        )).toList(),
        repeatForever: true,
        pause: const Duration(milliseconds: 1000),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _socialLinks.entries.map((entry) => Padding(
          padding: const EdgeInsets.only(right: 8),
          child: _buildSocialButton(
            icon: _getSocialIcon(entry.key),
            label: entry.key,
            url: entry.value,
            startColor: _getSocialStartColor(entry.key),
            endColor: _getSocialEndColor(entry.key),
          ),
        )).toList(),
      ),
    );
  }

  IconData _getSocialIcon(String platform) {
    switch (platform) {
      case 'LinkedIn':
        return Icons.link;
      case 'GitHub':
        return Icons.code;
      case 'Email':
        return Icons.email;
      case 'Facebook':
        return Icons.chat;
      default:
        return Icons.link;
    }
  }

  Color _getSocialStartColor(String platform) {
    switch (platform) {
      case 'LinkedIn':
        return Colors.teal;
      case 'GitHub':
        return Colors.grey.shade800;
      case 'Email':
        return Colors.deepPurple;
      case 'Facebook':
        return Colors.lightBlue;
      default:
        return Colors.blue;
    }
  }

  Color _getSocialEndColor(String platform) {
    switch (platform) {
      case 'LinkedIn':
        return Colors.blue.shade700;
      case 'GitHub':
        return Colors.black;
      case 'Email':
        return Colors.red.shade700;
      case 'Facebook':
        return Colors.blue.shade900;
      default:
        return Colors.blue.shade900;
    }
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String label,
    required String url,
    required Color startColor,
    required Color endColor,
  }) {
    return Tooltip(
      message: label,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: () => _launchURL(url),
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [startColor, endColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  PreferredSizeWidget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      indicatorColor: Theme.of(context).colorScheme.secondary,
      indicatorWeight: 3,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      tabs: const [
        Tab(icon: Icon(Icons.person_outline), text: 'About'),
        Tab(icon: Icon(Icons.code), text: 'Projects'),
        Tab(icon: Icon(Icons.work), text: 'Experience'),
        Tab(icon: Icon(Icons.code_sharp), text: 'SKills'),
      ],
    );
  }

  Widget _buildScrollToTopButton() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _showFab ? 1.0 : 0.0,
      child: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}