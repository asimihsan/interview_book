# The Framework

Consistently using our structured problem solving approach will dramatically
improve the likelihood of succeeding in phone screens and face to face
interviews. Let's go through what the framework is, an example of using it, and
practical tips about using the framework to improve your interviewing game.

## What it isn't

Before diving into each point in detail, let me emphasize what this framework
explcitly forbids you from doing.

You must never jump directly into coding up the solution to a problem. Often
questions are deliberately left vague and unclear as an exercise for you to
clarify with both questions and examples. Jumping straight in is suggestive of a
person who, at worst, is lazy and likely to cause mountains of technical debt if
allowed to join the team.

## What it is - high level

1.  Confirm problem statement
2.  Come up wih a few examples
3.  Brainstorm algorithms
4.  Do algorithm once by hand and explain approach at a high level
5.  Code out solution
6.  Test solution with input
7.  Look for improvement opportunities in your code

## What it is - diving in


### 2. Come up with a few examples

TODO Start off with happy case, then unhappy case, then edge cases.

Here are some rules of thumb to keep in mind when generating examples and test
cases:

-   When a function requires a list or array of something, consider zero, one,
    and two element lists, and if relevant to your problem one test case with a
    very large list. Often the zero element and one element test cases will
    expose very common (and forgivable) off-by-one errors in array indexing
    logic, or mistakes in implementing a binary search. If relevant consider two
    cases to cover an even and an odd number of inputs.
-   When a function requires two or multiple lists of something, consider a
    partial Cartesian product of the previous statement. You don't need to
    enumerate all possible combinations, but intelligently pick at the important
    combinations. For example:
    -   What happens when both lists are empty?
    -   What happens when the first list is empty, and the second is one element?
    -   What happens when both lists are one element?
    -   What happens when one list is small, and the other is large?
-   All inputs vary over some range, and naturally the first examples we
    generate vary randomly over that range. What happens if the inputs vary over
    a smaller range, or indeed if all the inputs are identical? For example
    classic bugs in binary search algorithms can be exposed with an array of
    identical elements that cause the algorithm to wander to the left or right
    most edge of the array.

Here are the heuristics, compressed into a short checklist:

-   Zero, one, two
-   Odd? Even?
-   Small, big
-   Too small? Too big?
-   All negative, all positive, all zero, a mixture
-   Identical inputs
-   Null, nothing, invalid

### 3. Brainstorm algorithms

TODO the old standby, "does sorting help?"

TODO another old standby, "put each element into a hashtable, what value for a given key would allow magic to happen?"
