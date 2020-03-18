import Foundation

public struct Token {
  public let kind: TokenKind
  public let attribute: String
}

extension Token: CustomStringConvertible {
  
  public var description: String {
    let name = String(cString: token_name(kind))
    
    switch kind {
      case .ID, .NCONST, .FCONST:
        return "〈\(name), \(attribute)〉"
      default: return "〈\(name)〉"
    }
  }
  
}
