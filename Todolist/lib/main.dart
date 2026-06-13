import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const _background = Color(0xFF0B1326);
const _surfaceLowest = Color(0xFF060E20);
const _surface = Color(0xFF171F33);
const _surfaceHigh = Color(0xFF222A3D);
const _surfaceHighest = Color(0xFF2D3449);
const _primary = Color(0xFF4EDEA3);
const _secondary = Color(0xFFD0BCFF);
const _tertiary = Color(0xFFFFB95F);
const _error = Color(0xFFFFB4AB);
const _onSurface = Color(0xFFDAE2FD);
const _onSurfaceVariant = Color(0xFFBBCABF);
const _outlineVariant = Color(0xFF3C4A42);

enum AppSection { quests, character, shop }

enum QuestFilter { all, active, completed, failed }

enum QuestStatus { active, completed, failed }

enum QuestDifficulty { easy, medium, hard }

extension QuestDifficultyRules on QuestDifficulty {
  String get label {
    return switch (this) {
      QuestDifficulty.easy => 'Easy',
      QuestDifficulty.medium => 'Medium',
      QuestDifficulty.hard => 'Hard',
    };
  }

  IconData get icon {
    return switch (this) {
      QuestDifficulty.easy => Icons.sentiment_satisfied_alt,
      QuestDifficulty.medium => Icons.sports_mma,
      QuestDifficulty.hard => Icons.local_fire_department,
    };
  }

  Color get color {
    return switch (this) {
      QuestDifficulty.easy => _primary,
      QuestDifficulty.medium => _tertiary,
      QuestDifficulty.hard => _error,
    };
  }

  int get expReward {
    return switch (this) {
      QuestDifficulty.easy => 10,
      QuestDifficulty.medium => 20,
      QuestDifficulty.hard => 40,
    };
  }

  int get baseGoldReward {
    return switch (this) {
      QuestDifficulty.easy => 6,
      QuestDifficulty.medium => 12,
      QuestDifficulty.hard => 24,
    };
  }

  int get expPenalty {
    return switch (this) {
      QuestDifficulty.easy => 5,
      QuestDifficulty.medium => 10,
      QuestDifficulty.hard => 20,
    };
  }

  int get hpDamage {
    return switch (this) {
      QuestDifficulty.easy => 1,
      QuestDifficulty.medium => 2,
      QuestDifficulty.hard => 4,
    };
  }
}

class QuestItem {
  QuestItem({
    required this.id,
    required this.title,
    required this.tag,
    required this.difficulty,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    this.status = QuestStatus.active,
  });

  final int id;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;
  final QuestDifficulty difficulty;
  final String tag;
  String title;
  QuestStatus status;

  bool get isActive => status == QuestStatus.active;
  bool get isCompleted => status == QuestStatus.completed;
  bool get isFailed => status == QuestStatus.failed;
}

class AvatarOption {
  const AvatarOption({
    required this.name,
    required this.icon,
    required this.primary,
    required this.secondary,
  });

  final String name;
  final IconData icon;
  final Color primary;
  final Color secondary;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RPG Quest Log',
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        scaffoldBackgroundColor: _background,
        colorScheme:
            ColorScheme.fromSeed(
              seedColor: _primary,
              brightness: Brightness.dark,
            ).copyWith(
              primary: _primary,
              secondary: _secondary,
              tertiary: _tertiary,
              error: _error,
              surface: _surface,
              onSurface: _onSurface,
            ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: _background,
          foregroundColor: _onSurface,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(fontWeight: FontWeight.w800),
          titleLarge: TextStyle(fontWeight: FontWeight.w800),
          titleMedium: TextStyle(fontWeight: FontWeight.w700),
          labelMedium: TextStyle(fontWeight: FontWeight.w700),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            foregroundColor: const Color(0xFF002113),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _surfaceHigh,
          labelStyle: const TextStyle(color: _onSurfaceVariant),
          hintStyle: TextStyle(
            color: _onSurfaceVariant.withValues(alpha: 0.55),
          ),
          prefixIconColor: _onSurfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: _outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: _outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: _primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: _error),
          ),
        ),
      ),
      home: const RpgTodoHomePage(),
    );
  }
}

class RpgTodoHomePage extends StatefulWidget {
  const RpgTodoHomePage({super.key});

  @override
  State<RpgTodoHomePage> createState() => _RpgTodoHomePageState();
}

class _RpgTodoHomePageState extends State<RpgTodoHomePage> {
  static const int _initialHp = 10;
  static const int _hpPerLevel = 5;
  static const int _potionHeal = 5;
  static const int _potionPrice = 10;

  final _formKey = GlobalKey<FormState>();
  final _questController = TextEditingController();
  final _profileNameController = TextEditingController(text: 'Todo Knight');
  late final TextEditingController _startDateController;
  late final TextEditingController _endDateController;

  final List<QuestItem> _quests = [];
  final List<String> _tags = const ['Study', 'Health', 'Work', 'Personal'];
  final List<AvatarOption> _avatars = const [
    AvatarOption(
      name: 'Knight',
      icon: Icons.shield,
      primary: _primary,
      secondary: _secondary,
    ),
    AvatarOption(
      name: 'Mage',
      icon: Icons.auto_fix_high,
      primary: _secondary,
      secondary: _primary,
    ),
    AvatarOption(
      name: 'Ranger',
      icon: Icons.explore,
      primary: _tertiary,
      secondary: _primary,
    ),
    AvatarOption(
      name: 'Paladin',
      icon: Icons.workspace_premium,
      primary: Color(0xFFFFE08A),
      secondary: _secondary,
    ),
  ];

  AppSection _section = AppSection.quests;
  QuestFilter _filter = QuestFilter.all;
  QuestDifficulty _selectedDifficulty = QuestDifficulty.medium;
  String _selectedTag = 'Study';
  int _selectedAvatarIndex = 0;
  int _nextQuestId = 1;
  int _level = 1;
  int _baseHp = _initialHp;
  int _hp = _initialHp;
  int _exp = 0;
  int _gold = 0;
  String _heroName = 'Todo Knight';
  String _battleLog = 'Create a quest, beat the deadline, and grow stronger.';

  @override
  void initState() {
    super.initState();
    final now = _now();
    _startDateController = TextEditingController(text: _formatDateTime(now));
    _endDateController = TextEditingController(
      text: _formatDateTime(now.add(const Duration(minutes: 30))),
    );
  }

  @override
  void dispose() {
    _questController.dispose();
    _profileNameController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  int get _expToNextLevel => 100 + ((_level - 1) * 50);

  int get _activeCount => _quests.where((quest) => quest.isActive).length;

  int get _completedCount => _quests.where((quest) => quest.isCompleted).length;

  int get _failedCount => _quests.where((quest) => quest.isFailed).length;

  AvatarOption get _avatar => _avatars[_selectedAvatarIndex];

  List<QuestItem> get _visibleQuests {
    final filtered = _quests.where((quest) {
      return switch (_filter) {
        QuestFilter.all => true,
        QuestFilter.active => quest.isActive,
        QuestFilter.completed => quest.isCompleted,
        QuestFilter.failed => quest.isFailed,
      };
    }).toList();

    filtered.sort((a, b) {
      final statusSort = a.status.index.compareTo(b.status.index);
      if (statusSort != 0) {
        return statusSort;
      }
      return a.endDate.compareTo(b.endDate);
    });

    return filtered;
  }

  void _submitQuest() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final title = _questController.text.trim();
    final startDate = _parseDateTime(_startDateController.text)!;
    final endDate = _parseDateTime(_endDateController.text)!;

    setState(() {
      _quests.add(
        QuestItem(
          id: _nextQuestId++,
          title: title,
          tag: _selectedTag,
          difficulty: _selectedDifficulty,
          startDate: startDate,
          endDate: endDate,
          createdAt: DateTime.now(),
        ),
      );
      _questController.clear();
      final exp = _selectedDifficulty.expReward;
      final gold = _goldReward(_selectedDifficulty);
      _battleLog = 'Quest accepted. Reward: +$exp EXP, +$gold Gold.';
      _battleLog =
          _applyOverduePenalties(announceWhenClean: false) ?? _battleLog;
    });
  }

  void _completeQuest(QuestItem quest) {
    if (!quest.isActive) {
      return;
    }

    setState(() {
      if (_now().isAfter(quest.endDate)) {
        _battleLog = _failQuest(quest);
        return;
      }

      quest.status = QuestStatus.completed;
      final exp = quest.difficulty.expReward;
      final gold = _goldReward(quest.difficulty);
      _gold += gold;
      final levelMessage = _gainExp(exp);
      _battleLog = 'Quest cleared! +$exp EXP, +$gold Gold. $levelMessage';
    });
  }

  void _deleteQuest(QuestItem quest) {
    setState(() {
      _quests.removeWhere((item) => item.id == quest.id);
      _battleLog = 'Quest removed from the log.';
    });
  }

  void _checkDeadlines() {
    setState(() {
      _battleLog = _applyOverduePenalties() ?? 'No overdue quests.';
    });
  }

  void _changeFilter(QuestFilter filter) {
    setState(() {
      _filter = filter;
    });
  }

  void _changeSection(AppSection section) {
    setState(() {
      _section = section;
    });
  }

  void _setDifficulty(QuestDifficulty difficulty) {
    setState(() {
      _selectedDifficulty = difficulty;
    });
  }

  void _setTag(String tag) {
    setState(() {
      _selectedTag = tag;
    });
  }

  void _saveProfile() {
    final name = _profileNameController.text.trim();
    setState(() {
      _heroName = name.isEmpty ? 'Todo Knight' : name;
      _battleLog = 'Profile saved. Welcome, $_heroName.';
    });
  }

  void _selectAvatar(int index) {
    setState(() {
      _selectedAvatarIndex = index;
      _battleLog = '${_avatars[index].name} avatar equipped.';
    });
  }

  void _buyPotion() {
    setState(() {
      if (_gold < _potionPrice) {
        _battleLog = 'Not enough Gold for a Healing Potion.';
        return;
      }

      if (_hp >= _baseHp) {
        _battleLog = 'HP is already full. Save your Gold.';
        return;
      }

      final before = _hp;
      _gold -= _potionPrice;
      _hp = (_hp + _potionHeal).clamp(0, _baseHp);
      final restored = _hp - before;
      _battleLog = 'Potion used. Restored $restored HP.';
    });
  }

  int _goldReward(QuestDifficulty difficulty) {
    return difficulty.baseGoldReward + ((_level - 1) * 2);
  }

  String _gainExp(int amount) {
    _exp += amount;
    var levelsGained = 0;

    while (_exp >= _expToNextLevel) {
      _exp -= _expToNextLevel;
      _level++;
      _baseHp += _hpPerLevel;
      _hp = _baseHp;
      levelsGained++;
    }

    if (levelsGained == 0) {
      return 'EXP gained.';
    }

    return 'Level up to LV $_level. Base HP is now $_baseHp.';
  }

  void _loseExp(int amount) {
    _exp = (_exp - amount).clamp(0, _expToNextLevel);
  }

  bool _takeDamage(int damage) {
    _hp -= damage;
    if (_hp > 0) {
      return false;
    }

    _level = 1;
    _baseHp = _initialHp;
    _hp = _initialHp;
    _exp = 0;
    return true;
  }

  String _failQuest(QuestItem quest) {
    quest.status = QuestStatus.failed;
    final damage = quest.difficulty.hpDamage;
    final expLoss = quest.difficulty.expPenalty;
    _loseExp(expLoss);
    final reset = _takeDamage(damage);

    if (reset) {
      return 'Deadline missed. -$expLoss EXP, -$damage HP. Hero fainted and returned to LV 1.';
    }

    return 'Deadline missed. -$expLoss EXP, -$damage HP.';
  }

  String? _applyOverduePenalties({bool announceWhenClean = true}) {
    final now = _now();
    final overdueQuests = _quests.where((quest) {
      return quest.isActive && now.isAfter(quest.endDate);
    }).toList();

    if (overdueQuests.isEmpty) {
      return announceWhenClean ? 'No overdue quests.' : null;
    }

    var totalDamage = 0;
    var totalExpLoss = 0;
    for (final quest in overdueQuests) {
      quest.status = QuestStatus.failed;
      totalDamage += quest.difficulty.hpDamage;
      totalExpLoss += quest.difficulty.expPenalty;
    }

    _loseExp(totalExpLoss);
    final reset = _takeDamage(totalDamage);
    final questWord = overdueQuests.length == 1 ? 'quest' : 'quests';

    if (reset) {
      return '${overdueQuests.length} overdue $questWord failed. -$totalExpLoss EXP, -$totalDamage HP. Hero fainted and returned to LV 1.';
    }

    return '${overdueQuests.length} overdue $questWord failed. -$totalExpLoss EXP, -$totalDamage HP.';
  }

  DateTime _now() {
    return DateTime.now();
  }

  DateTime? _parseDateTime(String value) {
    final trimmed = value.trim();
    final match = RegExp(
      r'^(\d{4})-(\d{2})-(\d{2})[ T](\d{2}):(\d{2})$',
    ).firstMatch(trimmed);
    if (match == null) {
      return null;
    }

    final year = int.parse(match.group(1)!);
    final month = int.parse(match.group(2)!);
    final day = int.parse(match.group(3)!);
    final hour = int.parse(match.group(4)!);
    final minute = int.parse(match.group(5)!);
    if (hour > 23 || minute > 59) {
      return null;
    }

    final parsed = DateTime(year, month, day, hour, minute);

    if (parsed.year != year ||
        parsed.month != month ||
        parsed.day != day ||
        parsed.hour != hour ||
        parsed.minute != minute) {
      return null;
    }

    return parsed;
  }

  String _formatDateTime(DateTime value) {
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '${value.year}-$month-$day $hour:$minute';
  }

  String? _validateQuestTitle(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter a quest name';
    }
    return null;
  }

  String? _validateStartDate(String? value) {
    if (value == null || _parseDateTime(value) == null) {
      return 'Use YYYY-MM-DD HH:mm';
    }
    return null;
  }

  String? _validateEndDate(String? value) {
    final endDate = value == null ? null : _parseDateTime(value);
    if (endDate == null) {
      return 'Use YYYY-MM-DD HH:mm';
    }

    final startDate = _parseDateTime(_startDateController.text);
    if (startDate != null && endDate.isBefore(startDate)) {
      return 'Deadline must be after begin time';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _TopBar(
        heroName: _heroName,
        avatar: _avatar,
        level: _level,
        onCheckDeadlines: _checkDeadlines,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final page = _buildPage();
          if (constraints.maxWidth >= 900) {
            return Row(
              children: [
                _SideNav(current: _section, onChange: _changeSection),
                Expanded(child: page),
              ],
            );
          }

          return page;
        },
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 900) {
            return const SizedBox.shrink();
          }

          return _BottomNav(current: _section, onChange: _changeSection);
        },
      ),
    );
  }

  Widget _buildPage() {
    return switch (_section) {
      AppSection.quests => _QuestsPage(
        heroName: _heroName,
        avatar: _avatar,
        level: _level,
        hp: _hp,
        baseHp: _baseHp,
        exp: _exp,
        expToNextLevel: _expToNextLevel,
        gold: _gold,
        activeCount: _activeCount,
        completedCount: _completedCount,
        failedCount: _failedCount,
        battleLog: _battleLog,
        formKey: _formKey,
        questController: _questController,
        startDateController: _startDateController,
        endDateController: _endDateController,
        selectedTag: _selectedTag,
        selectedDifficulty: _selectedDifficulty,
        tags: _tags,
        visibleQuests: _visibleQuests,
        hasAnyQuests: _quests.isNotEmpty,
        filter: _filter,
        now: _now(),
        onSubmitQuest: _submitQuest,
        onSetTag: _setTag,
        onSetDifficulty: _setDifficulty,
        onChangeFilter: _changeFilter,
        onCompleteQuest: _completeQuest,
        onDeleteQuest: _deleteQuest,
        validateTitle: _validateQuestTitle,
        validateStartDate: _validateStartDate,
        validateEndDate: _validateEndDate,
        goldReward: _goldReward,
        formatDateTime: _formatDateTime,
      ),
      AppSection.character => _CharacterPage(
        heroName: _heroName,
        avatar: _avatar,
        avatars: _avatars,
        selectedAvatarIndex: _selectedAvatarIndex,
        level: _level,
        hp: _hp,
        baseHp: _baseHp,
        exp: _exp,
        expToNextLevel: _expToNextLevel,
        gold: _gold,
        profileNameController: _profileNameController,
        battleLog: _battleLog,
        onSaveProfile: _saveProfile,
        onSelectAvatar: _selectAvatar,
      ),
      AppSection.shop => _ShopPage(
        hp: _hp,
        baseHp: _baseHp,
        gold: _gold,
        potionHeal: _potionHeal,
        potionPrice: _potionPrice,
        battleLog: _battleLog,
        onBuyPotion: _buyPotion,
      ),
    };
  }
}

class _TopBar extends StatelessWidget implements PreferredSizeWidget {
  const _TopBar({
    required this.heroName,
    required this.avatar,
    required this.level,
    required this.onCheckDeadlines,
  });

  final String heroName;
  final AvatarOption avatar;
  final int level;
  final VoidCallback onCheckDeadlines;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 16,
      title: Row(
        children: [
          _AvatarBadge(
            avatar: avatar,
            size: 42,
            level: level,
            showLevel: false,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'RPG Quest Log',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  heroName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _onSurfaceVariant,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          key: const Key('check-deadlines'),
          tooltip: 'Check deadlines',
          onPressed: onCheckDeadlines,
          icon: const Icon(Icons.hourglass_empty),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: _outlineVariant),
      ),
    );
  }
}

class _QuestsPage extends StatelessWidget {
  const _QuestsPage({
    required this.heroName,
    required this.avatar,
    required this.level,
    required this.hp,
    required this.baseHp,
    required this.exp,
    required this.expToNextLevel,
    required this.gold,
    required this.activeCount,
    required this.completedCount,
    required this.failedCount,
    required this.battleLog,
    required this.formKey,
    required this.questController,
    required this.startDateController,
    required this.endDateController,
    required this.selectedTag,
    required this.selectedDifficulty,
    required this.tags,
    required this.visibleQuests,
    required this.hasAnyQuests,
    required this.filter,
    required this.now,
    required this.onSubmitQuest,
    required this.onSetTag,
    required this.onSetDifficulty,
    required this.onChangeFilter,
    required this.onCompleteQuest,
    required this.onDeleteQuest,
    required this.validateTitle,
    required this.validateStartDate,
    required this.validateEndDate,
    required this.goldReward,
    required this.formatDateTime,
  });

  final String heroName;
  final AvatarOption avatar;
  final int level;
  final int hp;
  final int baseHp;
  final int exp;
  final int expToNextLevel;
  final int gold;
  final int activeCount;
  final int completedCount;
  final int failedCount;
  final String battleLog;
  final GlobalKey<FormState> formKey;
  final TextEditingController questController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final String selectedTag;
  final QuestDifficulty selectedDifficulty;
  final List<String> tags;
  final List<QuestItem> visibleQuests;
  final bool hasAnyQuests;
  final QuestFilter filter;
  final DateTime now;
  final VoidCallback onSubmitQuest;
  final ValueChanged<String> onSetTag;
  final ValueChanged<QuestDifficulty> onSetDifficulty;
  final ValueChanged<QuestFilter> onChangeFilter;
  final ValueChanged<QuestItem> onCompleteQuest;
  final ValueChanged<QuestItem> onDeleteQuest;
  final FormFieldValidator<String> validateTitle;
  final FormFieldValidator<String> validateStartDate;
  final FormFieldValidator<String> validateEndDate;
  final int Function(QuestDifficulty difficulty) goldReward;
  final String Function(DateTime value) formatDateTime;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _HeroPanel(
                heroName: heroName,
                avatar: avatar,
                level: level,
                hp: hp,
                baseHp: baseHp,
                exp: exp,
                expToNextLevel: expToNextLevel,
                gold: gold,
                activeCount: activeCount,
                completedCount: completedCount,
                failedCount: failedCount,
                battleLog: battleLog,
              ),
              const SizedBox(height: 16),
              _QuestForm(
                formKey: formKey,
                questController: questController,
                startDateController: startDateController,
                endDateController: endDateController,
                selectedTag: selectedTag,
                selectedDifficulty: selectedDifficulty,
                tags: tags,
                onSubmit: onSubmitQuest,
                onSetTag: onSetTag,
                onSetDifficulty: onSetDifficulty,
                validateTitle: validateTitle,
                validateStartDate: validateStartDate,
                validateEndDate: validateEndDate,
                goldReward: goldReward,
              ),
              const SizedBox(height: 14),
              _FilterBar(filter: filter, onChange: onChangeFilter),
              const SizedBox(height: 14),
              if (visibleQuests.isEmpty)
                _EmptyState(hasQuests: hasAnyQuests)
              else
                for (final quest in visibleQuests)
                  _QuestTile(
                    quest: quest,
                    now: now,
                    goldReward: goldReward(quest.difficulty),
                    onComplete: () => onCompleteQuest(quest),
                    onDelete: () => onDeleteQuest(quest),
                    formatDateTime: formatDateTime,
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroPanel extends StatelessWidget {
  const _HeroPanel({
    required this.heroName,
    required this.avatar,
    required this.level,
    required this.hp,
    required this.baseHp,
    required this.exp,
    required this.expToNextLevel,
    required this.gold,
    required this.activeCount,
    required this.completedCount,
    required this.failedCount,
    required this.battleLog,
  });

  final String heroName;
  final AvatarOption avatar;
  final int level;
  final int hp;
  final int baseHp;
  final int exp;
  final int expToNextLevel;
  final int gold;
  final int activeCount;
  final int completedCount;
  final int failedCount;
  final String battleLog;

  @override
  Widget build(BuildContext context) {
    final hpRatio = baseHp == 0 ? 0.0 : hp / baseHp;
    final expRatio = expToNextLevel == 0 ? 0.0 : exp / expToNextLevel;

    return _GlassPanel(
      glowColor: _primary,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 640;
          final avatarWidget = _AvatarBadge(
            avatar: avatar,
            size: compact ? 72 : 84,
            level: level,
            showLevel: true,
          );
          final info = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      heroName,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: _onSurface,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                  _GoldBadge(gold: gold),
                ],
              ),
              const SizedBox(height: 10),
              _MeterBar(
                label: 'HP $hp / $baseHp',
                value: hpRatio.clamp(0.0, 1.0),
                icon: Icons.favorite,
                color: _primary,
              ),
              const SizedBox(height: 10),
              _MeterBar(
                label: 'EXP $exp / $expToNextLevel',
                value: expRatio.clamp(0.0, 1.0),
                icon: Icons.star,
                color: _secondary,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _MiniStat(label: 'Active', value: activeCount),
                  _MiniStat(label: 'Cleared', value: completedCount),
                  _MiniStat(label: 'Failed', value: failedCount),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                battleLog,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );

          if (compact) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    avatarWidget,
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Cyber Fantasy Quest Board',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                info,
              ],
            );
          }

          return Row(
            children: [
              avatarWidget,
              const SizedBox(width: 18),
              Expanded(child: info),
            ],
          );
        },
      ),
    );
  }
}

class _QuestForm extends StatelessWidget {
  const _QuestForm({
    required this.formKey,
    required this.questController,
    required this.startDateController,
    required this.endDateController,
    required this.selectedTag,
    required this.selectedDifficulty,
    required this.tags,
    required this.onSubmit,
    required this.onSetTag,
    required this.onSetDifficulty,
    required this.validateTitle,
    required this.validateStartDate,
    required this.validateEndDate,
    required this.goldReward,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController questController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final String selectedTag;
  final QuestDifficulty selectedDifficulty;
  final List<String> tags;
  final VoidCallback onSubmit;
  final ValueChanged<String> onSetTag;
  final ValueChanged<QuestDifficulty> onSetDifficulty;
  final FormFieldValidator<String> validateTitle;
  final FormFieldValidator<String> validateStartDate;
  final FormFieldValidator<String> validateEndDate;
  final int Function(QuestDifficulty difficulty) goldReward;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      glowColor: _secondary,
      padding: const EdgeInsets.all(14),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                const Icon(Icons.add_task, color: _primary),
                const SizedBox(width: 8),
                Text(
                  'Create quest',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: _onSurface,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const Key('quest-input'),
              controller: questController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Quest name',
                hintText: 'Draft a new quest...',
                prefixIcon: Icon(Icons.edit_note),
              ),
              validator: validateTitle,
              onFieldSubmitted: (_) => onSubmit(),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final start = _DateField(
                  keyValue: 'start-date-input',
                  controller: startDateController,
                  label: 'Begin',
                  validator: validateStartDate,
                );
                final deadline = _DateField(
                  keyValue: 'end-date-input',
                  controller: endDateController,
                  label: 'Deadline',
                  validator: validateEndDate,
                );

                if (constraints.maxWidth < 520) {
                  return Column(
                    children: [start, const SizedBox(height: 10), deadline],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: start),
                    const SizedBox(width: 10),
                    Expanded(child: deadline),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            _SectionLabel(icon: Icons.sell, label: 'Tag'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final tag in tags)
                  _ChoicePill(
                    key: Key('tag-$tag'),
                    label: tag,
                    icon: _tagIcon(tag),
                    selected: selectedTag == tag,
                    color: _secondary,
                    onTap: () => onSetTag(tag),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            _SectionLabel(icon: Icons.sports_mma, label: 'Difficulty'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final difficulty in QuestDifficulty.values)
                  _ChoicePill(
                    key: Key('difficulty-${difficulty.name}'),
                    label:
                        '${difficulty.label}  +${difficulty.expReward} EXP  +${goldReward(difficulty)} Gold',
                    icon: difficulty.icon,
                    selected: selectedDifficulty == difficulty,
                    color: difficulty.color,
                    onTap: () => onSetDifficulty(difficulty),
                  ),
              ],
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              key: const Key('submit-quest'),
              onPressed: onSubmit,
              icon: const Icon(Icons.add),
              label: const Text('Add Quest'),
            ),
          ],
        ),
      ),
    );
  }

  IconData _tagIcon(String tag) {
    return switch (tag) {
      'Study' => Icons.school,
      'Health' => Icons.favorite,
      'Work' => Icons.business_center,
      _ => Icons.auto_awesome,
    };
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.keyValue,
    required this.controller,
    required this.label,
    required this.validator,
  });

  final String keyValue;
  final TextEditingController controller;
  final String label;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: Key(keyValue),
      controller: controller,
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        labelText: label,
        hintText: 'YYYY-MM-DD HH:mm',
        prefixIcon: const Icon(Icons.event),
      ),
      validator: validator,
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.filter, required this.onChange});

  final QuestFilter filter;
  final ValueChanged<QuestFilter> onChange;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterButton(
            label: 'All',
            icon: Icons.list,
            selected: filter == QuestFilter.all,
            onTap: () => onChange(QuestFilter.all),
          ),
          _FilterButton(
            label: 'Active',
            icon: Icons.bolt,
            selected: filter == QuestFilter.active,
            onTap: () => onChange(QuestFilter.active),
          ),
          _FilterButton(
            label: 'Done',
            icon: Icons.emoji_events,
            selected: filter == QuestFilter.completed,
            onTap: () => onChange(QuestFilter.completed),
          ),
          _FilterButton(
            label: 'Failed',
            icon: Icons.heart_broken,
            selected: filter == QuestFilter.failed,
            onTap: () => onChange(QuestFilter.failed),
          ),
        ],
      ),
    );
  }
}

class _FilterButton extends StatelessWidget {
  const _FilterButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: selected ? _primary : _onSurfaceVariant,
          backgroundColor: selected
              ? _primary.withValues(alpha: 0.16)
              : _surfaceHigh,
          side: BorderSide(color: selected ? _primary : _outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}

class _QuestTile extends StatelessWidget {
  const _QuestTile({
    required this.quest,
    required this.now,
    required this.goldReward,
    required this.onComplete,
    required this.onDelete,
    required this.formatDateTime,
  });

  final QuestItem quest;
  final DateTime now;
  final int goldReward;
  final VoidCallback onComplete;
  final VoidCallback onDelete;
  final String Function(DateTime value) formatDateTime;

  bool get _isOverdue => quest.isActive && now.isAfter(quest.endDate);

  @override
  Widget build(BuildContext context) {
    final accent = _accentColor;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: _surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.42)),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: quest.isCompleted ? 0.22 : 0.08),
            blurRadius: quest.isCompleted ? 22 : 14,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              tooltip: quest.isActive ? 'Complete quest' : 'Quest resolved',
              onPressed: quest.isActive ? onComplete : null,
              style: IconButton.styleFrom(
                side: BorderSide(color: accent.withValues(alpha: 0.65)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(_leadingIcon, color: accent),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quest.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: quest.isFailed ? _error : _onSurface,
                      decoration: quest.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 7,
                    runSpacing: 7,
                    children: [
                      _InfoChip(
                        icon: Icons.sell,
                        label: quest.tag,
                        color: _secondary,
                      ),
                      _InfoChip(
                        icon: quest.difficulty.icon,
                        label: quest.difficulty.label,
                        color: quest.difficulty.color,
                      ),
                      _InfoChip(
                        icon: Icons.star,
                        label: '+${quest.difficulty.expReward} EXP',
                        color: _secondary,
                      ),
                      _InfoChip(
                        icon: Icons.toll,
                        label: '+$goldReward Gold',
                        color: _tertiary,
                      ),
                      _InfoChip(
                        icon: Icons.warning_amber,
                        label:
                            '-${quest.difficulty.expPenalty} EXP / -${quest.difficulty.hpDamage} HP',
                        color: _error,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${formatDateTime(quest.startDate)} -> ${formatDateTime(quest.endDate)}',
                    style: const TextStyle(
                      color: _onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Delete quest',
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline, color: _error),
            ),
          ],
        ),
      ),
    );
  }

  Color get _accentColor {
    if (_isOverdue || quest.isFailed) {
      return _error;
    }
    if (quest.isCompleted) {
      return _primary;
    }
    return quest.difficulty.color;
  }

  IconData get _leadingIcon {
    if (_isOverdue) {
      return Icons.warning_amber;
    }
    if (quest.isCompleted) {
      return Icons.check;
    }
    if (quest.isFailed) {
      return Icons.heart_broken;
    }
    return Icons.shield;
  }
}

class _CharacterPage extends StatelessWidget {
  const _CharacterPage({
    required this.heroName,
    required this.avatar,
    required this.avatars,
    required this.selectedAvatarIndex,
    required this.level,
    required this.hp,
    required this.baseHp,
    required this.exp,
    required this.expToNextLevel,
    required this.gold,
    required this.profileNameController,
    required this.battleLog,
    required this.onSaveProfile,
    required this.onSelectAvatar,
  });

  final String heroName;
  final AvatarOption avatar;
  final List<AvatarOption> avatars;
  final int selectedAvatarIndex;
  final int level;
  final int hp;
  final int baseHp;
  final int exp;
  final int expToNextLevel;
  final int gold;
  final TextEditingController profileNameController;
  final String battleLog;
  final VoidCallback onSaveProfile;
  final ValueChanged<int> onSelectAvatar;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        _GlassPanel(
          glowColor: _secondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  _AvatarBadge(
                    avatar: avatar,
                    size: 96,
                    level: level,
                    showLevel: true,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          heroName,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: _onSurface,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        const SizedBox(height: 6),
                        _GoldBadge(gold: gold),
                        const SizedBox(height: 8),
                        Text(
                          battleLog,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: _onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              _MeterBar(
                label: 'HP $hp / $baseHp',
                value: baseHp == 0 ? 0 : (hp / baseHp).clamp(0.0, 1.0),
                icon: Icons.favorite,
                color: _primary,
              ),
              const SizedBox(height: 10),
              _MeterBar(
                label: 'EXP $exp / $expToNextLevel',
                value: expToNextLevel == 0
                    ? 0
                    : (exp / expToNextLevel).clamp(0.0, 1.0),
                icon: Icons.star,
                color: _secondary,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _GlassPanel(
          glowColor: _primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SectionLabel(icon: Icons.person, label: 'Profile'),
              const SizedBox(height: 12),
              TextFormField(
                key: const Key('profile-name-input'),
                controller: profileNameController,
                decoration: const InputDecoration(
                  labelText: 'Character name',
                  hintText: 'Set your hero name',
                  prefixIcon: Icon(Icons.badge),
                ),
              ),
              const SizedBox(height: 14),
              _SectionLabel(icon: Icons.image, label: 'Avatar image'),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (var index = 0; index < avatars.length; index++)
                    _AvatarChoice(
                      key: Key('avatar-${avatars[index].name}'),
                      avatar: avatars[index],
                      selected: selectedAvatarIndex == index,
                      onTap: () => onSelectAvatar(index),
                    ),
                ],
              ),
              const SizedBox(height: 14),
              ElevatedButton.icon(
                key: const Key('save-profile'),
                onPressed: onSaveProfile,
                icon: const Icon(Icons.save),
                label: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShopPage extends StatelessWidget {
  const _ShopPage({
    required this.hp,
    required this.baseHp,
    required this.gold,
    required this.potionHeal,
    required this.potionPrice,
    required this.battleLog,
    required this.onBuyPotion,
  });

  final int hp;
  final int baseHp;
  final int gold;
  final int potionHeal;
  final int potionPrice;
  final String battleLog;
  final VoidCallback onBuyPotion;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
      children: [
        _GlassPanel(
          glowColor: _tertiary,
          child: Row(
            children: [
              const Icon(Icons.shopping_bag, color: _tertiary, size: 40),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Guild Shop',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: _onSurface,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      battleLog,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: _onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              _GoldBadge(gold: gold),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _ShopItemCard(
          title: 'Healing Potion',
          description: 'Restore up to $potionHeal HP once.',
          price: potionPrice,
          statLine: 'Current HP $hp / $baseHp',
          icon: Icons.local_drink,
          onBuy: onBuyPotion,
        ),
      ],
    );
  }
}

class _ShopItemCard extends StatelessWidget {
  const _ShopItemCard({
    required this.title,
    required this.description,
    required this.price,
    required this.statLine,
    required this.icon,
    required this.onBuy,
  });

  final String title;
  final String description;
  final int price;
  final String statLine;
  final IconData icon;
  final VoidCallback onBuy;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      glowColor: _tertiary,
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: _tertiary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _tertiary.withValues(alpha: 0.35)),
            ),
            child: Icon(icon, color: _tertiary, size: 34),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(color: _onSurfaceVariant),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoChip(
                      icon: Icons.favorite,
                      label: statLine,
                      color: _primary,
                    ),
                    _InfoChip(
                      icon: Icons.toll,
                      label: '$price Gold',
                      color: _tertiary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton.icon(
            key: const Key('buy-heal-potion'),
            onPressed: onBuy,
            icon: const Icon(Icons.add),
            label: const Text('Buy'),
          ),
        ],
      ),
    );
  }
}

class _SideNav extends StatelessWidget {
  const _SideNav({required this.current, required this.onChange});

  final AppSection current;
  final ValueChanged<AppSection> onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      decoration: BoxDecoration(
        color: _surface.withValues(alpha: 0.82),
        border: const Border(right: BorderSide(color: _outlineVariant)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'MENU',
                style: TextStyle(
                  color: _onSurfaceVariant,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 12),
              _NavItem(
                key: const Key('nav-quests'),
                section: AppSection.quests,
                current: current,
                icon: Icons.sports_mma,
                label: 'Quests',
                onTap: onChange,
              ),
              _NavItem(
                key: const Key('nav-character'),
                section: AppSection.character,
                current: current,
                icon: Icons.person,
                label: 'Character',
                onTap: onChange,
              ),
              _NavItem(
                key: const Key('nav-shop'),
                section: AppSection.shop,
                current: current,
                icon: Icons.shopping_bag,
                label: 'Shop',
                onTap: onChange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.current, required this.onChange});

  final AppSection current;
  final ValueChanged<AppSection> onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _surface.withValues(alpha: 0.96),
        border: const Border(top: BorderSide(color: _outlineVariant)),
        boxShadow: [
          BoxShadow(
            color: _primary.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: _NavItem(
                  key: const Key('nav-quests'),
                  section: AppSection.quests,
                  current: current,
                  icon: Icons.sports_mma,
                  label: 'Quests',
                  onTap: onChange,
                  compact: true,
                ),
              ),
              Expanded(
                child: _NavItem(
                  key: const Key('nav-character'),
                  section: AppSection.character,
                  current: current,
                  icon: Icons.person,
                  label: 'Character',
                  onTap: onChange,
                  compact: true,
                ),
              ),
              Expanded(
                child: _NavItem(
                  key: const Key('nav-shop'),
                  section: AppSection.shop,
                  current: current,
                  icon: Icons.shopping_bag,
                  label: 'Shop',
                  onTap: onChange,
                  compact: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    super.key,
    required this.section,
    required this.current,
    required this.icon,
    required this.label,
    required this.onTap,
    this.compact = false,
  });

  final AppSection section;
  final AppSection current;
  final IconData icon;
  final String label;
  final ValueChanged<AppSection> onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final selected = current == section;
    final content = compact
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 22),
              const SizedBox(height: 3),
              Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 11),
              ),
            ],
          )
        : Row(
            children: [
              Icon(icon),
              const SizedBox(width: 12),
              Expanded(child: Text(label)),
            ],
          );

    return Padding(
      padding: EdgeInsets.only(bottom: compact ? 0 : 8, right: compact ? 6 : 0),
      child: InkWell(
        onTap: () => onTap(section),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: compact
              ? const EdgeInsets.symmetric(vertical: 8, horizontal: 8)
              : const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          decoration: BoxDecoration(
            color: selected
                ? _primary.withValues(alpha: 0.16)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? _primary.withValues(alpha: 0.42)
                  : Colors.transparent,
            ),
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              color: selected ? _primary : _onSurfaceVariant,
              fontWeight: FontWeight.w800,
            ),
            child: IconTheme(
              data: IconThemeData(
                color: selected ? _primary : _onSurfaceVariant,
              ),
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({
    required this.child,
    required this.glowColor,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final Color glowColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _surface.withValues(alpha: 0.74),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
        boxShadow: [
          BoxShadow(
            color: glowColor.withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _GridPainter(
                color: Colors.white.withValues(alpha: 0.035),
              ),
            ),
          ),
          Padding(padding: padding, child: child),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    const step = 16.0;
    for (var x = 0.0; x < size.width; x += step) {
      for (var y = 0.0; y < size.height; y += step) {
        canvas.drawCircle(Offset(x + 2, y + 2), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _AvatarBadge extends StatelessWidget {
  const _AvatarBadge({
    required this.avatar,
    required this.size,
    required this.level,
    required this.showLevel,
  });

  final AvatarOption avatar;
  final double size;
  final int level;
  final bool showLevel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                avatar.primary.withValues(alpha: 0.95),
                avatar.secondary.withValues(alpha: 0.62),
                _surfaceHighest,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: avatar.primary, width: 2),
            boxShadow: [
              BoxShadow(
                color: avatar.primary.withValues(alpha: 0.32),
                blurRadius: 20,
              ),
            ],
          ),
          child: Icon(avatar.icon, color: _surfaceLowest, size: size * 0.46),
        ),
        if (showLevel)
          Positioned(
            right: -4,
            bottom: -6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _surfaceHighest,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: _secondary.withValues(alpha: 0.45)),
              ),
              child: Text(
                'LV $level',
                style: const TextStyle(
                  color: _secondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _AvatarChoice extends StatelessWidget {
  const _AvatarChoice({
    super.key,
    required this.avatar,
    required this.selected,
    required this.onTap,
  });

  final AvatarOption avatar;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 112,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected
              ? avatar.primary.withValues(alpha: 0.16)
              : _surfaceHigh,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? avatar.primary : _outlineVariant,
          ),
        ),
        child: Column(
          children: [
            _AvatarBadge(avatar: avatar, size: 54, level: 1, showLevel: false),
            const SizedBox(height: 8),
            Text(
              avatar.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selected ? avatar.primary : _onSurfaceVariant,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MeterBar extends StatelessWidget {
  const _MeterBar({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final double value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 12,
            backgroundColor: _surfaceHighest,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _surfaceHigh,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          '$label: $value',
          style: const TextStyle(
            color: _onSurfaceVariant,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _GoldBadge extends StatelessWidget {
  const _GoldBadge({required this.gold});

  final int gold;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: _tertiary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: _tertiary.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.toll, color: _tertiary, size: 18),
            const SizedBox(width: 5),
            Text(
              'Gold $gold',
              style: const TextStyle(
                color: _tertiary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoicePill extends StatelessWidget {
  const _ChoicePill({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.16) : _surfaceHigh,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: selected ? color.withValues(alpha: 0.62) : _outlineVariant,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: selected ? color : _onSurfaceVariant, size: 17),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? color : _onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 13),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: _primary, size: 18),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: _onSurface,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasQuests});

  final bool hasQuests;

  @override
  Widget build(BuildContext context) {
    return _GlassPanel(
      glowColor: _primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Icon(
              hasQuests ? Icons.filter_alt_off : Icons.auto_awesome,
              color: _onSurfaceVariant,
              size: 40,
            ),
            const SizedBox(height: 10),
            Text(
              hasQuests ? 'No quests in this filter' : 'The realm is quiet',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _onSurface,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              hasQuests
                  ? 'Try another quest status.'
                  : 'Add a quest to begin your journey.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: _onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
