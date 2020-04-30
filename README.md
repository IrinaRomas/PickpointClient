# PickpointClient

PickpointClient is a library written in Swift.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
let pick = PickpointClient(serviceProvider: CityBoxberryProvider())
       pick.get(completion: { result in
           print(result.count)
       }, failure: { error in
           print(error.localizedDescription)
       })
       
       
class CityBoxberryProvider: ServiceProvider {
           
    let path: String? = nil
           
    let isLogingEnabled: Bool = true
           
    typealias C = CitiBoxberry
           
    let endPoint: String = "http://api.boxberry.ru/json.php"
           
    let parameters = [
        "token":"your_token",
        "method":"ListCities"
    ]
}
```

## Requirements
iOS 9.3+
Xcode 11+
Swift 5.1+

## Installation

PickpointClient is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'PickpointClient'
```

## Author

IrinaRomas, romas.irina86@gmail.com

## License

PickpointClient is available under the MIT license. See the LICENSE file for more info.
