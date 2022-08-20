     ██░ ██  ▄▄▄        ██████  ██░ ██ ▓█████▄  ██▓  ██████  ▄████▄   ▒█████  
    ▓██░ ██▒▒████▄    ▒██    ▒ ▓██░ ██▒▒██▀ ██▌▓██▒▒██    ▒ ▒██▀ ▀█  ▒██▒  ██▒
    ▒██▀▀██░▒██  ▀█▄  ░ ▓██▄   ▒██▀▀██░░██   █▌▒██▒░ ▓██▄   ▒▓█    ▄ ▒██░  ██▒
    ░▓█ ░██ ░██▄▄▄▄██   ▒   ██▒░▓█ ░██ ░▓█▄   ▌░██░  ▒   ██▒▒▓▓▄ ▄██▒▒██   ██░
    ░▓█▒░██▓ ▓█   ▓██▒▒██████▒▒░▓█▒░██▓░▒████▓ ░██░▒██████▒▒▒ ▓███▀ ░░ ████▓▒░
     ▒ ░░▒░▒ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒ ▒▒▓  ▒ ░▓  ▒ ▒▓▒ ▒ ░░ ░▒ ▒  ░░ ▒░▒░▒░ 
     ▒ ░▒░ ░  ▒   ▒▒ ░░ ░▒  ░ ░ ▒ ░▒░ ░ ░ ▒  ▒  ▒ ░░ ░▒  ░ ░  ░  ▒     ░ ▒ ▒░ 
     ░  ░░ ░  ░   ▒   ░  ░  ░   ░  ░░ ░ ░ ░  ░  ▒ ░░  ░  ░  ░        ░ ░ ░ ▒  
     ░  ░  ░      ░  ░      ░   ░  ░  ░   ░     ░        ░  ░ ░          ░ ░  
                                        ░                   ░                 

# hashdisco
Simple hash discovery using regex.

## usage
    Usage: ./hashdisco.sh [OPTION]...
    
    Options:
      -h | -?   print this help
      -c        left/right context length (default: 25 characters)
      -d        enable debug output
      -p  	    path to start search in (default: /)
      -C        disable colors
      -R        disable recursive search

## roadmap

- [ ] search for poor web dev code (system calls, file inclusions, etc.)
- [ ] search for API keys
- [ ] search for certs/keys
- [ ] search for config files
- [ ] search for run at boot files/cronjobs/etc.
- [ ] create a powershell version
- [ ] change the name to align with more than just hash discovery!

## disclaimer
This script should be used for authorized penetration testing and/or educational purposes only. Any misuse of this software will not be the responsibility of the author or of any other collaborator. Use it at your own computers and/or with the computer owner's permission.
