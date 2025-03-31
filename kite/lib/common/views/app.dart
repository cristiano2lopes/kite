import 'package:flutter/material.dart';
import 'package:kite/common/models/bootstrap.dart';
import 'package:kite/common/services/bootstrap.dart';
import 'package:kite/common/services/navigation.dart' show NavigationService;
import 'package:kite/common/views/splash_screen.dart';

class AppEntryPointViewModel{

  final BootstrapService bootstrapService;
  final NavigationService navigationService;

  AppEntryPointViewModel({required this.bootstrapService, required this.navigationService});

  Future<BootstrapData> bootstrap(){
    return bootstrapService.bootstrap();
  }

  void goToInitialRoute(String route, BootstrapData data){
    navigationService.go(route, extra: data.categoriesResponse);
  }

  void retryBootstrap(){
    navigationService.go("/");
  }

}

class AppEntryPoint extends StatelessWidget {
  final AppEntryPointViewModel viewModel;

  const AppEntryPoint(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<BootstrapData?>(
        future: viewModel.bootstrap(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return const SplashScreen();
            case ConnectionState.done:
              final bootstrapData = snapshot.data;
              if (bootstrapData != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    viewModel.goToInitialRoute(bootstrapData.initialRoute, bootstrapData);
                  }
                });
                return const SplashScreen();
              } else {
                return SplashScreen(
                  retryAction: viewModel.retryBootstrap,
                );
              }
          }
        },
      ),
    );
  }
}
