import 'package:note/features/onboard/domain/entities/onboard_entity.dart';

const List<OnboardEntity> onboardItems = [
  OnboardEntity(
    lottiePath: "assets/lottie/convenience_animation.json",
    title: "Удобство",
    description:
        "Создавайте заметки в два клика! Записывайте мысли, идеи и важные задачи мгновенно.",
  ),
  OnboardEntity(
    lottiePath: "assets/lottie/organization_animation.json",
    title: "Организация",
    description:
        "Организуйте заметки по папкам и тегам. Легко находите нужную информацию в любое время.",
  ),
  OnboardEntity(
    lottiePath: "assets/lottie/synchronization_animation.json",
    title: "Синхронизация",
    description:
        "Синхронизация на всех устройствах. Доступ к записям в любое время и в любом месте.",
  ),
];
