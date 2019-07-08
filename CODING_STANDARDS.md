# Coding Standards

## Editor Setup

- Source code encoding: UTF-8.
- 2 spaces indentations (no tabs).
- Maximum line length: 80 characters.
- No trailing whitespace.
- Unix-style line endings.
- Files end with a newline.

## Ruby Style Guide

We follow the [Ruby Community Style Guide](https://rubystyle.guide), but you
don't need to read the whole thing, it is just here as a reference. If you are
not sure how to format a particular piece of code, you can give it a quick
search. But for the most part, just try to be consistent with the existing code.

### About naming

Naming is a non-trivial problem, and good names greatly contribute to code
readability. So make sure you choose expressive names.

Note: We use American English for names, with ASCII characters.

## Git Commits

### Commit messages

Good commit messages are intention revealing and provide context to facilitate
code review. So try to write
[good commit messages](https://chris.beams.io/posts/git-commit/):

- Separate the subject from the body with a blank line.
- Limit the subject line to 50 characters.
- Capitalize the subject line.
- Do not end the subject line with a period.
- Use the imperative mood in the subject line.
- Wrap the body at 72 characters.
- Use the body to explain what and why (not how).

Example of a good commit message:

```
Fix rare data corruption issue

The encoding conversion was not provided a source encoding. It was thus
implicitly relying on automatic encoding detection. This works most of
the time, but fails in some rare cases, leading to data corruption.

Since it is known, we now provide the source encoding to the encoding
conversion logic, hence fixing the issue.
```

### Commit history

A good commit history also helps with the review, showing relationships between
commits. So clean up your commit history before submitting. In particular:

- Do not leave "WIP" commits behind.
- Squash "Add missing file" or "Fix typo" commits with the commit they fix.

Example of a good commit history:

```
| * Add ETL job using the new GoogleSheetsExtractor
| * Add GoogleSheetsExtractor
| * Add google-api-client gem
| * Refactor to allow the use of different extractors
|/
*
```
