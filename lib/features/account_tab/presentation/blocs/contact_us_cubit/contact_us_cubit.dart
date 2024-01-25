import 'package:meta/meta.dart';

import '../../../../../core/abstract/base_cubit.dart';
import '../../../../../core/service/launcher_service.dart';

part 'contact_us_state.dart';

const whatsAppNumber = "+96597762996";
const customerServiceNumber = "+96522622474";
const twitterLink = "https://twitter.com/slots";
const instagramLink = "https://www.instagram.com/alsalmankw/";

class ContactUsCubit extends BaseCubit<ContactUsState> {
  ContactUsCubit(this._launcherService) : super(const ContactUsState());

  final LauncherService _launcherService;

  Future<void> startWhatsAppChat() async {
    await _launcherService.openWhatsappChat(phoneNumber: whatsAppNumber);
  }

  Future<void> startCustomerServiceCall() async {
    await _launcherService.callPhone(customerServiceNumber);
  }

  Future<void> openTwitterLink() async {
    await _launcherService.openWebsite(twitterLink);
  }

  Future<void> openInstagramLink() async {
    await _launcherService.openWebsite(instagramLink);
  }
}
