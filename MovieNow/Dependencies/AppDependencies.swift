import Foundation

public protocol Dependencies: APIEngineInjectable { }

public class AppDependencies: Dependencies {
    public var apiEngine: APIEngineProtocol
    
    public init() {
        apiEngine = APIEngine()
    }
}
