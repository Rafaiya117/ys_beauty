import 'package:flutter/material.dart';
import '../model/terms_condition_model.dart';

class TermsConditionViewModel extends ChangeNotifier {
  late TermsConditionModel _termsConditionModel;

  // Constructor - initialize data immediately
  TermsConditionViewModel() {
    _initializeData();
  }

  // Getters
  TermsConditionModel get termsConditionModel => _termsConditionModel;
  bool get isLoading => _termsConditionModel.isLoading;
  String? get errorMessage => _termsConditionModel.errorMessage;
  String? get successMessage => _termsConditionModel.successMessage;
  String get content => _termsConditionModel.content;

  void _initializeData() {
    _termsConditionModel = TermsConditionModel(
      content: _getTermsContent(),
    );
    notifyListeners();
  }

  String _getTermsContent() {
    return '''Lorem ipsum dolor sit amet consectetur. Lacus at venenatis gravida vivamus mauris. Quisque mi est vel dis. Donec rhoncus laoreet odio orci sed risus elit accumsan. Mattis ut est tristique amet vitae at aliquet. Ac vel porttitor egestas scelerisque enim quisque senectus. Euismod ultricies vulputate id cras bibendum sollicitudin proin odio bibendum. Velit velit in scelerisque erat etiam rutrum phasellus nunc. Sed lectus sed a at et eget. Nunc purus sed quis at risus. Consectetur nibh justo proin placerat condimentum id at adipiscing.

Vel blandit mi nulla sodales consectetur. Egestas tristique ultrices gravida duis nisl odio. Posuere curabitur eu platea pellentesque ut. Facilisi elementum neque mauris facilisis in. Cursus condimentum ipsum pretium consequat turpis at porttitor nisi.

Scelerisque tellus praesent condimentum euismod a faucibus. Auctor at ultricies at urna aliquam massa pellentesque. Vitae vulputate nullam diam placerat m.

Lorem ipsum dolor sit amet consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo.

Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.

Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.

Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur.

At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident.''';
  }

  // Clear error message
  void clearError() {
    if (_termsConditionModel.errorMessage != null) {
      _termsConditionModel = _termsConditionModel.copyWith(errorMessage: null);
      notifyListeners();
    }
  }

  // Clear success message
  void clearSuccess() {
    if (_termsConditionModel.successMessage != null) {
      _termsConditionModel = _termsConditionModel.copyWith(successMessage: null);
      notifyListeners();
    }
  }
}
