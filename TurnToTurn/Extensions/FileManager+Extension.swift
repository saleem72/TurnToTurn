//
//  FileManager+Extension.swift
//  NavigationInstructionsApp
//
//  Created by Yousef on 5/10/22.
//✮

import Foundation

extension FileManager {
    
    enum SaveLocationsError: Error, LocalizedError {
        case encodError
        case writingError
        case decodeError
        case readError
        
        var errorDescription: String? {
            switch self {
            case .encodError: return NSLocalizedString("Couldn't encode array", comment: "")
            case .writingError: return NSLocalizedString("Couldn't write data to device", comment: "")
            case .decodeError: return NSLocalizedString("Couldn't decode data", comment: "")
            case .readError: return NSLocalizedString("Couldn't read data to device", comment: "")
            }
        }
    }
    
    static var docDirURL: URL {
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func saveDocument(contents: String, docName: String, completion: (Error?) -> Void) {
        let url = Self.docDirURL.appendingPathComponent(docName)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    func readDocument(docName: String, completion: (Result<Data, Error>) -> Void) {
        let url = Self.docDirURL.appendingPathComponent(docName)
        do {
            let data = try Data(contentsOf: url)
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }
    
    func docExist(named docName: String) -> Bool {
        fileExists(atPath: Self.docDirURL.appendingPathComponent(docName).path)
    }
    
}
