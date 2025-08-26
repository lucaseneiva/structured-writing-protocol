import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';
import 'package:structured_writing_protocol/presentation/widgets/confirmation_dialog.dart';
import 'session_flow/instructions_view.dart';
import 'session_flow/writing_view.dart';
import 'session_flow/finished_view.dart';
import 'package:structured_writing_protocol/domain/entities/session.dart';
import 'package:uuid/uuid.dart';
import 'package:structured_writing_protocol/providers.dart';
import 'package:flutter/foundation.dart';

enum SessionState { instructions, writing, finished }

class SessionView extends ConsumerStatefulWidget {
  final int sessionNumber;
  final int sessionDurationInMinutes;

  const SessionView({
    super.key,
    required this.sessionNumber,
    required this.sessionDurationInMinutes,
  });

  @override
  ConsumerState<SessionView> createState() => _SessionViewState();
}

class _SessionViewState extends ConsumerState<SessionView> {
  var _sessionState = SessionState.instructions;

  late final TextEditingController _textController;
  final FocusNode _focusNode = FocusNode();
  Timer? _timer;
  double _elapsedSeconds = 0;
    

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  void _startSession() {
    setState(() {
      _sessionState = SessionState.writing;
      _focusNode.requestFocus();
      _startTimer();
    });
  }

  void _startTimer() {
    final totalDuration = widget.sessionDurationInMinutes * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_elapsedSeconds < totalDuration) {
        setState(() {
          _elapsedSeconds++;
        });
      } else {
        _timer?.cancel();
        setState(() {
          _sessionState = SessionState.finished;
        });
      }
    });
  }

  Future<void> _saveSessionAndExit() async {
    final activeCycle = ref.read(activeCycleProvider);
    final currentDate = ref.read(currentDateProvider);

    if (activeCycle == null) return;

    final newSession = Session(
      id: const Uuid().v4(),
      text: _textController.text,
      duration: widget.sessionDurationInMinutes,
      number: widget.sessionNumber,
      date: currentDate,
    );

    await ref
        .read(writingRepositoryProvider)
        .saveSession(activeCycle.id, newSession);

    ref.invalidate(cycleListProvider);

    if (mounted) Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _sessionState != SessionState.writing,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }

        if (_sessionState == SessionState.writing) {
          final shouldExit = await showDialog<bool>(
            context: context,
            builder: (context) => ConfirmationDialog(
              title: "Sair da Sessão?",
              message: "Seu progresso não salvo será perdido.",
              onConfirmation: () => Navigator.of(context).pop(true),
              confirmButtonText: "Sair",
            ),
          );

          // If confirmed, pop the Navigator to exit the screen
          if (shouldExit == true && mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Sessão ${widget.sessionNumber}'), actions: [
          if (kDebugMode)
            IconButton(
              icon: const Icon(Icons.fast_forward_rounded),
              tooltip: 'Avançar um dia (Debug)',
              onPressed: () {
                _sessionState = SessionState.finished;
              },
            ),
        ],),
        body: _buildBody(),
        
      ),
    );
  }

  // O buildBody agora é um seletor simples e limpo
  Widget _buildBody() {
    switch (_sessionState) {
      case SessionState.instructions:
        return InstructionsView(onStartPressed: _startSession);
      case SessionState.writing:
        return WritingView(controller: _textController, focusNode: _focusNode);
      case SessionState.finished:
        return FinishedView(
          text: _textController.text,
          onSavePressed: _saveSessionAndExit,
        );
    }
  }
}
