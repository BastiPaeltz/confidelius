# confidelius

## Motivation

1. Dealing with confidential data on your local machine can be done wrong very easily and many dont think about security but rather about pragmatism ... what if there could be a way to have both?
2. It's even harder to deal with stuff that might get checked into soure control

## What are the problems

- you enter confidential data without silent/unix style mode
- you leave confidential data in clear text in some files, sometimes you need them to be there
- you put them in ENV variables where people could read them browsing through your shell history if you're not cautious or 
- often times we work with confidential data in our projects (passwords, access keys etc.) and they might get checked into source control

## Idea

--> session-based, keeps track of your passwords/dummy passwords
    --> save feature, so once you start a saved session later on, state of where you were is restored  
--> once session is left, dummy passwords are put in place again  
--> change environment just for the session  
--> silent read of passwords ALWAYS  
--> password-lock files  
--> option to git pre-commit hook, so you can be sure you checked nothing  wrong into source control, because it keeps track of your  

## CLI

- new
- start/stop -s "php" -p PROMPT
- list
- env
- file -times 4 or -lines 35,23 pattern="^foobar$" -i
- save
- hook --soft
- import/export

### new
- prompts you for a master password
  - is used to encrypt the database
- creates the database (sqlite)

#### database schema
session: 
- name(text)
- (some config values)

operations:
- id
- session_id
- date(timestamp)

env:
- operation_id
- before
- after

file:
- operation_id
- location(string)
- used_pattern(string)
- before
- after

### start/stop
- starts/stops a session
- creates a session if not already defined
- use -s to name the session
- updates PS1
- decrypts(start) or encrypts(stop) database
  - use --convenient flag to 'start', to indicate that same password should be used
- stop rolls back all the changes

### list
- lists all saved sessions

### save 
- saves the session to the database

### file PATTERN
- enter (silent read) state_after text to replace PATTERN with
- restrict times or lines with arguments

### env VAR_NAME
- enter (silent read) state_after text for env variable
- state gets saved to database

### hook 
- --hard indicates that hook failes if it cant read database
- automatically create git hooks for all files

### import/export
- ...
