import Foundation
import PythonKit

public struct ErrorWithDescription: LocalizedError, CustomStringConvertible {

    private let message: String

    public init(_ message: String) {
        self.message = message
    }
    
    public var description: String { message }
    
    public var errorDescription: String? { message }
}

let sys = Python.import("sys")

actor PythonScriptGetter {
    
    private var pythonScript: PythonObject? = nil
    
    func get(pythonScripts: String, pythonModule: String) async throws -> PythonObject {
        if let pythonScript = pythonScript {
            return pythonScript
        }
        else {
            do {
                sys.path.append(pythonScripts)
                let script = try Python.attemptImport(pythonModule)
                pythonScript = script
                return script
            }
            catch {
                let errorMessage = "could not load python module \"\(pythonModule)\" from [\(pythonScripts)]: \(error.localizedDescription)"
                throw ErrorWithDescription(errorMessage)
            }
        }
    }
}

let pythonScriptGetter = PythonScriptGetter()

func work(on text: String, pythonScripts: String, pythonModule: String) async throws -> String {
    let script = try await pythonScriptGetter.get(pythonScripts: pythonScripts, pythonModule: pythonModule)
    let changedText = String(script.replaceAllAs(text))!
    return changedText
}

@main
struct Main {
    
    static func main() async throws {
        guard CommandLine.arguments.count == 3 else {
            print("Arguments: <path to directory with Python scripts> <base name of Python script>.")
            return
        }
        let pythonScripts = CommandLine.arguments[1]
        let pythonModule = CommandLine.arguments[2]
        do {
            let changedText = try await work(on: "Aha", pythonScripts: pythonScripts, pythonModule: pythonModule)
            print(changedText)
        }
        catch {
            print("\(type(of: error)): \(error.localizedDescription)")
        }
        
    }
}
