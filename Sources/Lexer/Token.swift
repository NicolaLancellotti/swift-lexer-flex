import Foundation
import FlexLexer

public struct Token {
  public let kind: FlexLexer.TokenKind
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
