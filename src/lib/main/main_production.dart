import 'package:gyde_app/main/bootstrap.dart';
import 'package:gyde_app/models/enums/flavor.dart';
import 'package:gyde_app/ui/views/app/app_view.dart';

void main() {
  bootstrap(
    builder: () => const AppView(),
    flavor: Flavor.production,
  );
}
