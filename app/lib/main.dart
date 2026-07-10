/// 앱 엔트리 — 실행 경고 게이트 → 홈/레슨/전이 화면.
library;

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'assessment/learning_evidence.dart';
import 'assessment/review_evidence.dart';
import 'assessment/review_queue.dart';
import 'lesson/graduation_screen.dart';
import 'lesson/home_screen.dart';
import 'lesson/lesson_instance.dart';
import 'lesson/lesson_screen.dart';
import 'lesson/learning_evidence_review_screen.dart';
import 'lesson/learning_data_management_screen.dart';
import 'lesson/recording_library_screen.dart';
import 'lesson/repertoire_application_review_screen.dart';
import 'lesson/review_evidence_screen.dart';
import 'lesson/review_practice_screen.dart';
import 'lesson/review_queue_screen.dart';
import 'lesson/settings_screen.dart';
import 'lesson/range_boundary_check_screen.dart';
import 'lesson/standard_sample_review_screen.dart';
import 'lesson/tone_profile_screen.dart';
import 'lesson/vocal_fatigue_check_screen.dart';
import 'lesson/vocal_screening_screen.dart';
import 'onboarding/onboarding_screen.dart';
import 'lesson/pitch/pitch_source.dart';
import 'lesson/pitch/recording_pitch_source.dart';
import 'recording/audio_io.dart';
import 'recording/audio_session_coordinator.dart';
import 'recording/recording_ab.dart';
import 'recording/recording_store.dart';
import 'progression/progression_state.dart';
import 'progression/progression_store.dart';
import 'safety/launch_warning.dart';
import 'safety/range_boundary_store.dart';
import 'safety/vocal_fatigue_store.dart';
import 'safety/vocal_load_budget.dart';
import 'safety/vocal_load_store.dart';
import 'safety/vocal_recovery.dart';
import 'safety/vocal_screening.dart';
import 'safety/vocal_screening_store.dart';
import 'storage/app_metadata_store.dart';
import 'theme/app_theme.dart';

const _kOnboardingSeenKey = 'onboarding_seen_v1';
const appVersionFallback = 'unknown';

typedef PackageVersionLoader = Future<String> Function();

Future<String> loadAppVersion({PackageVersionLoader? loader}) async {
  try {
    return await (loader ?? _loadPlatformPackageVersion)();
  } catch (_) {
    return appVersionFallback;
  }
}

Future<String> _loadPlatformPackageVersion() async =>
    (await PackageInfo.fromPlatform()).version;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final metadataStore = AppMetadataStore.shared;
  final seen = await metadataStore.readString(_kOnboardingSeenKey);
  final appVersion = await loadAppVersion();
  runApp(
    DebugApp(
      pitchSource: RecordingPitchSource(),
      metadataStore: metadataStore,
      store: ProgressionStore(metadataStore: metadataStore),
      startWithOnboarding: seen == null,
      appVersion: appVersion,
    ),
  );
}

class DebugApp extends StatelessWidget {
  const DebugApp({
    super.key,
    this.initialProgression,
    this.pitchSource,
    this.store,
    this.recordingRepository,
    this.recordingCaptureAdapter,
    this.recordingPlaybackAdapter,
    this.trainingAudioPlaybackAdapter,
    this.recordingPathResolver,
    this.evidenceRepository,
    this.reviewQueueRepository,
    this.reviewEvidenceRepository,
    this.audioSessionCoordinator,
    this.metadataStore,
    this.todayEpochDay,
    this.startInLesson = false,
    this.startWithOnboarding = false,
    this.appVersion = 'development',
  });

  final Progression? initialProgression;
  final PitchSource? pitchSource;
  final ProgressionStore? store;
  final RecordingRepository? recordingRepository;
  final AudioCaptureAdapter? recordingCaptureAdapter;
  final AudioPlaybackAdapter? recordingPlaybackAdapter;
  final TrainingAudioPlaybackAdapter? trainingAudioPlaybackAdapter;
  final RecordingFilePathResolver? recordingPathResolver;
  final LearningEvidenceRepository? evidenceRepository;
  final ReviewQueueRepository? reviewQueueRepository;
  final ReviewEvidenceRepository? reviewEvidenceRepository;
  final AudioSessionCoordinator? audioSessionCoordinator;
  final AppMetadataStore? metadataStore;
  final int? todayEpochDay;
  final bool startInLesson;
  final bool startWithOnboarding;
  final String appVersion;

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Vocal Athlete',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Sun.bg,
      colorScheme: const ColorScheme.dark(
        primary: Sun.coral,
        onPrimary: Sun.onAccent,
        secondary: Sun.coral,
        onSecondary: Sun.onAccent,
        surface: Sun.surface,
        onSurface: Sun.ink,
      ),
      sliderTheme: const SliderThemeData(
        activeTrackColor: Sun.coral,
        inactiveTrackColor: Sun.lockBg,
        thumbColor: Sun.coral,
        overlayColor: Sun.coralOverlay,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) =>
              s.contains(WidgetState.selected) ? Sun.coral : Colors.transparent,
        ),
        checkColor: const WidgetStatePropertyAll(Sun.onAccent),
        side: const BorderSide(color: Sun.lockInk, width: 1.5),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: Sun.coral),
      ),
    ),
    home: _AppShell(
      initial: initialProgression,
      pitchSource: pitchSource,
      store: store,
      recordingRepository: recordingRepository,
      recordingCaptureAdapter: recordingCaptureAdapter,
      recordingPlaybackAdapter: recordingPlaybackAdapter,
      trainingAudioPlaybackAdapter: trainingAudioPlaybackAdapter,
      recordingPathResolver: recordingPathResolver,
      evidenceRepository: evidenceRepository,
      reviewQueueRepository: reviewQueueRepository,
      reviewEvidenceRepository: reviewEvidenceRepository,
      audioSessionCoordinator: audioSessionCoordinator,
      metadataStore: metadataStore,
      todayEpochDay: todayEpochDay,
      startInLesson: startInLesson,
      startWithOnboarding: startWithOnboarding,
      appVersion: appVersion,
    ),
  );
}

/// 로컬 자정 기준 epoch day(1970-01-01부터의 일수).
int currentEpochDay() {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day).millisecondsSinceEpoch ~/
      Duration.millisecondsPerDay;
}

class _AppShell extends StatefulWidget {
  const _AppShell({
    this.initial,
    this.pitchSource,
    this.store,
    this.recordingRepository,
    this.recordingCaptureAdapter,
    this.recordingPlaybackAdapter,
    this.trainingAudioPlaybackAdapter,
    this.recordingPathResolver,
    this.evidenceRepository,
    this.reviewQueueRepository,
    this.reviewEvidenceRepository,
    this.audioSessionCoordinator,
    this.metadataStore,
    this.todayEpochDay,
    this.startInLesson = false,
    this.startWithOnboarding = false,
    required this.appVersion,
  });
  final Progression? initial;
  final PitchSource? pitchSource;
  final ProgressionStore? store;
  final RecordingRepository? recordingRepository;
  final AudioCaptureAdapter? recordingCaptureAdapter;
  final AudioPlaybackAdapter? recordingPlaybackAdapter;
  final TrainingAudioPlaybackAdapter? trainingAudioPlaybackAdapter;
  final RecordingFilePathResolver? recordingPathResolver;
  final LearningEvidenceRepository? evidenceRepository;
  final ReviewQueueRepository? reviewQueueRepository;
  final ReviewEvidenceRepository? reviewEvidenceRepository;
  final AudioSessionCoordinator? audioSessionCoordinator;
  final AppMetadataStore? metadataStore;
  final int? todayEpochDay;
  final bool startInLesson;
  final bool startWithOnboarding;
  final String appVersion;
  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> with WidgetsBindingObserver {
  bool _ack = false;
  late bool _showOnboarding = widget.startWithOnboarding;
  late bool _started = widget.startInLesson;
  bool _showSettings = false;
  bool _showGenrePicker = false;
  bool _showStandardSamples = false;
  bool _showToneProfile = false;
  bool _showRecordingLibrary = false;
  bool _showRepertoireReview = false;
  bool _showLearningEvidence = false;
  bool _showReviewQueue = false;
  bool _reviewQueueDueOnly = false;
  bool _showReviewEvidence = false;
  bool _showLearningDataManagement = false;
  bool _showVocalFatigueCheck = false;
  bool _showRangeBoundaryCheck = false;
  bool _showVocalScreening = false;
  ReviewQueueItem? _activeReviewItem;
  int _dueReviewCount = 0;
  bool _pitchReady = false;
  RecordingRepository? _recordingRepository;
  AudioCaptureAdapter? _recordingCaptureAdapter;
  AudioPlaybackAdapter? _recordingPlaybackAdapter;
  TrainingAudioPlaybackAdapter? _trainingAudioPlaybackAdapter;
  RecordingFilePathResolver? _recordingPathResolver;
  late LearningEvidenceRepository _evidenceRepository;
  late ReviewQueueRepository _reviewQueueRepository;
  late ReviewEvidenceRepository _reviewEvidenceRepository;
  late AudioSessionCoordinator _audioSessionCoordinator;
  late AppMetadataStore _metadataStore;
  late bool _ownsAudioSessionCoordinator;
  late VocalLoadStore _loadStore;
  late VocalFatigueStore _fatigueStore;
  late RangeBoundaryStore _rangeStore;
  late VocalScreeningStore _screeningStore;
  Progression? _p;
  VocalLoadLedger _ledger = const VocalLoadLedger();
  VocalFatigueSelfCheck? _latestFatigue;
  RangeBoundaryTracker _rangeTracker = const RangeBoundaryTracker();
  ScreeningResult? _latestScreening;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _metadataStore =
        widget.metadataStore ??
        AppMetadataStore(primary: InMemoryMetadataBackend(), legacy: null);
    _loadStore = VocalLoadStore(metadataStore: _metadataStore);
    _fatigueStore = VocalFatigueStore(metadataStore: _metadataStore);
    _rangeStore = RangeBoundaryStore(metadataStore: _metadataStore);
    _screeningStore = VocalScreeningStore(metadataStore: _metadataStore);
    _evidenceRepository =
        widget.evidenceRepository ??
        SharedPreferencesLearningEvidenceRepository(
          metadataStore: _metadataStore,
        );
    _reviewQueueRepository =
        widget.reviewQueueRepository ??
        SharedPreferencesReviewQueueRepository(metadataStore: _metadataStore);
    _reviewEvidenceRepository =
        widget.reviewEvidenceRepository ??
        SharedPreferencesReviewEvidenceRepository(
          metadataStore: _metadataStore,
        );
    _ownsAudioSessionCoordinator = widget.audioSessionCoordinator == null;
    _audioSessionCoordinator =
        widget.audioSessionCoordinator ?? AudioSessionCoordinator();
    _recordingRepository = widget.recordingRepository;
    _recordingCaptureAdapter = widget.recordingCaptureAdapter;
    _recordingPlaybackAdapter = widget.recordingPlaybackAdapter;
    _trainingAudioPlaybackAdapter = widget.trainingAudioPlaybackAdapter;
    _recordingPathResolver = widget.recordingPathResolver;
    _initProgression();
  }

  Future<void> _initProgression() async {
    if (widget.metadataStore != null) {
      await _metadataStore.migrateKnownKeys();
    }
    final store = widget.store;
    final loaded = store == null ? null : await store.load();
    if (!mounted) return;
    final p = loaded ?? widget.initial ?? Progression.beginner();
    final today = widget.todayEpochDay ?? currentEpochDay();
    p.syncToToday(today);
    setState(() => _p = p);
    _persist();
    // 부하 ledger·자가체크는 첫 화면 렌더를 막지 않도록 별도로 로드.
    final ledger = await _loadStore.load(todayEpochDay: today);
    final fatigue = await _fatigueStore.load();
    final rangeTracker = await _rangeStore.load();
    final screening = await _screeningStore.load();
    if (mounted) {
      setState(() {
        _ledger = ledger;
        _latestFatigue = fatigue;
        _rangeTracker = rangeTracker;
        _latestScreening = screening;
      });
    }
    await _refreshDueReviews();
  }

  Future<void> _refreshDueReviews() async {
    final due = await _reviewQueueRepository.dueItems(
      widget.todayEpochDay ?? currentEpochDay(),
    );
    if (!mounted) return;
    setState(() => _dueReviewCount = due.length);
  }

  Future<void> _initRecordingStack() async {
    try {
      _trainingAudioPlaybackAdapter ??= AudioplayersTrainingAudioAdapter();
      if (_recordingRepository != null &&
          _recordingCaptureAdapter != null &&
          _recordingPlaybackAdapter != null &&
          _recordingPathResolver != null) {
        return;
      }
      final resolver = await RecordingFilePathResolver.create();
      _recordingPathResolver ??= resolver;
      _recordingRepository ??= await FileRecordingRepository.create(
        resolver: resolver,
      );
      _recordingCaptureAdapter ??= RecordAudioCaptureAdapter();
      _recordingPlaybackAdapter ??= AudioplayersPlaybackAdapter();
    } catch (_) {
      // Widget test 환경이나 플랫폼 플러그인 미연결 상태에서는 녹음 패널이 preview mode로 남는다.
    }
  }

  void _persist() {
    final p = _p;
    if (widget.store == null || p == null) return;
    // ignore: discarded_futures
    widget.store!.save(p);
  }

  /// 오늘 자가점검(VFI)이 escalation이면 오늘 레슨 강도를 낮추라는 신호.
  bool _fatigueEscalationToday() {
    final f = _latestFatigue;
    if (f == null) return false;
    final today = widget.todayEpochDay ?? currentEpochDay();
    return f.epochDay == today && f.needsEscalation;
  }

  /// 최근 적신호 스크리닝이 상담 권고(hardBlock)이고 아직 유효하면 레슨에 비차단
  /// 의료 의뢰 배너를 띄운다(연습을 막지는 않음 — 비진단·무점수).
  bool _screeningReferralActive() {
    final s = _latestScreening;
    if (s == null) return false;
    final today = widget.todayEpochDay ?? currentEpochDay();
    return s.referralAdvised && s.isValidAt(today);
  }

  void _onOnboardingDone() {
    setState(() => _showOnboarding = false);
    // 다시 보지 않도록 1회성 플래그를 영속화(실패해도 흐름은 막지 않는다).
    // ignore: discarded_futures
    widget.metadataStore?.writeString(_kOnboardingSeenKey, 'true');
  }

  Future<void> _onAck() async {
    setState(() => _ack = true);
    final src = widget.pitchSource;
    final ok = src == null ? false : await src.start();
    await _initRecordingStack();
    if (!mounted) return;
    setState(() => _pitchReady = ok);
  }

  void _onComplete() {
    // 부하 예산 누적: 완료 직전 카드의 강도 + 보수적 발성시간 추정(마이크 비의존).
    final completedCard = resolveLessonInstance(_p!.todaysLesson, _p!.day).card;
    final today = widget.todayEpochDay ?? currentEpochDay();
    _ledger = _ledger.add(
      intensity: VocalLoadPolicy.intensityForCard(completedCard),
      epochDay: today,
      phonationSeconds: estimatePhonationSeconds(completedCard),
    );
    // ignore: discarded_futures
    _loadStore.save(_ledger, todayEpochDay: today);
    final outcome = _p!.completeLesson();
    _persist();
    setState(() => _started = false);
    // ignore: discarded_futures
    _refreshDueReviews();
    final msg = kOutcomeMessage[outcome] ?? '';
    if (msg.isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(key: const Key('outcome-snack'), content: Text(msg)),
    );
  }

  void _onStartUniversalCore() {
    setState(() {
      _p!.startUniversalCore();
      _showGenrePicker = false;
      _started = false;
    });
    _persist();
  }

  void _onStartRepertoireApplication() {
    setState(() {
      _p!.startRepertoireApplication();
      _showGenrePicker = false;
      _started = false;
    });
    _persist();
  }

  void _onPickGenre(Genre g) {
    setState(() {
      _p!.chooseGenre(g);
      _showGenrePicker = false;
      _started = false;
    });
    _persist();
    // 아직 출시되지 않은 Lab을 고르면 조용히 유지 모드로 빠지므로, 무슨 일이
    // 일어났는지 즉시 안내한다(선택이 무시된 듯한 인상 방지).
    if (_p!.maintenance) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          key: const Key('genre-coming-soon-snack'),
          content: Text(
            '${kGenreLabel[g] ?? '이 장르'} Lab은 아직 준비 중이에요. '
            '열릴 때까지 지금 실력을 가볍게 유지하는 훈련을 이어갑니다.',
          ),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  void _onStartReview(ReviewQueueItem item) {
    setState(() {
      _showReviewQueue = false;
      _activeReviewItem = item;
    });
  }

  void _onReviewFinished() {
    setState(() {
      _activeReviewItem = null;
      _showReviewQueue = true;
    });
    // ignore: discarded_futures
    _refreshDueReviews();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) return;
    // 백그라운드/통화/화면 전환 중 훈련 음원과 녹음을 계속하지 않는다.
    // ignore: discarded_futures
    _trainingAudioPlaybackAdapter?.stop();
    // ignore: discarded_futures
    _recordingPlaybackAdapter?.stop();
    // ignore: discarded_futures
    _recordingCaptureAdapter?.cancel();
    _audioSessionCoordinator.signal(
      AudioSessionAction.allStopped,
      AudioSessionStopReason.appLifecycle,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    final src = widget.pitchSource;
    if (src != null) {
      // ignore: discarded_futures
      src.stop();
      src.dispose();
    }
    // ignore: discarded_futures
    _recordingCaptureAdapter?.cancel();
    // ignore: discarded_futures
    _recordingCaptureAdapter?.dispose();
    // ignore: discarded_futures
    _recordingPlaybackAdapter?.dispose();
    // ignore: discarded_futures
    _trainingAudioPlaybackAdapter?.dispose();
    if (_ownsAudioSessionCoordinator) {
      _audioSessionCoordinator.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final (id, screen) = _resolveScreen();
    // 화면 전환 페이드-스루(setState 기반 셸이라 라우트 전환 대신 AnimatedSwitcher).
    // 각 화면을 고유 id로 키잉하고 StackFit.expand로 전체 화면을 채운다.
    return AnimatedSwitcher(
      duration: Motion.reduced(context) ? Duration.zero : Motion.fast,
      switchInCurve: Motion.curve,
      switchOutCurve: Motion.curve,
      layoutBuilder: (currentChild, previousChildren) => Stack(
        fit: StackFit.expand,
        children: [...previousChildren, ?currentChild],
      ),
      child: KeyedSubtree(key: ValueKey(id), child: screen),
    );
  }

  (String, Widget) _resolveScreen() {
    final p = _p;
    if (p == null) {
      return ('boot', const Scaffold(backgroundColor: Sun.bg));
    }
    if (!_ack) return ('warn', LaunchWarning(onConfirm: _onAck));
    if (_showOnboarding) {
      return ('onboarding', OnboardingScreen(onDone: _onOnboardingDone));
    }

    // R4+ 단계 전이: 초급→Universal Core, Universal Core→Repertoire Application,
    // Repertoire Application→Advanced Genre Lab picker.
    if (p.canStartUniversalCore ||
        p.canStartRepertoireApplication ||
        p.canPickAdvancedGenre ||
        _showGenrePicker) {
      return (
        'graduation',
        GraduationScreen(
          progression: p,
          onStartUniversalCore: _onStartUniversalCore,
          onStartRepertoireApplication: _onStartRepertoireApplication,
          onPick: _onPickGenre,
        ),
      );
    }

    if (_showStandardSamples) {
      return (
        'standardSamples',
        StandardSampleReviewScreen(
          repository: _recordingRepository,
          playbackAdapter: _recordingPlaybackAdapter,
          onBack: () => setState(() => _showStandardSamples = false),
        ),
      );
    }

    if (_showVocalFatigueCheck) {
      return (
        'vocalFatigueCheck',
        VocalFatigueCheckScreen(
          initial: _latestFatigue,
          onBack: () => setState(() => _showVocalFatigueCheck = false),
          onSubmit: (check) {
            final stamped = VocalFatigueSelfCheck(
              tiredness: check.tiredness,
              discomfort: check.discomfort,
              poorRecovery: check.poorRecovery,
              epochDay: widget.todayEpochDay ?? currentEpochDay(),
            );
            setState(() => _latestFatigue = stamped);
            // ignore: discarded_futures
            _fatigueStore.save(stamped);
          },
        ),
      );
    }

    if (_showVocalScreening) {
      return (
        'vocalScreening',
        VocalScreeningScreen(
          todayEpochDay: widget.todayEpochDay ?? currentEpochDay(),
          onBack: () => setState(() => _showVocalScreening = false),
          onSubmit: (result) {
            setState(() => _latestScreening = result);
            // ignore: discarded_futures
            _screeningStore.save(result);
          },
        ),
      );
    }

    if (_showRangeBoundaryCheck) {
      return (
        'rangeBoundaryCheck',
        RangeBoundaryCheckScreen(
          tracker: _rangeTracker,
          onBack: () => setState(() => _showRangeBoundaryCheck = false),
          onRecord: (verification) {
            final updated = _rangeTracker.record(verification);
            setState(() => _rangeTracker = updated);
            // ignore: discarded_futures
            _rangeStore.save(updated);
          },
        ),
      );
    }

    if (_showToneProfile) {
      return (
        'toneProfile',
        ToneProfileScreen(
          repository: _recordingRepository,
          onBack: () => setState(() => _showToneProfile = false),
        ),
      );
    }

    if (_showRecordingLibrary) {
      return (
        'recordingLibrary',
        RecordingLibraryScreen(
          repository: _recordingRepository,
          onBack: () => setState(() => _showRecordingLibrary = false),
        ),
      );
    }

    if (_showRepertoireReview) {
      return (
        'repertoireReview',
        RepertoireApplicationReviewScreen(
          repository: _recordingRepository,
          playbackAdapter: _recordingPlaybackAdapter,
          onBack: () => setState(() => _showRepertoireReview = false),
        ),
      );
    }

    if (_showLearningEvidence) {
      return (
        'learningEvidence',
        LearningEvidenceReviewScreen(
          repository: _evidenceRepository,
          onBack: () => setState(() => _showLearningEvidence = false),
        ),
      );
    }

    final activeReview = _activeReviewItem;
    if (activeReview != null) {
      return (
        'reviewPractice',
        ReviewPracticeScreen(
          item: activeReview,
          reviewQueueRepository: _reviewQueueRepository,
          learningEvidenceRepository: _evidenceRepository,
          reviewEvidenceRepository: _reviewEvidenceRepository,
          todayEpochDay: widget.todayEpochDay ?? currentEpochDay(),
          recordingRepository: _recordingRepository,
          captureAdapter: _recordingCaptureAdapter,
          playbackAdapter: _recordingPlaybackAdapter,
          pathResolver: _recordingPathResolver,
          audioSessionCoordinator: _audioSessionCoordinator,
          onBack: () => setState(() {
            _activeReviewItem = null;
            _showReviewQueue = true;
          }),
          onFinished: _onReviewFinished,
        ),
      );
    }

    if (_showReviewQueue) {
      return (
        'reviewQueue',
        ReviewQueueScreen(
          repository: _reviewQueueRepository,
          todayEpochDay: widget.todayEpochDay ?? currentEpochDay(),
          dueOnly: _reviewQueueDueOnly,
          onStartReview: _onStartReview,
          onChanged: _refreshDueReviews,
          onBack: () => setState(() {
            _showReviewQueue = false;
            _reviewQueueDueOnly = false;
          }),
        ),
      );
    }

    if (_showReviewEvidence) {
      return (
        'reviewEvidence',
        ReviewEvidenceScreen(
          repository: _reviewEvidenceRepository,
          onBack: () => setState(() => _showReviewEvidence = false),
        ),
      );
    }

    if (_showLearningDataManagement) {
      return (
        'learningDataManagement',
        LearningDataManagementScreen(
          metadataStore: _metadataStore,
          onBack: () => setState(() => _showLearningDataManagement = false),
          onCleared: () {
            setState(() {
              _p = Progression.beginner();
              _dueReviewCount = 0;
              _showLearningDataManagement = false;
            });
          },
        ),
      );
    }

    if (_showSettings) {
      return (
        'settings',
        SettingsScreen(
          micGranted: _pitchReady,
          onBack: () => setState(() => _showSettings = false),
          version: widget.appVersion,
          onOpenStandardSamples: () => setState(() {
            _showSettings = false;
            _showStandardSamples = true;
          }),
          onOpenToneProfile: () => setState(() {
            _showSettings = false;
            _showToneProfile = true;
          }),
          onOpenVocalFatigueCheck: () => setState(() {
            _showSettings = false;
            _showVocalFatigueCheck = true;
          }),
          onOpenRangeBoundaryCheck: () => setState(() {
            _showSettings = false;
            _showRangeBoundaryCheck = true;
          }),
          onOpenVocalScreening: () => setState(() {
            _showSettings = false;
            _showVocalScreening = true;
          }),
          onOpenRecordingLibrary: () => setState(() {
            _showSettings = false;
            _showRecordingLibrary = true;
          }),
          onOpenRepertoireReview: () => setState(() {
            _showSettings = false;
            _showRepertoireReview = true;
          }),
          onOpenLearningEvidence: () => setState(() {
            _showSettings = false;
            _showLearningEvidence = true;
          }),
          onOpenReviewQueue: () => setState(() {
            _showSettings = false;
            _reviewQueueDueOnly = false;
            _showReviewQueue = true;
          }),
          onOpenReviewEvidence: () => setState(() {
            _showSettings = false;
            _showReviewEvidence = true;
          }),
          onOpenLearningDataManagement: () => setState(() {
            _showSettings = false;
            _showLearningDataManagement = true;
          }),
          onChangeGenre:
              (p.stage == LearningStage.advancedGenre ||
                  p.stage == LearningStage.maintenance ||
                  p.canPickAdvancedGenre)
              ? () => setState(() {
                  _showSettings = false;
                  _showGenrePicker = true;
                })
              : null,
        ),
      );
    }

    if (!_started) {
      return (
        'home',
        HomeScreen(
          progression: p,
          onStart: () => setState(() => _started = true),
          onSettings: () => setState(() => _showSettings = true),
          dueReviewCount: _dueReviewCount,
          onOpenReviews: _dueReviewCount > 0
              ? () => setState(() {
                  _reviewQueueDueOnly = true;
                  _showReviewQueue = true;
                })
              : null,
        ),
      );
    }

    return (
      'lesson',
      LessonScreen(
        progression: p,
        ledger: _ledger,
        fatigueEscalation: _fatigueEscalationToday(),
        screeningReferral: _screeningReferralActive(),
        pitchSource: _pitchReady ? widget.pitchSource : null,
        recordingRepository: _recordingRepository,
        recordingCaptureAdapter: _recordingCaptureAdapter,
        recordingPlaybackAdapter: _recordingPlaybackAdapter,
        trainingAudioPlaybackAdapter: _trainingAudioPlaybackAdapter,
        recordingPathResolver: _recordingPathResolver,
        evidenceRepository: _evidenceRepository,
        reviewQueueRepository: _reviewQueueRepository,
        audioSessionCoordinator: _audioSessionCoordinator,
        onComplete: _onComplete,
      ),
    );
  }
}
