import 'package:flutter/material.dart';
import 'package:eum_demo/services/user/skill_service.dart';
import 'package:eum_demo/models/skill_list/skill_category.dart';

class SkillCategoryProvider extends ChangeNotifier {
  final SkillService _skillService;
  List<SkillCategory> _categories = [];
  bool _isLoading = false;
  String? _error;

  SkillCategoryProvider({SkillService? skillService}) : _skillService = skillService ?? SkillService();

  List<SkillCategory> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await _skillService.fetchAllSkillCategoriesParsed();
      _categories = data;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
