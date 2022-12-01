import Foundation
import AeriesKit

@main
struct AeriesKitExec {

    static func main() async {
        let aeries = AeriesKit.connection(
            configuration: .init(
                baseUrl: "https://example.aeries.net/",
                token: "abcdefgh123456",
                studentId: "123456"
            )
        )

        await aeries.requestHomeScreenData { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }

}
