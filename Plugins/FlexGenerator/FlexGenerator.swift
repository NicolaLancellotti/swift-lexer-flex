import PackagePlugin
import Foundation

/*
 It is not possible to use a build tool plugin because the current version of
 the Swift Package does not yet support non-Swift source files generation.
 */
@main
struct FlexGenerator: CommandPlugin {
  
  func performCommand(context: PluginContext, arguments: [String]) async throws {
    let targetDirectory = context.package.directory.appending(subpath: "Sources/FlexLexer")
    let lexerDefinitions = targetDirectory.appending("lexer_def.l").string
    let header = targetDirectory.appending("lex.yy.h").string
    let outputFile = targetDirectory.appending("lex.yy.c").string
    
    let flex = try context.tool(named: "flex")
    let flexExec = URL(fileURLWithPath: flex.path.string)
    let flexArgs = [
      "--header-file=\(header)",
      "--outfile=\(outputFile)",
      lexerDefinitions
    ]
    
    let process = try Process.run(flexExec, arguments: flexArgs)
    process.waitUntilExit()
    if process.terminationReason == .exit && process.terminationStatus == 0 {
      print("Flex files have been generated")
    } else {
      let problem = "\(process.terminationReason):\(process.terminationStatus)"
      Diagnostics.error("Flex files generation failed: \(problem)")
    }
  }
}
