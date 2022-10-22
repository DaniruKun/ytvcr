# YTVCR

## Status

What is the status, such as proposed, accepted, rejected, deprecated, superseded, etc.?
Accepted

## Context

What is the issue that we're seeing that is motivating this decision or change?
Implement a web service that has schedulable jobs, a database for storing users and information about recordings.

## Decision

What is the change that we're proposing and/or doing?

Implement the following stack:

- Elixir + Phoenix LiveView
- Oban (community) for jbo scheduling
- `ytarchive` as the archive tool

## Consequences

What becomes easier or more difficult to do because of this change?