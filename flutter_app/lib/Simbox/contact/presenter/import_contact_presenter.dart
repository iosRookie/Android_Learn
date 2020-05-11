import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_app/Simbox/common/mvp/base_page_presenter.dart';
import 'package:flutter_app/Simbox/contact/page/import_contact_page.dart';


typedef void ReadFinished(bool success, List<Contact> contacts);

class ImportContactPresenter extends BasePagePresenter<ImportContactsPageState> {

  readSystemContacts(ReadFinished finish) async{
    Future.delayed(Duration(seconds: 0), () {
      view?.showProgress();
    });

    Iterable<Contact> tContacts = await ContactsService.getContacts(withThumbnails: false);
    finish(true, tContacts.toList());

    Future.delayed(Duration(seconds: 2), () {
      view?.closeProgress();
    });
  }


}
