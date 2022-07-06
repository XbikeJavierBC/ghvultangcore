import XCTest
import Combine
@testable import ghvultangcore

@available(iOS 13.0, *)
final class ghvultangcoreTests: XCTestCase {
    var expectation: XCTestExpectation?
    private var logRxStorage: GHPropertyLocalRepository?
    private var subscriber: AnyCancellable?
    
    override func setUp() async throws {
        try await super.setUp()
        
        self.logRxStorage = GHPropertyLocalRepository()
    }
    
    override func tearDown() {
        super.tearDown()
        self.logRxStorage = nil
        self.expectation = nil
    }
    
    func testExample() throws {
        self.expectation = expectation(description: "::: Foo :::")
        
        self.subscriber = self.logRxStorage?.foo()
            .sink(receiveCompletion: { completion in
            switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.expectation?.fulfill()
                    XCTFail("\n::: Error: \(error.localizedDescription)")
            }
        }) { applePark in
            XCTAssertTrue(applePark.streetAddress.isNotEmpty)
        }
        
        self.waitForExpectations(timeout: 3000.0, handler: nil)
    }
}
