import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

// Importando nossos novos widgets limpos
import 'session_flow/instructions_view.dart';
import 'session_flow/writing_view.dart';
import 'session_flow/finished_view.dart';

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
  
  // A lógica de estado e os controllers continuam aqui
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
        setState(() { _elapsedSeconds++; });
      } else {
        _timer?.cancel();
        setState(() { _sessionState = SessionState.finished; });
      }
    });
  }

  Future<void> _saveSessionAndExit() async {
    // TODO: Implementar a lógica de salvar com o repositório
    // await ref.read(writingRepositoryProvider).saveSession(...);
    // ref.invalidate(cycleListProvider);
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
      onPopInvoked: _onPopInvoked,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sessão ${widget.sessionNumber}'),
          // TODO: Mostrar o timer aqui
        ),
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

  void _onPopInvoked(bool didPop) async {
    if (didPop) return;
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Sair da Sessão?"),
        content: const Text("Seu progresso não salvo será perdido."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Ficar")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Sair")),
        ],
      ),
    );
    if (shouldPop ?? false) {
      Navigator.pop(context);
    }
  }
}