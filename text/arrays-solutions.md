# Arrays Solutions

## 1. Pairs Sum to K

\label{solution.arrays.1}

Let's come up with a few examples to make sure that we understand the problem:

-   `[-1, 2, -3, 4], 6` would return `(2, 4)`
-   `[1, 0, 3], 1`, would return `(0, 1)`
-   `[1, 1], 1` would return `null`.
-   Edge cases
    -   `[], 1` would return null
    -   `[1], 1` would return null

Using examples clears up whether we need to return the indexes of the integers
or just the integers themselves.

Focusing on the first part of the problem, $O(n)$ time is often (but not
necessarily) code for "iterate over input as few times as possible". This
implies storing the input into some other data structure as we iterate in order
to use the data structure in a more time-efficient manner to find a solution.
This question is unusual in that we don't need to return the indexes of the
integers, just the integers themselves. Referring to the second example, surely
after seeing `1` all I need to note down is "Have a seen a 0? If yes, return
`(0, 1)`. If not, note that I've seen a `1` and continue. Hence we can:

-   iterate over the input array only once, building up a set data structure
    that allows $O(1)$ insertions and lookups (i.e. a hash table-backed set, not
    a tree- backed set).
-   As we iterate either find a second number that sums to k and return, else
    insert the element itself into the set.

Here's a Python solution for the first, $O(n)$ itme $O(n)$ space solution:

~~~~ {.python .numberLines}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Focusing on the second part of the problem, given the restrction of $O(1)$ space
(constant-type space, i.e. allocated memory that does not vary with the size of
the size of the input) this rules out the use of data structures. We know that
iterating over pairs of elements is $O(n^2)$, and this is worth mentioning. It's
unlikely an interviewer would settle for $O(n^2)$, but at the same time where
else is there to go? If you get stumped, the old standby is always "does sorting
help?", since sorts are $O(n \log n)$ time and might expose a useful angle.

However, what is the space complexity of sorting? Typical sorting methods cannot
avoid non-constant space complexity. Either sorting algorithms are recursive and
require space to be allocated on the call stack (in the best case $O(\log n)$
space for Quicksort) or they need an auxilliary array for some final step
($O(n)$ space for the merge step in Merge Sort). Truly adhering to the $O(1)$
space complexity in this problem requires either falling back to the naive
$O(n^2)$ time solution or implementing a genuinely $O(1)$ space sorting
algorithm like WikiSort [^1]. In this solution we do neither, and just assume
the language implementation's built-in sort uses $O(1)$ space. To avoid
duplication see the Sorting chapter for details. (TODO maybe refactor and move
this all to a Sorting chapter).

Referring to the second example, after sorting `[1, 0, 3]` becomes `[0, 1, 3]`.
If we start at 0, how do we find a number that helps it add to 1? We find 1. How
do you find things in a sorted list? Binary search. Binary searching $n$ times
gives an additional $O(n \log n)$, giving a neat $O(n \log n)$ time and $O(1)$
space solution.

Here's a Java solution for the first, $O(n \log n)$ time $O(1)$ space solution
solution. Note that although Java offers `java.util.Collections.binarySearch()`
(indeed Python also offers a `bisect` module), you'll need to code up binary
searches from scratch in interviews. However for simplicity we use the language
implementation's built-in sort routine; feel free to swap in your own
implementation (or a genuinely $O(1)$ space sorting algorithm!).

~~~~ {.java .numberLines}
import java.util.*;
import java.io.*;

public class Solution {
    public static Result pairSumsToK(final int[] array, final int k) {
        if (array.length < 2) {
            return null;
        }
        Arrays.sort(array);  // assuming we can use the language built-in sort
        for (int i = 0; i < array.length; i++) {
            final int element = array[i];
            final int required = k - element; // assuming no overflow
            final int findIndex = find(array, required);
            if (findIndex != -1 && findIndex != i) {
                if (element < required) {
                    return new Result(element, required);
                } else {
                    return new Result(required, element);
                }
            }
        }
        return null;
    }

    private static int find(final int[] array, final int element) {
        return find(array, element, 0, array.length - 1);
    }

    private static int find(final int[] array, final int element, final int lo,
            final int hi) {
        if (lo > hi) {
            return -1;
        }
        final int mid = (hi - lo) / 2 + lo;
        if (array[mid] == element) {
            return mid;
        } else if (array[mid] >= element) {
            return find(array, element, lo, mid - 1);
        } else {
            return find(array, element, mid + 1, hi);
        }
    }

    // Convenience class to make it easy to return a 2-tuple, and debug
    // the output of failed unit tests. You won't get asked to write all of
    // this in an interview, but we need this for the unit tests.
    public static class Result {
        public final int first;
        public final int second;

        public Result(final int first, final int second) {
            this.first = first;
            this.second = second;
        }

        @Override
        public String toString() {
            return String.format("(%s, %s)", first, second);
        }

        @Override
        public boolean equals(final Object o) {
            if (!(o instanceof Result)) {
                return false;
            }
            final Result r = (Result)o;
            return (first == r.first && second == r.second);
        }
    }
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### Examples of buggy solutions

Trace through these code samples and identify a) what the bug is, and b) test
cases that would identify the bug:

#### Buggy Solution 1

~~~~ {.python .numberLines}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def pair_sums_to_k(array, k):
    lookup = set(array)
    for element in array:
        required = k - element
        if required in lookup:
            return (min(required, element), max(required, element))
    return None
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


[^1]: [WikiSort](https://github.com/BonzaiThePenguin/WikiSort) (GitHub)
