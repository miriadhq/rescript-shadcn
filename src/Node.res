module Fs = {
  @module("node:fs/promises") external readFile: (string, string) => promise<string> = "readFile"
  @module("node:fs/promises") external access: string => promise<unit> = "access"
  @module("node:fs") external existsSync: string => bool = "existsSync"
  @module("node:fs") external readFileSync: (string, string) => string = "readFileSync"
}

module Path = {
  @module("node:path") @variadic external join: array<string> => string = "join"
  @module("node:path") external extname: string => string = "extname"
}

@val @scope("process") external cwd: unit => string = "cwd"
