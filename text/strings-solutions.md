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

## 2. Permutations of Characters

### Approach

Compare examples of permutations from less to more complex:

-   `""` is `[""]`.
-   `"a"` is `["a"]`.
-   `"ab"` is `["ab", "ba"]`.
-   `"abc"` is `["abc", "acb", "bac", "bca", "cab", "cba"]`.

Is there any connection between the different solutions? Can we re-use answers from less complex answers to make answering more complex questions easier?

It seems like for each letter in a string we can:

-   remove it
-   figure out the permutations of the rest of the string
-   prepend the removed character to each permutation

This is a recursive solution. What are the base cases? The permutations of an empty string or a single character is just a one element list of itself. Does this actually work? Convince yourself it does by working over the examples.

How about the time and space complexities of this answer? We're doing something for each permutation, and we know from high school math that the number of permutations in a sequence is proportional to $n!$. Moreover by making a recursive call for each character of the string we're implicitly using a function call stack proportional in size to the length of the string. Hence the time complexity if $O(n \times n!)$ and the space complexity is $O(n)$.

### Java

~~~~ {.java .numberLines}
import java.util.*;
import java.io.*;

public class Solution {
    public static List<String> permutations(final String input) {
        final List<String> result = new ArrayList<String>();
        if (input.length() <= 1) {
            result.add(input);
            return result;
        }
        for (int i = 0; i < input.length(); i++) {
            final StringBuilder rest = new StringBuilder();
            for (int j = 0; j < input.length(); j++) {
                if (j != i) {
                    rest.append(input.charAt(j));
                }
            }
            final Character c = input.charAt(i);
            for (final String perm : permutations(rest.toString())) {
                result.add(c + perm);
            }
        }
        final List<String> uniqueResult = new ArrayList<String>(
            new HashSet<String>(result));
        Collections.sort(uniqueResult);
        return uniqueResult;
    }
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### JavaScript

~~~~ {.javascript .numberLines}
function uniqueSortedArray(array) {
    var resultUnique = array.reduce(function(p, c) {
        if (p.indexOf(c) < 0) {
            p.push(c);
        }
        return p;
    },  []);
    resultUnique.sort(); 
    return resultUnique;
};

exports.permutations = function(input) {
    var result = [];
    if (input.length <= 1) {
        result.push(input);
        return result;
    }
    for (var i = 0; i < input.length; i++) {
        var xs = [];
        for (var j = 0; j < input.length; j++) {
            if (j !== i) {
                xs.push(input.charAt(j));
            }
        }
        var rest = xs.join('');
        var c = input.charAt(i);
        exports.permutations(rest).forEach(function(perm) {
            result.push(c + perm);
        });
    }
    return uniqueSortedArray(result);
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
