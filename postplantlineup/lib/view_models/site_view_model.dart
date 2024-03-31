
import '../models/sites_model.dart';

class SiteCardViewModel {
  final SiteModel site;
  final Function(String) onSiteSelected;

  SiteCardViewModel({required this.site, required this.onSiteSelected});

  void selectSite() {
    onSiteSelected(site.siteName);
  }

  String get mapName => site.siteName;
}