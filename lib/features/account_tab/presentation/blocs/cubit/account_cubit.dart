import 'package:meta/meta.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/service/launcher_service.dart';

part 'account_state.dart';

const whatsAppNumber = "+96597970932";
const tikTokLink = "https://www.tiktok.com/@getbaqah";
const youtubeLink = "https://www.youtube.com/@getbaqah";
const twitterLink = "https://twitter.com/getbaqah";
const snapchatLink = "https://t.snapchat.com/LJ30HI8H";
const instagramLink = "https://www.instagram.com/squaree_app/";

class AccountCubit extends BaseCubit<AccountState> {
  AccountCubit(this._launcherService) : super(const AccountState());

  final LauncherService _launcherService;

  Future<void> startWhatsAppChat() async {
    await _launcherService.openWhatsappChat(phoneNumber: whatsAppNumber);
  }

  Future<void> openTikTokLink() async {
    await _launcherService.openWebsite(tikTokLink);
  }

  Future<void> openYoutubeLink() async {
    await _launcherService.openWebsite(youtubeLink);
  }

  Future<void> openTwitterLink() async {
    await _launcherService.openWebsite(twitterLink);
  }

  Future<void> openSnapChatLink() async {
    await _launcherService.openWebsite(snapchatLink);
  }

  Future<void> openInstagramLink() async {
    await _launcherService.openWebsite(instagramLink);
  }

  void changeExpansionStatus() async {
    emit(state.copyWith(isSocialExpanded: !state.isSocialExpanded));
  }
}
