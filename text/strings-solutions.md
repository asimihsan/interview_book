# Strings Solutions

## 1. Balanced Parentheses

### Approach

-   Come up wih a few examples
-   Brainstorm algorithms
-   Do algorithm once by hand / explain approach at a high level
-   Code out solution
-   Test solution with input
-   Look for improvement opportunities in your code

### Java

~~~~ {.java .numberLines}
import java.util.*;
import java.io.*;

public class Solution {
    private static final Map<Character, Character> pairs = new HashMap<>();
    static {
        pairs.put('{', '}');
        pairs.put('(', ')');
        pairs.put('[', ']');
    }
    public static boolean are_delimiters_balanced(final String input) {
        final Deque<Character> stack = new ArrayDeque<>();
        for (int i = 0; i < input.length(); i++) {
            final Character c = input.charAt(i);
            if (pairs.containsKey(c)) {
                stack.push(c);
            } else if (stack.size() == 0 || !pairs.get(stack.pop()).equals(c)) {
                return false;
            }
        }
        return stack.size() == 0;
    }
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### JavaScript

~~~~ {.javascript .numberLines}
exports.are_delimiters_balanced = function(input) {
    var pairs = {
        '{': '}',
        '(': ')',
        '[': ']'
    };
    var stack = [];
    for (var i = 0, len = input.length; i < len; i++) {
        var c = input[i];
        if (c in pairs) {
            stack.push(c);
        } else if (stack.length === 0 || pairs[stack.pop()] !== c) {
            return false;
        }
    }
    return stack.length === 0;
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Python

~~~~ {.python .numberLines}
import collections

def are_delimiters_balanced(input):
    stack = collections.deque()
    pairs = {
        '(': ')',
        '{': '}',
        '[': ']',
    }
    for c in input:
        if c in pairs:
            stack.appendleft(c)
        elif len(stack) == 0 or c != pairs[stack.popleft()]:
            return False
    return len(stack) == 0
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
