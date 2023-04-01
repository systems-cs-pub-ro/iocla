# cs

## Usage
```
$ cs/cs.sh
Usage: cs/cs.sh file
       cs/cs.sh directory
$ cs/cs.sh -h
Usage: cs/cs.sh file
       cs/cs.sh directory

$ cs/cs.sh cs/tests/10-FUNCTION_TOO_LONG.c
cs/tests/10-FUNCTION_TOO_LONG.c:83: WARNING:LONG_FUNCTION: 'func_not_ok' function definition is 81 lines, perhaps refactor

```
## Tests
```
cs/cs.sh cs/tests/
cs/tests/05-TABS.c:3: WARNING:LEADING_SPACE: please, no spaces at the start of a line
cs/tests/05-TABS.c:8: ERROR:CODE_INDENT: code indent should use tabs where possible
cs/tests/05-TABS.c:8: WARNING:LEADING_SPACE: please, no spaces at the start of a line
cs/tests/09-LINE_TOO_LONG.c:3: CHECK:LONG_LINE_STRING: line length of 91 exceeds 80 columns
cs/tests/03-FUNCTION_WITHOUT_ARGS.c:1: ERROR:FUNCTION_WITHOUT_ARGS: Bad function definition - int main() should probably be int main(void)
cs/tests/04-BLANK_LINES.c:5: CHECK:LINE_SPACING: Please use a blank line after function/struct/union/enum declarations
cs/tests/04-BLANK_LINES.c:9: CHECK:LINE_SPACING: Please use a blank line after function/struct/union/enum declarations
cs/tests/04-BLANK_LINES.c:11: CHECK:BRACES: Blank lines aren't necessary after an open brace '{'
cs/tests/04-BLANK_LINES.c:12: CHECK:LINE_SPACING: Please don't use multiple blank lines
cs/tests/04-BLANK_LINES.c:15: CHECK:LINE_SPACING: Please don't use multiple blank lines
cs/tests/08-EXTRA_WHITESPACE.c:3: WARNING:SPACING: space prohibited before semicolon
cs/tests/08-EXTRA_WHITESPACE.c:4: WARNING:SPACING: space prohibited between function name and open parenthesis '('
cs/tests/08-EXTRA_WHITESPACE.c:4: ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
cs/tests/08-EXTRA_WHITESPACE.c:4: ERROR:SPACING: space prohibited before that close parenthesis ')'
cs/tests/08-EXTRA_WHITESPACE.c:8: ERROR:SPACING: space required one side of that '++' (ctx:WxW)
cs/tests/08-EXTRA_WHITESPACE.c:9: WARNING:SPACING: space prohibited before semicolon
cs/tests/08-EXTRA_WHITESPACE.c:10: WARNING:SPACING: space prohibited between function name and open parenthesis '('
cs/tests/08-EXTRA_WHITESPACE.c:10: ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
cs/tests/08-EXTRA_WHITESPACE.c:10: ERROR:SPACING: space prohibited after that open parenthesis '('
cs/tests/08-EXTRA_WHITESPACE.c:10: ERROR:SPACING: space prohibited before that close parenthesis ')'
cs/tests/08-EXTRA_WHITESPACE.c:11: WARNING:SPACING: space prohibited between function name and open parenthesis '('
cs/tests/08-EXTRA_WHITESPACE.c:11: ERROR:SPACING: space prohibited after that open parenthesis '('
cs/tests/08-EXTRA_WHITESPACE.c:11: ERROR:SPACING: space prohibited before that close parenthesis ')'
cs/tests/08-EXTRA_WHITESPACE.c:19: ERROR:SPACING: space prohibited after that open parenthesis '('
cs/tests/08-EXTRA_WHITESPACE.c:19: ERROR:SPACING: space prohibited before that close parenthesis ')'
cs/tests/08-EXTRA_WHITESPACE.c:20: WARNING:SPACING: space prohibited between function name and open parenthesis '('
cs/tests/08-EXTRA_WHITESPACE.c:20: WARNING:SPACING: space prohibited before semicolon
cs/tests/08-EXTRA_WHITESPACE.c:20: ERROR:SPACING: space prohibited before that close parenthesis ')'
cs/tests/08-EXTRA_WHITESPACE.c:21: WARNING:SPACING: space prohibited between function name and open parenthesis '('
cs/tests/08-EXTRA_WHITESPACE.c:21: WARNING:SPACING: space prohibited before semicolon
cs/tests/08-EXTRA_WHITESPACE.c:21: ERROR:SPACING: space prohibited before that close parenthesis ')'
cs/tests/08-EXTRA_WHITESPACE.c:25: WARNING:SPACING: space prohibited before semicolon
cs/tests/08-EXTRA_WHITESPACE.c:25: ERROR:SPACING: space prohibited after that open parenthesis '('
cs/tests/08-EXTRA_WHITESPACE.c:26: WARNING:SPACING: space prohibited before semicolon
cs/tests/08-EXTRA_WHITESPACE.c:26: ERROR:SPACING: space prohibited after that open parenthesis '('
cs/tests/08-EXTRA_WHITESPACE.c:27: ERROR:SPACING: space prohibited before that close parenthesis ')'
cs/tests/08-EXTRA_WHITESPACE.c:29: WARNING:SPACING: space prohibited before semicolon
cs/tests/10-FUNCTION_TOO_LONG.c:83: WARNING:LONG_FUNCTION: 'func_not_ok' function definition is 81 lines, perhaps refactor
cs/tests/06-TRAILING_WHITESPACE.c:3: ERROR:TRAILING_WHITESPACE: trailing whitespace
cs/tests/06-TRAILING_WHITESPACE.c:7: ERROR:TRAILING_WHITESPACE: trailing whitespace
cs/tests/06-TRAILING_WHITESPACE.c:8: ERROR:TRAILING_WHITESPACE: trailing whitespace
cs/tests/06-TRAILING_WHITESPACE.c:9: ERROR:TRAILING_WHITESPACE: trailing whitespace
cs/tests/06-TRAILING_WHITESPACE.c:12: ERROR:TRAILING_WHITESPACE: trailing whitespace
cs/tests/01-BRACES.c:5: ERROR:OPEN_BRACE: open brace '{' following function definitions go on the next line
cs/tests/01-BRACES.c:7: ERROR:OPEN_BRACE: that open brace { should be on the previous line
cs/tests/01-BRACES.c:12: WARNING:BRACES: braces {} are not necessary for single statement blocks
cs/tests/07-MISSING_WHITESPACE.c:4: ERROR:SPACING: space required after that ',' (ctx:VxO)
cs/tests/07-MISSING_WHITESPACE.c:4: ERROR:SPACING: space required before that '&' (ctx:OxV)
cs/tests/07-MISSING_WHITESPACE.c:6: ERROR:SPACING: spaces required around that '=' (ctx:VxV)
cs/tests/07-MISSING_WHITESPACE.c:7: ERROR:SPACING: spaces required around that '=' (ctx:WxV)
cs/tests/07-MISSING_WHITESPACE.c:8: ERROR:SPACING: spaces required around that '=' (ctx:VxV)
cs/tests/07-MISSING_WHITESPACE.c:8: ERROR:SPACING: space required after that ';' (ctx:VxV)
cs/tests/07-MISSING_WHITESPACE.c:8: ERROR:SPACING: spaces required around that '<' (ctx:VxV)
cs/tests/07-MISSING_WHITESPACE.c:8: ERROR:SPACING: space required after that ';' (ctx:VxO)
cs/tests/07-MISSING_WHITESPACE.c:8: ERROR:SPACING: space required before the open brace '{'
cs/tests/07-MISSING_WHITESPACE.c:8: ERROR:SPACING: space required before the open parenthesis '('
cs/tests/07-MISSING_WHITESPACE.c:12: ERROR:SPACING: spaces required around that '+=' (ctx:VxV)
cs/tests/07-MISSING_WHITESPACE.c:13: ERROR:SPACING: spaces required around that '=' (ctx:VxV)
cs/tests/07-MISSING_WHITESPACE.c:13: CHECK:SPACING: spaces preferred around that '*' (ctx:VxV)
cs/tests/07-MISSING_WHITESPACE.c:16: ERROR:SPACING: spaces required around that '>' (ctx:VxV)
cs/tests/07-MISSING_WHITESPACE.c:16: ERROR:SPACING: spaces required around that '&&' (ctx:VxV)
cs/tests/07-MISSING_WHITESPACE.c:16: ERROR:SPACING: spaces required around that '>' (ctx:VxV)
cs/tests/07-MISSING_WHITESPACE.c:17: ERROR:SPACING: spaces required around that '=' (ctx:VxV)
cs/tests/07-MISSING_WHITESPACE.c:19: ERROR:SPACING: space required before the open brace '{'
cs/tests/07-MISSING_WHITESPACE.c:19: ERROR:SPACING: space required before the open parenthesis '('
cs/tests/07-MISSING_WHITESPACE.c:24: ERROR:SPACING: space required before the open brace '{'
cs/tests/07-MISSING_WHITESPACE.c:27: ERROR:SPACING: space required after that close brace '}'
cs/tests/07-MISSING_WHITESPACE.c:27: ERROR:SPACING: space required before the open parenthesis '('
cs/tests/02-SUSPECT_CODE_INDENT.c:4: WARNING:SUSPECT_CODE_INDENT: suspect code indent for conditional statements (4, 4)
```
