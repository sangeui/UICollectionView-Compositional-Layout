# ๐ง UNDER CONSTRUCTION

### ์ต์ด ํ์ด์ง
<img width="300" alt="Image-1" src="https://user-images.githubusercontent.com/34618339/214836532-86d4657c-5b61-4775-bb78-9fffa6ccfdb7.png">

### ๊ทธ๋ฆฌ๋ ๋ ์ด์์ ํ์ด์ง
<img width="300" alt="Image-2" src="https://user-images.githubusercontent.com/34618339/214837927-56e88244-9417-41cc-8141-44ff11b0ec31.png">

  ```swift
   // MARK: - ์น์ ๋ง๋ค๊ธฐ
   func createSection() -> NSCollectionLayoutSection {
      let section = NSCollectionLayoutSection(group: self.createGroup())
      
      // ...
        
      return section
   }
   
   // MARK: - ๊ทธ๋ฃน ๋ง๋ค๊ธฐ
   func createGroup() -> NSCollectionLayoutGroup {
      // ์นผ๋ผ ๊ฐ์
      let NUMBER_OF_COLUMNS = // ํ๋ผ๋ฏธํฐ ๋๋ ์ง์ญ ๋ณ์ ์ฌ์ฉ ๋ฑ
      
      // ๊ทธ๋ฃน ์ฌ์ด์ฆ
      // - ๋๋น๋ ์น์ ๋๋น๋งํผ ์ฐจ์ง, ๋์ด๋ ์น์ ๋๋น๋ฅผ ์นผ๋ผ ๊ฐ์๋ก ๋๋ ๋งํผ์ ์ฐจ์ง
      // - ๋ฐ๋๋ก ์์ดํ์, ๋์ด๋ ๊ทธ๋ฃน ๋์ด๋งํผ ์ฐจ์งํ๋ ๋๋น๋ฅผ ๊ทธ๋ฃน ๋๋น๋ฅผ ์นผ๋ผ ๊ฐ์๋ก ๋๋ ๋งํผ์ ์ฐจ์ง
      // - ์ด๋ ๊ฒ ์ ์ฌ๊ฐํ์ ์์ดํ์ด ๋ง๋ค์ด์ง ์ ์์ต๋๋ค.
      let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0 / NUMBER_OF_COLUMNS))
      
      // ๊ทธ๋ฃน ์ ์
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, repeatingSubitem: self.createItem(), count: NUMBER_OF_COLUMNS)
      
      // ...
        
      return group
    }
   
   // MARK: - ์์ดํ ๋ง๋ค๊ธฐ
   func createItem() -> NSCollectionLayoutItem {
      let NUMBER_OF_COLUMNS = // ํ๋ผ๋ฏธํฐ ๋๋ ์ง์ญ ๋ณ์ ์ฌ์ฉ ๋ฑ
      
      // ์์ดํ ์ฌ์ด์ฆ
      let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / NUMBER_OF_COLUMNS), heightDimension: .fractionalHeight(1))
      
      // ์์ดํ ์ ์
      let item = NSCollectionLayoutItem(layoutSize: size)
      
      // ...
      
      return item
   }
  ```
