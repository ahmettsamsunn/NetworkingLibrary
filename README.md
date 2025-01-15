# NetworkingLibrary

A lightweight, protocol-oriented networking library for iOS applications. This library provides a clean and flexible way to make network requests with type-safe responses.

## Inspiration

    https://medium.com/getir/writing-a-modern-ios-networking-library-with-swift-concurrency-bb1cdbf12725

## Features

- Protocol-oriented design
- Async/await support
- Customizable request adapters
- Type-safe response parsing
- Modular and extensible architecture
- iOS 13+ support


## Usage

### Basic Request

```swift
// Define your request
struct UserRequest: NetworkRequestable {
    var baseURL: String { "https://api.example.com" }
    var method: HTTPMethod { .get }
    var path: String { "/users" }
}

// Define your response model
struct User: Decodable {
    let id: Int
    let name: String
}

// Make the request
let networking = Networking()
let result = await networking.executeRequest(
    request: UserRequest(),
    responseType: User.self
)

switch result {
case .success(let response):
    print("User: \(response.data)")
case .failure(let error):
    print("Error: \(error)")
}
```

### Custom Request Adapters

```swift
class AuthenticationAdapter: RequestAdaptation {
    func adapt(request: URLRequest) -> URLRequest {
        var request = request
        request.addValue("Bearer YOUR_TOKEN", forHTTPHeaderField: "Authorization")
        return request
    }
}

let networking = Networking(
    requestAdapters: [AuthenticationAdapter()]
)
```

## Requirements

- iOS 13.0+
- Swift 6.0+

