import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pumba_ex/presentation/bloc/lifecycle/lifesycle_cubit.dart';

class LifecycleObserver extends StatefulWidget {
  final Widget child;
  final String userId;

  const LifecycleObserver({
    super.key,
    required this.child,
    required this.userId,
  });

  @override
  State<LifecycleObserver> createState() => _LifecycleObserverState();
}

class _LifecycleObserverState extends State<LifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<LifecycleCubit>().startMonitoring(widget.userId);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    context.read<LifecycleCubit>().stopMonitoring();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cubit = context.read<LifecycleCubit>();

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        cubit.stopMonitoring();
        cubit.markOffline();
        break;
      case AppLifecycleState.resumed:
        cubit.startMonitoring(widget.userId);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
