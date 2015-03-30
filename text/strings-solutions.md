# Strings Solutions

## 1. Balanced Delimiters

### Approach

We know that `"([)]"` isn't balanced, whereas `"([])"` is balanced. This is because the order in which delimiters are closed matters, just like for example HTML tags. Hence using an integer counter for each delimiter, incrementing when you see an open and decrementing when you see a close, can't work. Instead we have to know what open delimiters we've seen, and that we're closing them in the correct (reverse) order. Already we know that if we need to keep track of what open delimiters we've seen the best case space complexity is O(n), and we need a data structure to help us.

If you imagine you have just seen the first two characters of the above example, if we see a closing delimiter what must it be? It must be the most recently opened delimiter. What kind of data structure can help you progress through a sequence and give you access to the most recent element? A stack. Specifically:

-   When you see an open delimiter, push it onto the stack.
-   When you see a close delimiter, pop the stack (returning the most recent open delimiter) and check the actual close delimiter is what is expected.

This gives a worst-case time complexity of O(n) and a worst-case space complexity of O(n).

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

### 2. Permutations of Characters

### Approach

### Java

### JavaScript

### Python

~~~~ {.python .numberLines}
def permutations(input):
    if len(input) <= 1:
        return [input]
    result = []
    for i, c in enumerate(input):
        rest = input[:i] + input[i+1:]
        result.extend([c + perm for perm in permutations(rest)])
    return sorted(list(set(result)))
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
