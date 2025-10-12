import 'package:flutter/material.dart';
import '../models/oneday_class/class.dart';

class ClassDataProvider extends ChangeNotifier {
  // 금속 공예 1, 나전 칠기 2, 도자기 3, 매듭장 4, 칠장 5, 한지 6
  // 홍염장 7, 한복장 8, 자수 9, 매듭 10
  // 전통주 11, 장 12, 다과 13
  // 판소리 14, 민요 15, 탈춤 16, 무용 17
  // 단청장 18, 소목장 19
  List<OnedayClass> _onedayClassList = [
    OnedayClass(
      id: 1,
      skillId: 2,
      artisanId: 0,
      title: '나전칠기의 기원',
      photoUrl: 'assets/images/oneday_class/hot01.png',
      description: '나전칠기의 기원과 역사에 대한 강의입니다.',
      price: 13000,
      location: '서울시 종로구',
      capacity: 10,
      interestedCount: 12,
    ),
    OnedayClass(
      id: 2,
      skillId: 17,
      artisanId: 0,
      title: '전통 무용이란',
      photoUrl: 'assets/images/oneday_class/hot02.png',
      description: '전통 무용이 무엇인지 기원과 개념에 대해 학습합니다.',
      price: 18000,
      location: '서울시 동대문구',
      capacity: 10,
      interestedCount: 17,
    ),
    OnedayClass(
      id: 3,
      skillId: 12,
      artisanId: 0,
      title: '한국 장 담그기 종류',
      photoUrl: 'assets/images/oneday_class/hot03.png',
      description: '장의 종류와 그들의 특징에 대해 알아봅니다.',
      price: 13000,
      location: '서울시 송파구',
      capacity: 9,
      interestedCount: 8,
    ),
    OnedayClass(
      id: 4,
      skillId: 1,
      artisanId: 0,
      title: '금속 공예 체험 준비',
      photoUrl: 'assets/images/oneday_class/hot04.png',
      description: '금속 공예를 체험하기 전 준비 과정입니다.',
      price: 30000,
      location: '서울시 광진구',
      capacity: 8,
      interestedCount: 2,
    ),
    OnedayClass(
      id: 5,
      skillId: 11,
      artisanId: 0,
      title: '삼해주 만들기 1',
      photoUrl: 'assets/images/oneday_class/drink/drink01.png',
      description: '삼해주의 기초 제작 과정입니다.',
      price: 40000,
      location: '서울시 용산구',
      capacity: 5,
      interestedCount: 2,
    ),
    OnedayClass(
      id: 6,
      skillId: 11,
      artisanId: 0,
      title: '한국 전통주의 발효 과정',
      photoUrl: 'assets/images/oneday_class/drink/drink02.png',
      description: '한국 전통주의 발효 과정을 배웁니다.',
      price: 16000,
      location: '서울시 서대문구',
      capacity: 10,
      interestedCount: 2,
    ),
    OnedayClass(
      id: 7,
      skillId: 11,
      artisanId: 0,
      title: '송절주 만들기 1',
      photoUrl: 'assets/images/oneday_class/drink/drink03.png',
      description: '송절주의 기초 제작 과정입니다.',
      price: 38000,
      location: '서울시 노원구',
      capacity: 5,
      interestedCount: 1,
    ),
    OnedayClass(
      id: 100,
      skillId: 7,
      artisanId: 0,
      title: '홍염장 입문',
      photoUrl: 'assets/images/home/home04.png',
      description: '홍염장 입문',
      price: 25000,
      location: '',
      capacity: 9,
      interestedCount: 1,
    ),
    OnedayClass(
      id: 102,
      skillId: 3,
      artisanId: 0,
      title: '도자기 기초 과정',
      photoUrl: 'assets/images/home/home06.png',
      description: '도자기 기초 과정',
      price: 41000,
      location: '',
      capacity: 9,
      interestedCount: 2,
    ),
  ];

  List<OnedayClass> get onedayClassList => _onedayClassList;

  void setOnedayClassList(List<OnedayClass> newList) {
    _onedayClassList = newList;
    notifyListeners();
  }
}
