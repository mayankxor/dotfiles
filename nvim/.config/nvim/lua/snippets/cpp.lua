local parse = require("luasnip.util.parser").parse_snippet

local function trim(value)
  return (value:gsub("^%s+", ""):gsub("%s+$", ""))
end

local ls = require("luasnip")
local t = ls.text_node
local i = ls.insert_node
local r = ls.restore_node
local sn = ls.snippet_node
local s = ls.snippet
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

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
      dscr = "Standard starter template for a tiny Cpp program",
    },
    "#include <iostream>\n\nint main(int argc, char *argv[])\n{\n\t$0\n\treturn 0;\n}"),
  s({
    trig = "docfunc",
    name = "Documented function",
    dscr = "Cpp function with documentation generated from its signature",
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
    return 0;
}}
]], {
      i(0),
    }), {}),
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
    }), {}
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
  }, "switch (${1:expression}) {\n\t$2\ndefault:\n\t$3;\n\tbreak;\n}\n$0"),
  parse({
    trig = "try",
    name = "try",
    desc = "Code snippet for try catch",
  }, [[try {
	$2
}
catch (${1:const std::exception&}) {
  $3
}
$0]]),
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
    trig = "forr",
    name = "reverse for loop",
    dscr = "Code snippet for reverse 'for' loop"
  }, "for (${1:size_t} ${2:i} = ${3:length}-1; $2 >= ${4:0}; $2--){\n\t$5\n}\n$0"),
  parse({
    trig = "foreach",
    name = "foreach",
    dscr = "Code snippet for range-based for loop (c++11) statement"
  }, "for (${1:auto} ${2:var} : ${3:collection}){\n\t$4\n}\n$0"),
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
  }, "union ${1:MyUnion} {\n\t$2\n};\n$0"),
  parse({
    trig = "cin",
    name = "cin",
    desc = "Code snippet for std::cin, provided the header is set",
  }, [[std::cin >> $1;]]),
  parse({
    trig = "cout",
    name = "cout",
    desc = "Code snippet for printing to std::cout, provided the header is set",
  }, [[std::cout << ${1:message};]]),
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
    trig = "enum class",
    name = "enum class",
    dscr = "Code snippet for enum class (c++11)",
  }, "enum class {$1:MyClass} {$2};$0"),
  parse({
    trig = "class",
    name = "class",
    desc = "Code snippet for class",
  }, [[class ${1:MyClass} {
public:
	$1();
	$1($1 &&) = default;
	$1(const $1 &) = default;
	$1 &operator=($1 &&) = default;
	$1 &operator=(const $1 &) = default;
	~$1();

private:
	$2
};

$1::$1() {
  $3
}

$1::~$1() {
  $4
}]]),
  parse({
    trig = "eclass",
    name = "eclass",
    desc = "Code snippet for empty class",
  }, [[class ${1:MyClass} {
public:
	$2
private:
	$3
};
]]),
  parse({
    trig = "qclass",
    name = "qclass",
    desc = "Code snippet for empty Qt class",
  }, [[class ${1:MyClass} : public QObject {
	Q_OBJECT;
public:

explicit $1(QObject *parent = nullptr);
	$2
signals:

public slots:
};
]]),
  parse({
    trig = "classi",
    name = "classi",
    desc = "Code snippet for class with inline constructor/destructor",
  }, [[class ${1:MyClass} {
public:
	$1() = default;
	$1($1 &&) = default;
	$1(const $1 &) = default;
	$1 &operator=($1 &&) = default;
	$1 &operator=(const $1 &) = default;
	~$1() = default;

private:
	$2
};]]),
  parse({
    trig = "interface",
    name = "interface",
    desc = "Code snippet for interface (Visual C++)",
  }, [[__interface I${1:Interface} {
	$0
};]]),
  parse({
    trig = "namespace",
    name = "namespace",
  }, [[namespace ${1:MyNamespace} {
	$2
}]]),
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
      trig = "#guard",
      name = "#guard",
      desc = "header guard. format :\n\tINCLUDE_<dirname>_<filename>_<extension>_",
    },
    [[#ifndef INCLUDE${TM_DIRECTORY/.*[\/\\](.*)/_${1:/upcase}/}${TM_FILENAME_BASE/(.*)/_${1:/upcase}/}${TM_FILENAME/.*\.(.*)/_${1:/upcase}/}_
#define INCLUDE${TM_DIRECTORY/.*[\/\\](.*)/_${1:/upcase}/}${TM_FILENAME_BASE/(.*)/_${1:/upcase}/}${TM_FILENAME/.*\.(.*)/_${1:/upcase}/}_

$1

#endif  // INCLUDE${TM_DIRECTORY/.*[\/\\](.*)/_${1:/upcase}/}${TM_FILENAME_BASE/(.*)/_${1:/upcase}/}${TM_FILENAME/.*\.(.*)/_${1:/upcase}/}_
$0]]),
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
  }, "(sizeof ${1:arr} / sizeof $1[0])"),
  parse({
    trig = "@param",
    name = "@param",
    dscr = "Type and description of a function parameter",
  }, "@param ${1:type of parameter} ${2:name of parameter} ${3:description}"),
  parse({
    trig = "@return",
    name = "@return",
    dscr = "Type and description of the return value",
  }, "@return ${1:type of parameter} ${2:description}"),
  parse({
    trig = "@note",
    name = "@note",
    dscr = "Anything worth mentioning that wouldn't fit in the description, or other documentation tags.'",
  }, "@note ${1:Text}"),
  parse({
    trig = "@warning",
    name = "@warning",
    dscr = "Indicates special considerations when using the function.",
  }, "@warning ${1:Text}"),
  parse({
    trig = "@deprecated",
    name = "@deprecated",
    dscr = "Marks the function as deprecated, and no longer recommended for use",
  }, "@deprecated ${1:Text}"),
  parse({
    trig = "@todo",
    name = "@todo",
    dscr = "Used to mark areas of the code that require improvements",
  }, "@todo ${1:Text}"),
  parse({
    trig = "@fixme",
    name = "@fixme",
    dscr = "Used to mark areas of the code that require fixing",
  }, "@fixme ${1:Text}"),
  parse({
    trig = "sca",
    name = "sca",
    desc = "static_cast<type>(expression)",
  }, [[static_cast<${1:unsigned}>(${2:expr})$3]]),
  parse({
    trig = "dca",
    name = "dca",
    desc = "dynamic_cast<type>(expression)",
  }, [[dynamic_cast<${1:unsigned}>(${2:expr})$3]]),
  parse({
    trig = "rca",
    name = "rca",
    desc = "reinterpret_cast<type>(expression)",
  }, [[reinterpret_cast<${1:unsigned}>(${2:expr})$3]]),
  parse({
    trig = "cca",
    name = "cca",
    desc = "const_cast<type>(expression)",
  }, [[const_cast<${1:unsigned}>(${2:expr})$3]]),
  parse({
    trig = "af",
    name = "af",
    desc = "auto function and trailing return",
  }, [[auto ${1:name}( ${2:void} ) -> ${3:auto} {
	${5}
}]]),
}
