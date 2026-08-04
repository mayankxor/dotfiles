local parse = require("luasnip.util.parser").parse_snippet

local function has_stdlib()
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    if line:match("^%s*#include%s*<stdlib%.h>%s*$") then
      return true
    end
  end
  return false
end

local function trim(value)
  return (value:gsub("^%s+", ""):gsub("%s+$", ""))
end

-- Split only on top-level commas. This keeps commas inside function-pointer
-- parameters, array expressions, and quoted strings intact.
local function split_arguments(signature)
  local arguments = {}
  local current = {}
  local depth = 0
  local quote = nil
  local escaped = false

  local function push_argument()
    local argument = trim(table.concat(current)):gsub("%s+", " ")
    if argument ~= "" then
      table.insert(arguments, argument)
    end
    current = {}
  end

  for position = 1, #signature do
    local character = signature:sub(position, position)

    if quote then
      table.insert(current, character)
      if escaped then
        escaped = false
      elseif character == "\\" then
        escaped = true
      elseif character == quote then
        quote = nil
      end
    elseif character == "\"" or character == "'" then
      quote = character
      table.insert(current, character)
    elseif character == "(" or character == "[" or character == "{" then
      depth = depth + 1
      table.insert(current, character)
    elseif character == ")" or character == "]" or character == "}" then
      depth = math.max(0, depth - 1)
      table.insert(current, character)
    elseif character == "," and depth == 0 then
      push_argument()
    else
      table.insert(current, character)
    end
  end

  push_argument()

  if #arguments == 1 and arguments[1] == "void" then
    return {}
  end

  return arguments
end

local function documentation(args)
  local return_type = trim(table.concat(args[1], "\n")):gsub("%s+", " ")
  local parameters = split_arguments(table.concat(args[2], "\n"))
  local nodes = {
    t({ "/**", " * @brief " }),
    r(1, "docfunc_brief", i(nil, "")),
  }
  local jump_index = 2

  for parameter_index, parameter in ipairs(parameters) do
    table.insert(nodes, t({ "", " * @param " .. parameter .. " " }))
    table.insert(
      nodes,
      r(jump_index, "docfunc_param_" .. parameter_index, i(nil, ""))
    )
    jump_index = jump_index + 1
  end

  table.insert(nodes, t({ "", " * @return " .. return_type .. " " }))
  table.insert(nodes, r(jump_index, "docfunc_return", i(nil, "")))
  table.insert(nodes, t({ "", " */", "" }))

  return sn(nil, nodes)
end


return {
  parse({
    trig = "//",
    name = "Multiline comment",
    dscr = "Convenient multiline comment",
    wordTrig = false,
  }, "/* $1 */$0"),
  parse({
      trig = "st",
      name = "Starter Template",
      dscr = "Standard starter template for a tiny C program",
    },
    "#include <stdbool.h>\n#include <stdio.h>\n#include <stdlib.h>\n\nint main(int argc, char *argv[])\n{\n\t$0\n\treturn EXIT_SUCCESS;\n}"),
  parse({
      trig = "#st",
      name = "Preprocessor Starter Template",
      dscr = "Preprocessor starter template for a C project",
    },
    "#include <assert.h>\n#include <errno.h>\n#include <stdbool.h>\n#include <stddef.h>\n#include <stdint.h>\n#include <stdio.h>\n#include <stdlib.h>\n$0"),
  s({
    trig = "docfunc",
    name = "Documented function",
    dscr = "C function with documentation generated from its signature",
  }, {
    d(5, documentation, { 1, 3 }),
    i(1, "return_type"),
    t(" "),
    i(2, "function_name"),
    t("("),
    i(3, "args"),
    t({ ")", "{", "\t" }),
    i(4, "/* code */"),
    t({ "", "}", "" }),
    i(0),
  }),
  s(
    { trig = "main", name = "main() template", desc = "Standard main() template" },
    fmt([[
int main(int argc, char *argv[])
{{
    {}
    return EXIT_SUCCESS;
}}
]], {
      i(0),
    }),
    {
      condition = has_stdlib,
      show_condition = has_stdlib,
    }
  ),


  s(
    { trig = "main", name = "main() template", desc = "Standard main() template" },
    fmt([[
int main(int argc, char *argv[])
{{
    {}
    return 0;
}}
]], {
      i(0),
    }),
    {
      condition = function() return not has_stdlib() end,
      show_condition = function() return not has_stdlib() end
    }
  ),

  s(
    { trig = "mainn", name = "main(void) template", desc = "no-args main() snippet" },
    fmt([[
int main(void)
{{
    {}
    return EXIT_SUCCESS;
}}
]], {
      i(0),
    }),
    {
      condition = has_stdlib,
      show_condition = has_stdlib,
    }
  ),


  s(
    { trig = "mainn", name = "main(void) template", desc = "no-args main() snippet" },
    fmt([[
int main(void)
{{
    {}
    return 0;
}}
]], {
      i(0),
    }),
    {
      condition = function() return not has_stdlib() end,
      show_condition = function() return not has_stdlib() end
    }
  ),
  parse({
    trig = "#inc",
    name = "#include <...>",
    dscr = "#include <...> snippet",
  }, "#include <$1>$0"),
  parse({
    trig = "#incl",
    name = "#include \"...\"",
    dscr = "#include \"...\" snippet",
  }, "#include \"$1\"$0"),
  parse({
    trig = "#def",
    name = "#define macro",
    dscr = "Textual macro snippet",
  }, "#define ${1:MACRO}"),
  parse({
    trig = "#deff",
    name = "#define macro()",
    dscr = "Function-like macro snippet",
  }, "#define ${1:MACRO}($2) ($3)"),
  parse({
    trig = "#gnu",
    name = "_GNU_SOURCE",
    dscr = "Enable GNU extensions (functions)",
  }, "#define _GNU_SOURCE"),
  parse({
    trig = "#if",
    name = "#if",
    dscr = "#if snippet",
  }, "#if ${1:0}\n$2\n#endif /* if $1 */\n$0"),
  parse({
    trig = "#ifdef",
    name = "#ifdef",
    dscr = "#ifdef snippet",
  }, "#ifdef ${1:MACRO}\n$2\n#endif /* ifdef $1 */\n$0"),
  parse({
    trig = "#ifndef",
    name = "#ifndef",
    dscr = "#ifndef snippet",
  }, "#ifndef ${1:MACRO}\n$2\n#endif /* ifndef $1 */\n$0"),
  parse({
    trig = "#once",
    name = "include once",
    dscr = "Header include guard",
  }, "#ifndef ${1:FILE}_H\n#define $1_H\n$2\n#endif /* end of include guard: $1_H */\n$0"),
  parse({
    trig = "#nocpp",
    name = "extern C",
    dscr = "Disable C++ name mangling in C headers",
  }, "#ifdef __cplusplus\nextern \"C\" {\n#endif\n$1\n\n#ifdef __cplusplus\n} /* extern \"C\" */\n#endif\n$0"),
  parse({
    trig = "#err",
    name = "#error",
    dscr = "#error snippet",
  }, "#error \"$1\"\n$0"),
  parse({
    trig = "#warn",
    name = "#warning",
    dscr = "#warning snippet",
  }, "#warning \"$1\"\n$0"),
  parse({
    trig = "if",
    name = "if",
    dscr = "'if' snippet",
  }, "if (${1:condition}) {\n\t$2\n}\n$0"),
  parse({
    trig = "ifelse",
    name = "if else",
    dscr = "'if' with 'else'",
  }, "if (${1:condition}) {\n\t$2\n} else {\n\t$3\n}\n$0"),
  parse({
    trig = "else",
    name = "else",
    dscr = "'else' snippet",
  }, "else {\n\t$1\n}\n$0"),
  parse({
    trig = "elseif",
    name = "else if",
    dscr = "else-if snippet",
  }, "else if (${1:condition}) {\n\t$2\n}\n$0"),
  parse({
    trig = "ifi",
    name = "if 1L",
    dscr = "1-line-if",
  }, "if (${1:condition}) $2;\n$0"),
  parse({
    trig = "elseifi",
    name = "elif 1L",
    dscr = "1-line-else-if",
  }, "else if (${1:condition}) $2;\n$0"),
  parse({
    trig = "switch",
    name = "switch",
    dscr = "'switch' snippet",
  }, "switch (${1:expression}) {\n\t$0\n}"),
  parse({
    trig = "case",
    name = "case",
    dscr = "'case' branch",
  }, "case ${1:0}:$2;\n$0"),
  parse({
    trig = "default",
    name = "default",
    dscr = "'default' branch",
  }, "default:$1;\n$0"),
  parse({
    trig = "while",
    name = "while",
    dscr = "'while' loop snippet",
  }, "while (${1:condition}) {\n\t$2\n}\n$0"),
  parse({
    trig = "do",
    name = "do...while",
    dscr = "do...while loop snippet",
  }, "do {\n\t$2\n} while (${1:condition});\n$0"),
  parse({
    trig = "return",
    name = "return",
    dscr = "'return' snippet",
  }, "return ${1:0};\n$0"),
  parse({
    trig = "exit",
    name = "exit",
    dscr = "exit() snippet",
  }, "exit(${1:EXIT_FAILURE});\n$0"),
  parse({
    trig = "for",
    name = "for",
    dscr = "Generic 'for' loop",
  }, "for ($1;$2;$3) {\n\t$4\n}\n$0"),
  parse({
    trig = "forc",
    name = "for count",
    dscr = "'for' loop focusing on iteration times",
  }, "for (${1:size_t} ${2:i} = ${3:0}; $2 < ${4:count}; $2${5:++}) {\n\t$6\n}\n$0"),
  parse({
    trig = "forg",
    name = "for range",
    dscr = "'for' loop focusing on inclusive range",
  }, "for (${1:size_t} ${2:i} = ${3:1}; $2 <= ${4:last}; $2${5:++}) {\n\t$6\n}\n$0"),
  parse({
    trig = "fora",
    name = "for argv[]",
    dscr = "'for' loop for cmdline arguments",
  }, "for (int ${1:i} = ${2:1}; $1 < argc; $1++) {\n\t$3\n}\n$0"),
  parse({
    trig = "fun",
    name = "Function ...",
    dscr = "Make a function declaration/definition/pointer",
  }, "${2:void} ${1:fun}(${3:void});\n$0"),
  parse({
    trig = "func",
    name = "Function definition",
    dscr = "Define a function",
  }, "${2:void} ${1:fun}(${3:void}){\n\t$0\n}"),
  parse({
    trig = "typedef",
    name = "typedef",
    dscr = "'typedef' snippet",
  }, "typedef ${1:void} ${2:Emptiness};"),
  parse({
    trig = "typedeff",
    name = "Complicated typedef",
    dscr = "Declaration-like typedef for func-ptr,array,etc.",
  }, "typedef $1;$0"),
  parse({
    trig = "typedefst",
    name = "typedef struct",
    dscr = "Implicit struct typedef",
  }, "typedef struct $1 ${1:Box};$0"),
  parse({
    trig = "typedefun",
    name = "typedef union",
    dscr = "Implicit union typedef",
  }, "typedef union $1 ${1:Cell};$0"),
  parse({
    trig = "struct",
    name = "struct",
    dscr = "'struct' snippet",
  }, "struct ${1:MyStruct} {\n\t$2\n}$3;\n$0"),
  parse({
    trig = "typestruct",
    name = "struct type",
    dscr = "Define a type with struct",
  }, "typedef struct $1 ${1:Box};\nstruct $1 {\n\t$2\n};\n$0"),
  parse({
    trig = "union",
    name = "union",
    dscr = "'union' snippet",
  }, "union ${1:MyUnion} {$0\n};"),
  parse({
    trig = "typeunion",
    name = "union type",
    dscr = "Define a type with union",
  }, "typedef union $1 ${1:Cell};\nunion $1 {$0\n};"),
  parse({
    trig = "enum",
    name = "enum",
    dscr = "Define an enumeration",
  }, "enum $1{ $0 };"),
  parse({
    trig = "puts",
    name = "puts",
    dscr = "puts() snippet",
  }, "puts(\"${1:This function doesn't need newline.}\");$0"),
  parse({
    trig = "fputs",
    name = "fputs",
    dscr = "puts() snippet",
  }, "fputs(\"${2:This is a simpler printf.\\n}\", ${1:stdout});$0"),
  parse({
    trig = "printf",
    name = "printf",
    dscr = "printf() snippet",
  }, "printf(\"${1:%s}\\n\"$2);$0"),
  parse({
    trig = "fprintf",
    name = "fprintf",
    dscr = "fprintf() snippet",
  }, "fprintf(${1:stderr}, \"${2:%s}\\n\"$3);$0"),
  parse({
    trig = "sprintf",
    name = "sprintf",
    dscr = "sprintf() snippet",
  }, "sprintf(${1:buf}, \"${2:%s}\\n\"$3);$0"),
  parse({
    trig = "snprintf",
    name = "snprintf",
    dscr = "snprintf() snippet",
  }, "snprintf(${1:buf}, ${2:max}, \"${3:%s}\\n\"$3);$0"),
  parse({
    trig = "scanf",
    name = "scanf",
    dscr = "scanf() snippet",
  }, "scanf(\"${1:%d}\"$2);$0"),
  parse({
    trig = "fscanf",
    name = "fscanf",
    dscr = "fscanf() snippet",
  }, "fscanf(${1:stdin}, \"${2:%d}\"$3);$0"),
  parse({
    trig = "sscanf",
    name = "sscanf",
    dscr = "sscanf() snippet",
  }, "sscanf(${1:buf}, \"${2:%d}\"$3);$0"),
  parse({
    trig = "malloc",
    name = "malloc",
    dscr = "malloc() snippet",
  }, "malloc(sizeof(${1:int[69]})$2);$0"),
  parse({
    trig = "calloc",
    name = "calloc",
    dscr = "calloc() snippet",
  }, "calloc(${1:1}, sizeof(${2:int})$3);$0"),
  parse({
    trig = "realloc",
    name = "realloc",
    dscr = "realloc() snippet",
  }, "realloc(${1:ptr}, sizeof(${2:int[69]})$3);$0"),
  parse({
    trig = "reallocarray",
    name = "reallocarray",
    dscr = "reallocarray() snippet",
  }, "reallocarray(${1:ptr}, ${2:69}, sizeof(${3:int})$4);$0"),
  parse({
    trig = "free",
    name = "free",
    dscr = "free() snippet",
  }, "free(${1:NULL});"),
  parse({
    trig = "assert",
    name = "assert",
    dscr = "assert() snippet",
  }, "assert($0);"),
  parse({
    trig = "static_assert",
    name = "static_assert",
    dscr = "static_assert() snippet",
  }, "static_assert(${1:false}, \"${2:Oopsie}\");"),
  parse({
    trig = "err",
    name = "err",
    dscr = "err() snippet",
  }, "err(${1:EXIT_FAILURE}, \"${2:%s}\"$0);"),
  parse({
    trig = "errx",
    name = "errx",
    dscr = "errx() snippet",
  }, "errx(${1:EXIT_FAILURE}, \"${2:%s}\"$0);"),
  parse({
    trig = "warn",
    name = "warn",
    dscr = "warn() snippet",
  }, "warn(\"${1:%s}\"$0);"),
  parse({
    trig = "warnx",
    name = "warnx",
    dscr = "warnx() snippet",
  }, "warnx(\"${1:%s}\"$0);"),
  parse({
    trig = "chkio_eof",
    name = "fputs() errcheck",
    dscr = "Error checking for int IO functions",
  }, "if (${1:status} == EOF$2) {\n\t${3:err(EXIT_FAILURE, \"IO is hard\");}\n}"),
  parse({
    trig = "chkio_null",
    name = "fgets() errcheck",
    dscr = "Error checking for pointer-type IO functions",
  }, "if (!${1:status}) {\n\t${2:err(EXIT_FAILURE, \"IO is very hard\");}\n}"),
  parse({
    trig = "chkio_mi",
    name = "fseek() errcheck",
    dscr = "Error checking for fseek(), getline() like functions",
  }, "if (${1:status} == -1$2) {\n\t${3:err(EXIT_FAILURE, \"IO is super hard\");}\n}"),
  parse({
    trig = "chkio_neg",
    name = "printf() errcheck",
    dscr = "Error checking for printf()-like functions",
  }, "if (${1:status} < 0$2) {\n\t${3:err(EXIT_FAILURE, \"Ran out of ink\");}\n}"),
  parse({
    trig = "chkmem",
    name = "malloc() errcheck",
    dscr = "Error checking for malloc()-like",
  }, "if (!${1:status}) {\n\t${2:err(EXIT_FAILURE, \"Your memory is doomed\");}\n}"),
  parse({
    trig = "printv",
    name = "Print a variable",
    dscr = "Call printf() to log value of a variable",
  }, "printf(\"$1 = %${2:d}\\n\", ${1:var}$3);"),
  parse({
    trig = "arrlen",
    name = "Array length",
    dscr = "Calculate number of elements in an array",
  }, "(sizeof ${1:arr} / sizeof $1[0])")
}
