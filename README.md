# ๐ ์ผ๊ธฐ์ฅ

> ํ๋ก์ ํธ ๊ธฐ๊ฐ: 2022.06.13 ~ 2022.07.01 
> ํ์: [์ฐ๋กฑ์ฐจ](https://github.com/dnwhd0112), [Red](https://github.com/cherrishRed) ๋ฆฌ๋ทฐ์ด: [์จ๋](https://github.com/SungPyo)

## ํ๋ก์ ํธ ์๊ฐ 
๐ ์ผ๊ธฐ์ฅ
๋๋ง์ ์ผ๊ธฐ๋ฅผ ๋ง๋ค์ด ๋ณด์ธ์!
์ ์ฅ์ ๊น๋นกํ์จ๋ค๊ตฌ์? ๊ฑฑ์  ์์ต๋๋ค. 
์๋์ ์ฅ ๋ฉ๋๋ค!

## ํ์๋ผ์ธ
- [x] ์ฒซ์งธ์ฃผ : ํ๋ฉด๊ตฌ์ฑ, ํค๋ณด๋, Core Data CRUD ๊ตฌํ
- [x] ๋์งธ์ฃผ : Core Data๋ฅผ ์ด์ฉํ ๊ธฐ๋ฅ ๊ตฌํ, TableView ์ธ์ธํ ๋์๊ตฌํ, alert ๊ตฌํ 
- [x] ์์งธ์ฃผ : ๋คํธ์ํน์ ํตํ์ฌ ๋ ์จ์ ๋ณด ๋ฐ์์ค๊ธฐ ๋ฐ ์ด๋ฏธ์ง ์ฝ์


## ํ๋ก์ ํธ ๊ตฌ์กฐ

![](https://i.imgur.com/beEnYhe.png)

## ํ๋ก์ ํธ ์คํ ํ๋ฉด
![](https://i.imgur.com/5TaQh6j.gif)

## ๐ ํธ๋ฌ๋ธ ์ํ
### STEP1
* ํค๋ณด๋ ์ฌ๋ผ์ค๊ณ  ๋ด๋ ค๊ฐ๋๊ฑฐ์ ๋ฐ๋ฅธ View ๋ณ๊ฒฝ
* iOS ๋ฎ์ ๋ฒ์  ์๋ฎฌ๋ ์ดํฐ ์คํ

### ํค๋ณด๋ ์ฌ๋ผ์ค๊ณ  ๋ด๋ ค๊ฐ๋๊ฑฐ์ ๋ฐ๋ฅธ View ๋ณ๊ฒฝ
`๐ค๋ฌธ์ ` 
์๋ ์ฝ๋์ ๊ฐ์ด ํค๋ณด๋ ๊ด๋ จํ์ฌ ๋ ์ด์์์ ์ฃผ๋ฉด textFied ๋ textView ๊ฐ ํค๋ณด๋์ ๊ฐ๋ ค์ง์ง ์๊ฒ ์์์ bottom ๋ ์ด์์์ ์์ ํ๋ค.
```swift
textView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor).isActive = true
```
ํ์ง๋ง ์์ ๊ธฐ๋ฅ์ iOS 15๋ฒ์ ๋ถํฐ ์ง์ํ๊ธฐ ๋๋ฌธ์ ๋ฎ์ ๋ฒ์ ์์๋ ์คํ๋์ง ์์๋ค.

`๐ํด๊ฒฐ`
`if #available(iOS 15.0, *)`๋ฅผ ์ฌ์ฉํด์ iOS 15.0 ๋ณด๋ค ๋ฒ์ ์ด ๋ฎ๋ค๋ฉด, Notification์ ์ด์ฉํด ํค๋ณด๋๊ฐ ๋ํ๋  ๋, ๋ฉ์๋๋ฅผ ํตํด์ ์๋์ ์คํ ๋ ์ด์์์ ์ ์ฉํด ์ฃผ์๋ค.

```swift
textViewBottomConstraint = textView.bottomAnchor.constraint(
            equalTo: safeAreaLayoutGuide.bottomAnchor,
            constant: -height // ์ฌ๊ธฐ์ height ๋ ํค๋ณด๋์ ๋์ด
        )
```
์ด๋ ๊ธฐ์กด์ ์ ์ฉ๋ ์คํ ๋ ์ด์์์ ํด์ ํด์ค์ผ๋๊ธฐ ๋๋ฌธ์ ๋ณ์๋ก ๊ด๋ฆฌ๋ฅผ ํด์ผํ๋ค.

```swift
@objc private func keyBoardShow(notification: NSNotification) {
    guard let userInfo: NSDictionary = notification.userInfo as? NSDictionary else {
        return
    }
    guard let keyboardFrame = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else {
        return
    }
    let keyboardRectangle = keyboardFrame.cgRectValue
    let keyBoardHeight = keyboardRectangle.height
    detailView.changeTextViewHeight(keyBoardHeight)
}
```
ํค๋ณด๋์ ๋์ด๋ Notification ์ ์ด์ฉํ๋ฉด ์์ ์ฝ๋์ฒ๋ผ ๊ฐ์ ธ์ฌ ์ ์๋ค. 

### iOS ๋ฎ์ ๋ฒ์  ์๋ฎฌ๋ ์ดํฐ ์คํ
`๐ค๋ฌธ์ `
๋ฎ์ ๋ฒ์ ์ iOS ์๋ฎฌ๋ ์ดํฐ๋ฅผ ๋๋ฆด ์๊ฐ ์์๋ค.

`๐ํด๊ฒฐ`
![](https://i.imgur.com/UmDj211.png)
์์ชฝ ์๋ฎฌ๋ ์ดํฐ ์ ํํ๋ ์ฐฝ์์ Download Simulators ๋ฅผ ์ ํํ์ฌ ๋ฎ์ ๋ฒ์ ์ ์๋ฎฌ๋ ์ดํฐ๋ฅผ ์ค์นํ๋ฉด ๋๋ค. ํ์ง๋ง ๋น๋๋๋ ๋ฒ์ ์ ์ค์ ์ ๋ฐ๋ผ ์คํ์ด ๋์ง ์์์๋ ์์ผ๋ ์ฃผ์ํด์ผํ๋ค.


### STEP2
* Core Data Fetch ๋ฌธ์ 
* ViewModel ํ๋๋ฅผ ๋๊ฐ์ ViewController ๊ฐ ๋๋ ์ ์ฌ์ฉํด๋ ๋๋๊ฐ?

### Core Data Fetch ๋ฌธ์ 
`๐ค๋ฌธ์ `
![](https://i.imgur.com/5ItH8hw.png)
์ค๋ช : CoreData์์ fetch๋ก ๊ฐ์ ธ์จ ๋ฐ์ดํฐ ๋ฐฐ์ด์ ๋ฐ๋ก ์ ๊ทผํ ๋ ค๊ณ ํ ๋ ์๊ธฐ๋ ๋ฌธ์ .(๋ค๋ฅธ ํ๋ค์๋ ์ด๋ฌํ ๋ฌธ์ ๊ฐ ์์๋ค. ์ค๋ฅ๋ฌธ๋ Expected DiaryData but found DiaryData๋ก ์ด์ํ๋ค.)

์ด๋ฅผ ํด๊ฒฐํ๊ธฐ ์ํด `as [AnyObjcet]`์ผ๋ก ํ๋ณํ์ ์์ผฐ๋ค.


`๐ํด๊ฒฐ`

#### Core Data Fetch ๋ฌธ์  ํด๊ฒฐ

์ ์ฅํ ๋ NSManagedObject ํ์์ผ๋ก ์ ์ฅ์ ํ์๋๊ฒ ๋ฌธ์ ๊ฐ ๋์๋ค. ์ ์ฅํ ๋ ์ฌ์ฉํ  ๋ฐ์ดํฐ ๋ชจ๋ธ(DiaryData)๋ก ์ ์ฅํด์ผ ๋ฌธ์ ๊ฐ ์ผ์ด๋์ง ์๋๋ค. ๊ทธ๋์ ์ฐ๋ฆฌ๋ ๋ค์๊ณผ ๊ฐ์ด ์ ์ฅํ๋ ๋ก์ง์ ๋ณ๊ฒฝํ์ฟ๋ค. ์ดํ ์ฝ์ด์ฌ๋ `as [AnyObjcet]`๋ก ๋ณํํ์ง ์์๋ ์ค๋ฅ๊ฐ ๋์ง์์๋ค.
```swift=
guard let diaryData = NSEntityDescription.insertNewObject(
            forEntityName: DiaryInfo.entityName,
            into: context
        ) as? DiaryData else {
            throw CoreDataError.createError
        }
```


### ๋๊ฐ์ ViewController์ ํ๋์ ViewModel
`๐ค๋ฌธ์ `

`MainViewController` ์ `DetailVewController` ๊ฐ ์ฌ์ฉํ๋ ๋ฐ์ดํฐ๊ฐ (DiaryCoreData) ๋์ผํ๋ค๊ณ  ์๊ฐ ๋์ด์ `TableViewModel` ์์ ์ด๋ฅผ ๋ชจ๋ ์ฒ๋ฆฌ๋ฅผ ํด์ฃผ๊ณ  ์์๋ค. 
์ด๋ค ๋ฐฉ์์ผ๋ก ViewModel ์ ๋๋  ์ฌ์ฉํด์ผ ํ๋์ง์ ๊ดํ ๋ฌธ์ ๊ฐ ์์๋ค.

`1๏ธโฃ์ฒซ๋ฒ์งธ ๋ฐฉ๋ฒ`

`Delegateํจํด`์ ์ฌ์ฉํด์ `DetailViewController`๊ฐ `CoreData`๋ฅผ ๋ณ๊ฒฝํ ๋ `MainViewController`๊ฐ ์ฒ๋ฆฌํ๊ฒ ๋ ๊ตฌ์ฑ์ด๋ค.
(`ViewModel`์ด `MainViewController`์๋ง ์์ผ๋ฏ๋ก)

```swift 
extension MainViewController: UpdateDelegateable {
    func updatae(diaryInfo: DiaryInfo) {
        do {
            try viewModel.update(data: diaryInfo)
            try viewModel.loadData()
            mainView.reloadData()
        } catch {
            alertMaker.makeErrorAlert(error: error)
        }
    }
    
    func delete(diarInfo: DiaryInfo) {
        do {
            try viewModel.delete(data: diarInfo)
            try viewModel.loadData()
            mainView.reloadData()
        } catch {
            alertMaker.makeErrorAlert(error: error)
        }
    }
}

protocol UpdateDelegateable: UIViewController {
    func updatae(diaryInfo: DiaryInfo)
    func delete(diarInfo: DiaryInfo)
}

final class DetailViewController: UIViewController {
    ...
    weak var delegate: UpdateDelegateable?
    ...
}
```

DetailViewController ์์ ์ผ์ด๋ ์ฌ๊ฑด์ MainViewController ๋ฅผ ํตํด ์ฒ๋ฆฌํด์ผ ํ๋ค๋ ๊ตฌ์กฐ๊ฐ ์กฐ๊ธ์ ์ด์ํ๋ค.

`2๏ธโฃ๋๋ฒ์งธ ๋ฐฉ๋ฒ`
DetailViewController์ TableViewModel ํ๋กํผํฐ๋ฅผ ๊ฐ์ง๊ฒ ํ์ฌ, MainViewController ์ DetailVewController ๋ชจ๋ TableViewModel ์ ์ง์  ์ ๊ทผํ๋๋ก ํ๋ ๋ฐฉ๋ฒ 
```swift 
final class MainViewController: UIViewController {
    ...
    private var viewModel: TableViewModel<DiaryUseCase>
    ...
}

final class DetailViewController: UIViewController {
    ...
    private var viewModel: TableViewModel<DiaryUseCase>
    ...
}
```

`๐ํด๊ฒฐ`
๊ฒฐ๊ตญ ๋ค๋ฅธ ๋ทฐ๋ชจ๋ธ์ ๋ง๋ค์ด์ ์ฒ๋ฆฌํ์๋ค. ์ ์ค์ผ์ด์ค๋ ๊ฐ์ด ๋ง๋ค์ด์คฌ๋ค. ๋ถ๋ฆฌํ ์ด์ ๋ ๋ทฐ ๋ชจ๋ธ์์ ๋ธ๋ฆฌ๊ฒ์ดํธ ํจํด์ ์ฌ์ฉํ์ฌ ๋ทฐ์ปจ์์์ ๋์์ ๋ฐ๋๋ ๋๊ฐ์ ๋ทฐ์ปจ์ด ์ฌ์ฉ๋๋ฉด์ ํ๋์ ๋ทฐ๋ชจ๋ธ์์ ์ฒ๋ฆฌํ๊ธฐ ๊ณค๋ํด์ก๋ค. ๋ํ ๋๊ฐ๋ฅผ ์ฌ์ฉํ๊ธฐ์ ์ต์ ํ๊ฐ ๋ ๋์์๋ค. ์ด๋ฌํ ์ด์ ๋ก ๋ค๋ฅธ ๋ทฐ๋ชจ๋ธ์ ๋ง๋ค์ด์คฌ๋ค.


### ์ ์ฌํ ๋ก์ง์ ํต์ผ, ๋ถ๋ฆฌ 

`๐ค๋ฌธ์ `
delete ๋ฒํผ share ๋ฒํผ์ ๋๋ ์๋ ๋์ํ๋ ๋ฉ์๋๊ฐ mainViewController ์ DetailViewController ์์ ์ฌ์ฉ๋๊ณ  ์๋๋ฐ, ๋ ๋ก์ง์ด ์ ์ฌํ์ง๋ง ์ธ์ธํ ๋ถ๋ถ์ด ๋ค๋ฅด๋ค. 

data ๋ฅผ ์ญ์ ํ๊ณ , ๊ณต์ ํ๋ `handler` ๋ฅผ `MainViewController` ์ `DetailViewController` ์์ ๋ชจ๋ ์ฌ์ฉ์๋ค.

๊ฐ์ ๋ก์ง์ด์ง๋ง ์ฐจ์ด๋
์ด๋ค `controller` ์์ `TableViewModel` ์ ์ ๊ทผํ๋๋ ์ด๋ค.
์ด ๋ ๋ก์ง์ด ๊ฒน์น๋ ๋ถ๋ถ์ด ๋ง๋ค๊ณ  ์๊ฐ๋๋๋ฐ ๊ฐ์ ํด๋ก์ ๋ฅผ ๊ณต์ ํด์ ์ฌ์ฉํ  ์ ์๋ ๋ฐฉ๋ฒ์ด ์๋์ง ๊ถ๊ธํ๋ค. 

`๐ํด๊ฒฐ`
๊ฒฐ๊ตญ ๋ค๋ฅธ ๋ฉ์๋๋ผ ๊ทธ๋ฅ ๋ค๋ฅด๊ฒ ์ฒ๋ฆฌํด์คฌ๋ค.

### SceneDelegate, AppDelegate ํ์ฉ
`๐ค๋ฌธ์ `
์ดํ์ด ํํ๋ฉด์ผ๋ก ์ ํํ ๋ `DetailView` ํ๋ฉด์ data ๋ฅผ ์๋ ์ ์ฅ ํด์ฃผ๊ธฐ ์ํด `SceneDelegate` ์ ์๋ ํํ๋ฉด์ผ๋ก ์ ํ๋  ๋ ๋ถ๋ฆฌ๋ `sceneDidEnterBackground` ๋ฉ์๋๋ฅผ ์ด์ฉํ๋ค.

`1๏ธโฃ์ฒซ๋ฒ์งธ ๋ฐฉ๋ฒ`

`AppDelegate` ์์ `delegate` ํ๋กํผํฐ๋ฅผ ๊ฐ์ง๊ณ  `SceneDelegate`์์ ํธ์ถํ๋ ๋ฐฉ๋ฒ์ด๋ค. (`AppDelegate`๋ ์ ์ญ์ ์ผ๋ก ์ ๊ทผ์ด ๊ฐ๋ฅํจ์ผ๋ก). 
์ด ๋ฐฉ๋ฒ์ ์์ ํด์ผ ํ๋ ์ฌํญ์ด ๋ง๊ณ , AppDelegate๊ฐ delegate ํ๋กํผํฐ๋ฅผ ๊ฐ์ง๊ณ  ์์ด์ผ ํ๋ค๋ ๋จ์ ์ด ์๋ค. 

`2๏ธโฃ๋๋ฒ์งธ ๋ฐฉ๋ฒ`
๋๋ฒ์งธ ๋ฐฉ๋ฒ์ SceneDelegate์์ ๋ทฐ๋ฅผ ํ์ธํด์ ๋ฉ์๋๋ฅผ ์คํํ๋ ๋ฐฉ๋ฒ์ด๋ค. 
```swift=
func sceneDidEnterBackground(_ scene: UIScene) {
((self.window?.rootViewController as? UINavigationController)?.topViewController as? DetailViewController)?.saveData()
}
```

`๐ํด๊ฒฐ`
์ฒซ๋ฒ์งธ ๋ฐฉ๋ฒ์ ์ ํํ์ฌ ์์ฑํ์๋ค. ๋๋ฒ์งธ ๋ฐฉ๋ฒ์ ๊ฒฐ๊ตญ TopView๋ฅผ ๊ฐ์ ธ์์ผ ์ฒ๋ฆฌ๋ฅผ ํ  ์ ์๋ค. ํ์ง๋ง TopView๋ฅผ ์ ๋๋ก ๊ฐ์ ธ์ฌ๋ ค๋ฉด ๋ถ๊ธฐ์ฒ๋ฆฌ๋ฅผ ํด์ค์ผํ๋ค. ํ์ง๋ง ์ฐ๋ฆฌ๋ ๊ผผ๊ผผํ ๋ถ๊ธฐ์ฒ๋ฆฌ๋ฅผ ํ์ง์๊ณ  ์ฒซ๋ฒ์งธ ๋ฐฉ๋ฒ์ ์ ํํ๊ธฐ๋ก ํ๋ค.

### STEP3
* Rx ์์ด MVVM ๊ตฌ์กฐ
* Result ํ์์ผ๋ก ๋ณ๊ฒฝ 
* UseCase 


#### Rx ์์ด MVVM ๊ตฌ์กฐ
`๐ค๋ฌธ์ `
์ฒ์์๋ MVVM ํจํด์ ์ต์ํ์ง ์์์ MVC ์ฒ๋ผ
MVVM ๊ตฌ์กฐ๋ฅผ ViewController ๊ฐ ViewModel ์ ํ๋กํผํฐ๋ฅผ ์ง์  ์ ๊ทผํด์ ํธ์ถํ๊ณ  ์์ ํ๋ ๋ฐฉํฅ์ผ๋ก ์์ฑํ์๋ค.
(ํ๋ผ๋ฏธํฐ๋ก ํธ๋ค๋ฌ๋ฅผ ๋ฐ์์ ํธ๋ค๋ฌ๋ฅผ ViewController ์์ ํธ์ถํ๋๋ก ์์ ํ์๋ค.)

`๐ํด๊ฒฐ`
delegate๋ก Handler ๋ค์ ์์ฑํด ์ฃผ์ด์ Handler ๋ฅผ ํธ์ถํ๋ ์ฃผ์ฒด๊ฐ ViewController ๊ฐ ์๋ ViewModel ์ด ๋๊ฒ ํ์๋ค.

# MVVM ์ ์ฐ๋ฉด์...

## ํด๋ฆฐ ์ํคํ์ฒ๋ฅผ ์ฐธ๊ณ 
๊ณ์ธต ๋ณ๋ก ๊ธฐ๋ฅ์ ๋๋๊ณ  ์ถํ ์ฝ๋๋ฅผ ์์ฑํ ๋ ์ด๋ค ๊ตฌ์กฐ๋ก ๊ตฌ์ฑํด์ผ๋ ์ง ๋ง์ ๋์์ด ๋๊ฑฐ๊ฐ๋ค. 
์ฐ๋ฆฌ MVVM ๊ตฌ์กฐ์์ ์ ํ ๊ท์น์ด ์๋ค.
1. ๋ทฐ๋ชจ๋ธ์์  ๋ทฐ์ ๊ด๋ จ๋ ์ฝ๋๋ฅผ ์ฐ์ง์๋๋ค.(UIKit ์ ์ํฌํธํ์ง์๋๋ค.)
2. ๋ทฐ๋ชจ๋ธ์ ์ ๊ทผํ ๋ ์ธํฐํ์ด์ค๋ฅผ ์ ํด์ ๋ด๋ถ ํจ์๊ฐ ๋๋ฌ๋์ง ์๊ฒํ๋ค.
3. ๋ทฐ - ๋ทฐ๋ชจ๋ธ - ์ ์ค์ผ์ด์ค ์ ์ญํ ์ ์ฌ๋ฐ๋ฅด๊ฒ ๋ถ๋ฆฌํ๋ค. 

## Result ํ์์ผ๋ก ๋ณ๊ฒฝ
`๐ค๋ฌธ์ `
CRUD ๋ฉ์๋๋ฅผ throws ๋ก ์์ฑํ๋๋ฐ ๋ฆฌ๋ทฐ์ด๊ป์ try catch ๋ฅผ ์ฌ์ฉํ์ง ์๋ ๋ฐฉ๋ฒ์ผ๋ก ์์ ํด ๋ณด๋ ๊ฒ์ด ์ด๋ป๊ฒ ๋๋ ์ด์ผ๊ธฐ ํด์ฃผ์จ๋ค.

`๐ํด๊ฒฐ`
Result ํ์์ ์ฌ์ฉํด์ Success ์ Failure ํ ๊ฐ์ฒด๋ฅผ ๋ฐ๋๋ก ์ค์ ํ๋ค.

## โ๏ธ ํ์ต๋ด์ฉ
* CoreData
* KeyBoard
* ActionSheet 
* ActivityVeiw
* TableView Cell ์ญ์ , ์ถ๊ฐ 
* TableView Swipe
