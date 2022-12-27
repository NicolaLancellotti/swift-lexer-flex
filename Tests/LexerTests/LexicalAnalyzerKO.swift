import Foundation

import XCTest
@testable import Lexer

class LexicalAnalyzerKO: XCTestCase {
  
  func test_error() {
    let text = "|"
    let lexer = makeLexer(text: text)
    
    XCTAssert(lexer.nextToken().kind == .ERROR)
  }
  
  func test_number_error1() {
    // state 14
    let text = "1."
    let lexer = makeLexer(text: text)
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .NCONST)
      XCTAssert(token.attribute == "1")
    }
    
    XCTAssert(lexer.nextToken().kind == .ERROR)
  }
  
  func test_number_error2() {
    let text = "1E"
    let lexer = makeLexer(text: text)
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .NCONST)
      XCTAssert(token.attribute == "1")
    }
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .ID)
    }
  }
  
  func test_number_error3() {
    let text = "1E+"
    let lexer = makeLexer(text: text)
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .NCONST)
      XCTAssert(token.attribute == "1")
    }
    
    do {
      let token = lexer.nextToken()
      XCTAssert(token.kind == .ID)
    }
    
    XCTAssert(lexer.nextToken().kind == .ERROR)
  }
  
  func test_assign_error() {
    let text = "<-"
    let lexer = makeLexer(text: text)
    
    XCTAssert(lexer.nextToken().kind == .OP_REL_LT)
    
    XCTAssert(lexer.nextToken().kind == .ERROR)
  }
  
}
