import 'package:flutter/material.dart';

class ClassDataProvider extends ChangeNotifier {
  // 기존 static 더미 데이터 옮김
  Map<String, List<Map<String, String>>> _classDataByCategory = {
    '인기': [
      {
        'title': '나전칠기의 기원',
        'region': '서울시 종로구',
        'desc': '나전칠기의 기원과 역사에 대한 강의입니다.',
        'price': '13,000원',
        'image': 'assets/images/oneday_class/hot01.png',
      },
      {
        'title': '전통 무용이란',
        'region': '서울시 동대문구',
        'desc': '전통 무용이 무엇인지 기원과 개념에 대해 학습합니다.',
        'price': '18,000원',
        'image': 'assets/images/oneday_class/hot02.png',
      },
      {
        'title': '한국 장 담그기 종류',
        'region': '서울시 송파구',
        'desc': '장의 종류와 그들의 특징에 대해 알아봅니다.',
        'price': '13,000원',
        'image': 'assets/images/oneday_class/hot03.png',
      },
      {
        'title': '금속 공예 체험 준비',
        'region': '서울시 광진구',
        'desc': '금속 공예를 체험하기 전 준비 과정입니다.',
        'price': '30,000원',
        'image': 'assets/images/oneday_class/hot04.png',
      },
    ],
    '공예': [],
    '섬유': [],
    '식문화': [
      {
        'title': '삼해주 만들기 1',
        'region': '서울시 용산구',
        'desc': '삼해주의 기초 제작 과정입니다.',
        'price': '40,000원',
        'image': 'assets/images/oneday_class/drink/drink01.png',
      },
      {
        'title': '한국 전통주의 발효 과정',
        'region': '서울시 서대문구',
        'desc': '한국 전통주의 발효 과정을 배웁니다.',
        'price': '16,000원',
        'image': 'assets/images/oneday_class/drink/drink02.png',
      },
      {
        'title': '송절주 만들기 1',
        'region': '서울시 노원구',
        'desc': '송절주의 기초 제작 과정입니다.',
        'price': '38,000원',
        'image': 'assets/images/oneday_class/drink/drink03.png',
      },
    ],
    '예술': [],
    '기타': [],
  };

  Map<String, List<Map<String, String>>> get classDataByCategory => _classDataByCategory;

  // 데이터 변경 메서드 예시
  void setClassDataByCategory(Map<String, List<Map<String, String>>> newData) {
    _classDataByCategory = newData;
    notifyListeners();
  }

  // 특정 카테고리 데이터만 변경
  void updateCategory(String category, List<Map<String, String>> data) {
    _classDataByCategory[category] = data;
    notifyListeners();
  }
}
