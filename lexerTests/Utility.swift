import Foundation
import lexer

func makeLexer(text: String) -> Lexer {
  let stream = LexerInputStream(string: text)
  return Lexer(stream: stream)
}
