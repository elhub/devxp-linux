# 3. Drop use of kscript

Date: 2022-05-25

## Status

Accepted

## Context

Team Dev have been using kscript for scripting using the Kotlin language. Initially, this had some advantages due to
the somewhat immature state of the kotling scripting language. However, since 2020, Kotlin Script has improved a lot.
While kscript still has a few nice features in it, it is no longer crucial for a good scripting experience with Kotlin
and it does add some additional environment complications.

## Decision

Remove kscript from our standard tool set.

## Consequences

The consequence of doing this is that we woud have to switch the CI agents from using kscript to using kotlin script,
and correct any kscript code in the various repositories.
