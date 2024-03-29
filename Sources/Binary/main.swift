import Foundation
import Lexer

let text = """
\n\t
()[],;
< <= > >= = <>
if then else while for
foo bar1 baz0z foo
0 01 11
0.1
2E1 2E+1 2E-1
0.2E1 0.2E+1 0.2E-1
"""

let path = Bundle.module.url(forResource: "text", withExtension: "txt")!.relativePath
let stream = LexerInputStream(path: path)
//let stream = LexerInputStream.standardInput
//let stream = LexerInputStream(string: text)

let lexer = Lexer(stream: stream)
print("Tokens:\n")
lexer.printTokens(to: &standardOutput)
print("\n\nStrings Table:\n")
print(lexer.stringsTable)
