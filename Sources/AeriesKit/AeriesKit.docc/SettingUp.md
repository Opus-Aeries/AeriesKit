# Setting Up AeriesKit

Set up AeriesKit in your own project

## Overview

To see the full documentation reference, check out ``AeriesKit``. This article will show you how to set up AeriesKit and make your first request.
>Tip: AeriesKit works best when you have one `ObservableObject` class that contains all business logic. It's better to keep a single connection to Aeries open that can be used to make all the necessary calls.

### Opening a Connection
Start by declaring an ``AeriesKit/AKConnection``. This requires some information. 

- `baseUrl:` This is the ``AKConfiguration/baseUrl`` of the aeries instance, generally unique to the school district.
- `token:` Every Aeries user has a long-lived access ``AKConfiguration/token`` that is automatically generated when they log in to an Aeries instance from the official mobile app.
- `studentId:` The user's own student ID that they use at their school.

Declare the `AeriesKit.connection` like so:
```swift
let aeries = AeriesKit.connection(
    configuration: .init(
        baseUrl: "https://example.aeries.net/",
        token: "abcdefgh123456",
        studentId: "123456"
    )
)
```

### Making a Request
Any request can be made by using an asynchronous call. For example, to process a request the following code could be used:
```swift
func requestHomeScreenData() async {
   await aeries.requestHomeScreenData { result in
       switch result {
       case .success(let success):
           print(success)
           DispatchQueue.main.async {
               // Assign Data
           }
       case .failure(let failure):
           print(failure)
           // Handle Error
       }
   }
}
```
