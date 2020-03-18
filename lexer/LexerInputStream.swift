import Foundation

public class LexerInputStream {
  
  public private(set) var handle: UnsafeMutablePointer<FILE>
  
  public init(path: String) {
    handle = path.withCString { path in
      "r".withCString() { mode in
        fopen(path, mode)
      }
    }
  }
  
  public init(string: String) {
    handle = tmpfile()
    
    string.withCString { string in
      let _ = fputs(string, handle)
    }
    rewind(handle)
  }
  
  private init(handle: UnsafeMutablePointer<FILE>) {
    self.handle = handle
  }
  
  
  public static var standardInput: LexerInputStream {
    return LexerInputStream(handle: stdin)
  }
  
  deinit {
    if handle != stdin {
      fclose(handle)
    }
  }
}
