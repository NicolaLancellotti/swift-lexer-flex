import Foundation
import FlexLexer

public class Lexer {
  
  static private var stream: LexerInputStream?
  
  public init(stream:  LexerInputStream) {
    precondition(Lexer.stream == nil)
    Lexer.stream = stream
    FlexLexer.yyrestart(stream.handle)
    self.stringsTable = StringsTable()
  }
  
  public var stringsTable = StringsTable()
  
  public func printTokens<Target: TextOutputStream>(to output: inout Target) {
  loop: while true {
    let token = nextToken()
    print(token, separator: "", terminator: "\n", to: &output)
    if token.kind == .EOF || token.kind == .ERROR {
      break loop
    }
  }
  }
  
  public func nextToken() -> Token {
    let kind = TokenKind(rawValue: UInt(yylex()))!
    var attribute = String(cString: yytext)
    if kind == .ID {
      attribute = String(stringsTable.put(attribute))
    }
    return Token(kind: kind, attribute: attribute)
  }
  
  deinit {
    Lexer.stream = nil
  }
  
}
