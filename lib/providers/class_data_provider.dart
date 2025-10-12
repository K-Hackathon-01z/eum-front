import 'package:flutter/material.dart';
import '../models/oneday_class/class.dart';

class ClassDataProvider extends ChangeNotifier {
  Map<String, List<OnedayClass>> _classDataByCategory = {
    '인기': [
      OnedayClass(
        id: 1,
        skillId: 0,
        artisanId: 0,
        title: '나전칠기의 기원',
        photoUrl: 'assets/images/oneday_class/hot01.png',
        description: '나전칠기의 기원과 역사에 대한 강의입니다.',
        price: 13000,
        location: '서울시 종로구',
        capacity: 10,
        interestedCount: 0,
      ),
      OnedayClass(
        id: 2,
        skillId: 0,
        artisanId: 0,
        title: '전통 무용이란',
        photoUrl: 'assets/images/oneday_class/hot02.png',
        description: '전통 무용이 무엇인지 기원과 개념에 대해 학습합니다.',
        price: 18000,
        location: '서울시 동대문구',
        capacity: 10,
        interestedCount: 0,
      ),
      OnedayClass(
        id: 3,
        skillId: 0,
        artisanId: 0,
        title: '한국 장 담그기 종류',
        photoUrl: 'assets/images/oneday_class/hot03.png',
        description: '장의 종류와 그들의 특징에 대해 알아봅니다.',
        price: 13000,
        location: '서울시 송파구',
        capacity: 9,
        interestedCount: 0,
      ),
      OnedayClass(
        id: 4,
        skillId: 0,
        artisanId: 0,
        title: '금속 공예 체험 준비',
        photoUrl: 'assets/images/oneday_class/hot04.png',
        description: '금속 공예를 체험하기 전 준비 과정입니다.',
        price: 30000,
        location: '서울시 광진구',
        capacity: 8,
        interestedCount: 0,
      ),
    ],
    '공예': [],
    '섬유': [],
    '식문화': [
      OnedayClass(
        id: 5,
        skillId: 0,
        artisanId: 0,
        title: '삼해주 만들기 1',
        photoUrl: 'assets/images/oneday_class/drink/drink01.png',
        description: '삼해주의 기초 제작 과정입니다.',
        price: 40000,
        location: '서울시 용산구',
        capacity: 5,
        interestedCount: 0,
      ),
      OnedayClass(
        id: 6,
        skillId: 0,
        artisanId: 0,
        title: '한국 전통주의 발효 과정',
        photoUrl: 'assets/images/oneday_class/drink/drink02.png',
        description: '한국 전통주의 발효 과정을 배웁니다.',
        price: 16000,
        location: '서울시 서대문구',
        capacity: 10,
        interestedCount: 0,
      ),
      OnedayClass(
        id: 7,
        skillId: 0,
        artisanId: 0,
        title: '송절주 만들기 1',
        photoUrl: 'assets/images/oneday_class/drink/drink03.png',
        description: '송절주의 기초 제작 과정입니다.',
        price: 38000,
        location: '서울시 노원구',
        capacity: 5,
        interestedCount: 0,
      ),
    ],
    '예술': [],
    '기타': [
      OnedayClass(
        id: 100,
        skillId: 0,
        artisanId: 0,
        title: '홍염장 입문',
        photoUrl: 'assets/images/home/home04.png',
        description: '홍염장 입문',
        price: 25000,
        location: '',
        capacity: 0,
        interestedCount: 0,
      ),
      OnedayClass(
        id: 101,
        skillId: 0,
        artisanId: 0,
        title: '금속 공예 체험 준비',
        photoUrl: 'assets/images/home/home05.png',
        description: '금속 공예 체험 준비',
        price: 30000,
        location: '',
        capacity: 0,
        interestedCount: 0,
      ),
      OnedayClass(
        id: 102,
        skillId: 0,
        artisanId: 0,
        title: '도자기 기초 과정',
        photoUrl: 'assets/images/home/home06.png',
        description: '도자기 기초 과정',
        price: 41000,
        location: '',
        capacity: 0,
        interestedCount: 0,
      ),
    ],
  };

  Map<String, List<OnedayClass>> get classDataByCategory => _classDataByCategory;

  // 데이터 변경 메서드 예시
  void setClassDataByCategory(Map<String, List<OnedayClass>> newData) {
    _classDataByCategory = newData;
    notifyListeners();
  }

  // 특정 카테고리 데이터만 변경
  void updateCategory(String category, List<OnedayClass> data) {
    _classDataByCategory[category] = data;
    notifyListeners();
  }
}
