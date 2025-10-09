
# EUM Front

전통 기술과 장인, 원데이 클래스까지 한눈에! Flutter 기반 문화예술 커뮤니티 플랫폼

## 소개
EUM Front는 전통 공예, 예술, 식문화 등 다양한 분야의 장인과 기술을 소개하고, 원데이 클래스 예약 및 커뮤니티 기능을 제공하는 Flutter 기반 모바일/웹 프로젝트입니다.

## 주요 기능
- 장인/크리에이터 프로필 및 작품 소개
- 전통 기술 카테고리별 정보 제공
- 원데이 클래스 상세 정보 및 예약 기능
- 매칭 신청, 메시지 전송, 관심 등록 등 커뮤니티 기능
- 반응형 UI 및 모던 디자인

## 폴더 구조
```
lib/
	main.dart                # 앱 진입점
	models/                  # 데이터 모델 (creator, note, skill 등)
	providers/               # 상태 관리 Provider
	screens/                 # 주요 화면 (home, user, class 등)
	widgets/                 # 공통 UI 컴포넌트
assets/                    # 이미지, 아이콘 등 리소스
```

## 시작하기
1. Flutter 환경을 설치합니다 ([공식 문서](https://docs.flutter.dev/get-started/install))
2. 프로젝트 디렉터리에서 아래 명령어 실행:
	 ```bash
	 flutter pub get
	 flutter run
	 ```

## 기술 스택
- Flutter 3.x
- Provider (상태 관리)
- Dart
- AWS S3 (이미지 호스팅)
- RESTful API 연동

## 기여 방법
1. 이슈/기능 요청은 GitHub Issue로 등록해주세요
2. Pull Request는 `master` 브랜치 기준으로 작성해주세요
3. 코드 스타일 및 커밋 메시지 규칙을 준수해주세요

## 라이선스
MIT License

---
문의 및 제안: stargalaxy1579@gmail.com
