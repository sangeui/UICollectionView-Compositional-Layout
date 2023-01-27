# 🚧 UNDER CONSTRUCTION

### 최초 페이지
<img width="300" alt="Image-1" src="https://user-images.githubusercontent.com/34618339/214836532-86d4657c-5b61-4775-bb78-9fffa6ccfdb7.png">

### 그리드 레이아웃 페이지
<img width="300" alt="Image-2" src="https://user-images.githubusercontent.com/34618339/214837927-56e88244-9417-41cc-8141-44ff11b0ec31.png">

  ```swift
   // MARK: - 섹션 만들기
   func createSection() -> NSCollectionLayoutSection {
      let section = NSCollectionLayoutSection(group: self.createGroup())
      
      // ...
        
      return section
   }
   
   // MARK: - 그룹 만들기
   func createGroup() -> NSCollectionLayoutGroup {
      // 칼럼 개수
      let NUMBER_OF_COLUMNS = // 파라미터 또는 지역 변수 사용 등
      
      // 그룹 사이즈
      // - 너비는 섹션 너비만큼 차지, 높이는 섹션 너비를 칼럼 개수로 나눈 만큼을 차지
      // - 반대로 아이템은, 높이는 그룹 높이만큼 차지하되 너비를 그룹 너비를 칼럼 개수로 나눈 만큼을 차지
      // - 이렇게 정사각형의 아이템이 만들어질 수 있습니다.
      let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0 / NUMBER_OF_COLUMNS))
      
      // 그룹 정의
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, repeatingSubitem: self.createItem(), count: NUMBER_OF_COLUMNS)
      
      // ...
        
      return group
    }
   
   // MARK: - 아이템 만들기
   func createItem() -> NSCollectionLayoutItem {
      let NUMBER_OF_COLUMNS = // 파라미터 또는 지역 변수 사용 등
      
      // 아이템 사이즈
      let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / NUMBER_OF_COLUMNS), heightDimension: .fractionalHeight(1))
      
      // 아이템 정의
      let item = NSCollectionLayoutItem(layoutSize: size)
      
      // ...
      
      return item
   }
  ```
