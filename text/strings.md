# Strings

## Introduction

Strings are a fertile ground for interview questions. Similar to arrays, since they can be treated as a collection of characters, they can be the basis of questions involving permutations, counting, searching, and more. Moreover by asking candidates about the language-specific implementations of strings it's easy to determine if they are knowledgeable and curious about how their language's implementation works under the covers.

## What is a string?

A string is an **ordered collection of bytes**. Accompanied by an **encoding** these bytes can be translated into **characters**. For example, in Java:

~~~~ {.java .numberLines}
import java.nio.charset.Charset;

final byte[] data = new byte[]{104, 101, 108, 108, 111};
final String ascii = new String(data, Charset.forName("US-ASCII"));
final String utf8 = new String(data, Charset.forName("UTF-8"));
final String utf16 = new String(data, Charset.forName("UTF-16"));

System.out.println(ascii);  // "hello"
System.out.println(utf8);   // "hello"
System.out.println(utf16);  // "桥汬�"
System.out.println(utf16.length());  // 3
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Although encodings rarely come up in interviews it's important to know how strings are implemented in your language implementation of choice. Specifically, in most language implementations, strings are backed by a fixed array of bytes. This means accessing characters at random is typically O(1) time, and most interview problems about strings are often about an array of characters that you need to count, permute, iterate over, or copy somewhere.

Moreover, in most language implementations strings are immutable. This means that when concatenating many strings together you must avoid creating many intermediate strings, which would be $O(N^2)$ behavior. For example given the task to create a string of the first 100 natural numbers "1234...100", in JavaScript don't:

~~~~ {.javascript .numberLines}
function naturalNumbers() {
    var output = "";
    for (var i = 1; i <= 100; i++) {
        output = output + i;
    }
    return output;
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Instead prefer to join together an array of the substrings:

~~~~ {.javascript .numberLines}
function naturalNumbers() {
    var output = [];
    for (var i = 1; i <= 100; i++) {
        output.push(i);
    }
    return output.join("");
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Trade-offs in string implementations

Strings don't necessarily have to be immutable or be backed by a single contiguous byte array. This type of string implementation would be especially poor for a text editor, where we expect the text to be both long and frequently modified using insertions and deletions. Every modification would require an expensive $O(n)$ time modification and $O(n)$ space for a new byte array to be allocated for the entire string!

Although the topic rarely comes up in interviews some language implementations, for example Spidermonkey (the JavaScript engine in Mozilla Firefox) automatically switches to using **ropes** when strings reach a certain size [^1]. Ropes represent strings as a binary tree whose leaf nodes are small strings. This turns most modification operations to $O(\log n)$ time and avoids having to re-allocate the entire string on modification [^2].

Why are strings immutable in many language implementations? Immutable strings are:

-   faster to allocate and index into,
-   safe to share amongst threads without synchronization,
-   safely able to be used as-is as hash table keys and for their hash codes to be cached. (Why would mutable objects be a bad idea as hash table keys?)
-   easier to deduplicate and reduce memory usage for applications that have many duplicates of strings. [^3] [^4] [^5]

[^1]: [How Strings are Implemented in SpiderMonkey](https://blog.mozilla.org/ejpbruel/2012/02/06/how-strings-are-implemented-in-spidermonkey-2/) (mozilla.org)

[^2]: [Rope (data structure)](http://en.wikipedia.org/wiki/Rope_%28data_structure%29) (wikipedia.org)

[^3]:  [Why are Python strings immutable](https://docs.python.org/3.4/faq/design.html#why-are-python-strings-immutable) (python.org)

[^4]:  [Why is String immutable in Java?](http://programmers.stackexchange.com/questions/195099/why-is-string-immutable-in-java#answer-195152) (programmers.stackexchange.com)

[^5]: [JEP 192: String Deduplication in G1](http://openjdk.java.net/jeps/192) (openjdk.java.net)

## Problems

### 1. Balanced delimiters (Amazon)

Determine if an input string has balanced delimiters. A balanced delimiter starts with an opening character (`(`, `[`, `{`), ends with a matching closing character (`)`, `]`, `}` respectively), and has only other matching delimiters in between. For example:

-   `"()[]{}"` and `"([]{})"` are balanced, whereas
-   `"([)]"` and `"([]"` are not balanced.

### 2. Permutations of characters (popular) (Amazon, Facebook, Google, Yahoo)

Return all permutations of an input string as a sorted list. The return value must not have duplicates inside it; return each valid permutation only once. For example:

-   `"abc"` would return `['abc', 'acb', 'bac', 'bca', 'cab', 'cba']`.
-   `"cba"` would return `['abc', 'acb', 'bac', 'bca', 'cab', 'cba']`.
-   `"aaa"` would return `['aaa']`.

### 3. Longest substring that is a palindrome (Amazon, Bloomberg, Yahoo)

Return the longest substring that is also a palindrome from an input string. If no such palindrome exists return an empty string. If there is more than one longest palindrome of a given size return any one of them. For example:

-   `"abadd"` would return `"aba"`

### 4. Find US phone numbers (Amazon)

Given a string that includes line breaks return a list of all US phone numbers. Patterns of phone numbers you must support include:

-   `+18005551234`
    -   Optional international dialing symbol.
    -   Optional international dialing prefix.
-   `800-555-1234`
    -   Spaces are optional, or optionally may be hyphens.
-   `(800) 555 1234`
    -   Area code can optionally be surrounded by parentheses.
-   `5551234`
    -   International dialing prefix and area code are optional.

### 5. Convert a string to a number of arbitrary base (Amazon, Bloomberg, Groupon)

Given a string composed of digits and an integer base return an integer at that base as a string. The range of base will be `[2, 16]`. For example:

-   `"1234"`, `10` would return `"1234"`
-   `"1234"`, `16` would return `"4D2"`

### 6. Add least number of characters to make a palindrome (Google, Yahoo)

Given a string return a string that contains the characters that need to be added to the original string in order to make it a palindrome. For example:

-   `"abcdc"` would return `"abcdcba"`
-   `"aba"` would return `""`

### 7. Remove excess white spaces in a string (Amazon, Bloomberg, Groupon)

Given a string return another string where two or more consecutive spaces are transformed into a single space. For example:

-   `"a dog   did  bark  "` would return `"a dog did bark "`

### 8. Given characters and a dictionary find all words (Bloomberg, Facebook, Google)

Given a string of characters, where characters may be repeated, and access to a function `isWord(string)` that returns true if the input is a work, return a list of all words three letters or longer that can be formed with the characters. For example:

-   `"band"` would return `["band", "and", "ban", "nab"]`

### 9. Find first least appearing letter in a string (Apple, Amazon, Audible)

Given a string return an integer of the index of the first instance of the least appearing letter in a string. If there is more than one least appearing letter return the index to any of them. For example:

-   `"dbbcca"` would return either `0` (for `'d'`) or `5` (for `'a'`)
-   `"bbbaddda"` would return `3`.

### 10. Use run-length encoding to compress a string (popular) (Amazon, Bloomberg, Google, Groupon, Microsoft, Yahoo)

Given a string use run-length encoding to return a compressed string which represents consecutive instances of characters as a pair `(character, instances)`. For example:

-   `"abbccc"` would return `"a1b2c3"`

### 11. Given a string of words reverse letters in each word (Amazon, Bloomberg, Microsoft)

Given a string of lowercase letters and spaces return a string that reverse the letters in each word. For example:

-   `"a dog barked out loud"` would return `"a god dekrab tuo duol"`

### 12. Given a string of words reverse words but keep letter order (Bloomberg, Google)

Given a string of lower case letters and spaces return a string that reverse the words but retain the letter order in each word. For example:

-   `"a dog barked out loud"` would return `"loud out barked dog a"`

### 13. Find the first occurrence of a substring (popular) (Apple, Bloomberg, Facebook, Microsoft)

Given two strings, the first to search within (the haystack) and the second to search for (the needle), return the index within the haystack at which the needle first appears, or `-1` if the needle does not appear in the haystack. For example:

-   `("haystack with a needle", "needle")` would return `16`.
-   `("haystack with a needle", "blueberry")` would return `-1`.

### 14. Break down a string into all possible breakdowns of words (Google, Microsoft)

Given a string that contains lowercase letters and access to a function `isWord(string)` that return true if the input is a word, return a list of strings that contains all possible word breakdowns of the input string. For example:

-   `"applepie"` returns `["apple pie"]`
