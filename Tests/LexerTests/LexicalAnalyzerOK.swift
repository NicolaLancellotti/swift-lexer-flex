import XCTest
import Lexer

class LexicalAnalyzerOK: XCTestCase {
  
  func test_eof() {
    let text = ""
    let lexer = makeLexer(text: text)
    
    XCTAssert(lexer.nextToken().kind == .EOF)
    
    XCTAssert(lexer.nextToken().kind == .EOF)
  }
  
  func test_white() {
    let text = "\n\t <"
    let lexer = makeLexer(text: text)
    
    XCTAssert(lexer.nextToken().kind == .OP_REL_LT)
    
    XCTAssert(lexer.nextToken().kind == .EOF)
  }
  
  func test_operators() {
    let text = "<<==<>>>="
    let lexer = makeLexer(text: text)
    
    XCTAssert(lexer.nextToken().kind == .OP_REL_LT)
    XCTAssert(lexer.nextToken().kind == .OP_REL_LE)
    XCTAssert(lexer.nextToken().kind == .OP_REL_EQ)
    XCTAssert(lexer.nextToken().kind == .OP_REL_NE)
    XCTAssert(lexer.nextToken().kind == .OP_REL_GT)
    XCTAssert(lexer.nextToken().kind == .OP_REL_GE)
    
    XCTAssert(lexer.nextToken().kind == .EOF)
  }
  
  func test_id() {
    let text = "x xx x1"
    let lexer = makeLexer(text: text)
    
    XCTAssert(lexer.nextToken().kind == .ID)
    XCTAssert(lexer.nextToken().kind == .ID)
    
    XCTAssert(lexer.nextToken().kind == .ID)
  }
  
  func test_key() {
    let text = "if then else while for"
    let lexer = makeLexer(text: text)
    
    XCTAssert(lexer.nextToken().kind == .IF)
    XCTAssert(lexer.nextToken().kind == .THEN)
    XCTAssert(lexer.nextToken().kind == .ELSE)
    XCTAssert(lexer.nextToken().kind == .WHILE)
    XCTAssert(lexer.nextToken().kind == .FOR)
    
    XCTAssert(lexer.nextToken().kind == .EOF)
  }
  
  func test_separator() {
    let text = "()[],;"
    let lexer = makeLexer(text: text)
    
    XCTAssert(lexer.nextToken().kind == .L_PAREN)
    XCTAssert(lexer.nextToken().kind == .R_PAREN)
    XCTAssert(lexer.nextToken().kind == .L_SQUARE)
    XCTAssert(lexer.nextToken().kind == .R_SQUARE)
    XCTAssert(lexer.nextToken().kind == .COMMA)
    XCTAssert(lexer.nextToken().kind == .SEMI)
    
    XCTAssert(lexer.nextToken().kind == .EOF)
  }
  
  func test_nconst() {
    let text = "0 01 11"
    let lexer = makeLexer(text: text)
    
    do{
      let token = lexer.nextToken()
      XCTAssert(token.kind == .NCONST)
      XCTAssert(token.attribute == "0")
    }
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .NCONST)
      XCTAssert(token.attribute == "01")
    }
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .NCONST)
      XCTAssert(token.attribute == "11")
    }
    
    XCTAssert(lexer.nextToken().kind == .EOF)
  }
  
  func test_fconst() {
    let text = "0.1 2E1 2E+1 2E-1 0.2E1 0.2E+1 0.2E-1 0.2E-11"
    let lexer = makeLexer(text: text)
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .FCONST)
      XCTAssert(token.attribute == "0.1")
    }
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .FCONST)
      XCTAssert(token.attribute == "2E1")
    }
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .FCONST)
      XCTAssert(token.attribute == "2E+1")
    }
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .FCONST)
      XCTAssert(token.attribute == "2E-1")
    }
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .FCONST)
      XCTAssert(token.attribute == "0.2E1")
    }
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .FCONST)
      XCTAssert(token.attribute == "0.2E+1")
    }
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .FCONST)
      XCTAssert(token.attribute == "0.2E-1")
    }
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .FCONST)
      XCTAssert(token.attribute == "0.2E-11")
    }
    
    XCTAssert(lexer.nextToken().kind == .EOF)
  }
  
}
