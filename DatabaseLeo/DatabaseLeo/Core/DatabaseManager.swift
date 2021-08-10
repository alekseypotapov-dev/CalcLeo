import Foundation

public enum DatabaseManagerError: Error, CustomStringConvertible {
    case fileNotFound
    case fileNotFoundInDocumentDirectory

    public var description: String {
        switch self {
        case .fileNotFound: return "File not found"
        case .fileNotFoundInDocumentDirectory: return "No such file"
        }
    }
}

public final class DatabaseManager {

    private let fileName: String
    private let fileExtension: String
    private let fileNameWithExtension: String
    private let bundlePath: String
    private lazy var filePath: String? = {
        guard let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return nil }
        return paths.appending("/\(fileNameWithExtension)")
    }()

    public init(fileName: String, fileExtension: String, bundlePath: String) {
        self.fileName = fileName
        self.fileExtension = fileExtension
        self.bundlePath = bundlePath
        self.fileNameWithExtension = "\(self.fileName).\(fileExtension)"
    }

    private func copyFileToDocumentDirectoryIfNeeded() throws {
        guard let filePath = filePath else {
            throw(DatabaseManagerError.fileNotFoundInDocumentDirectory)
        }

        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: filePath) {
            try fileManager.copyItem(atPath: bundlePath + "/" + fileNameWithExtension, toPath: filePath)
        }
    }

    public func readData() throws -> Data {
        try copyFileToDocumentDirectoryIfNeeded()

        let url = URL(fileURLWithPath: filePath!)
        let data = try Data(contentsOf: url)
        return data
    }

    public func writeData(_ data: Data) throws {
        try copyFileToDocumentDirectoryIfNeeded()

        let url = URL(fileURLWithPath: filePath!)
        try data.write(to: url)
    }
}
