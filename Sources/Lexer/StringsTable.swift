import Foundation

public class StringsTable {
  
  private var table = [Int : String]()
  private var keyCount = -1
  
  init() {}
  
  @discardableResult
  func put(_ id: String) -> Int {
    let key = table.first { _, value in value == id }?.key
    
    if let key = key {
      return key
    } else {
      keyCount += 1
      let key = keyCount
      table[key] = id
      return key
    }
  }
  
}

extension StringsTable: CustomStringConvertible {
  
  public var description: String {
    return table.reduce(into: "") { (result, entry) in
      result.append("Key: \(entry.key) Value: \(entry.value)\n")
    }
  }
  
}
