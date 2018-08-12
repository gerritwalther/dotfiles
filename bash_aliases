
# Lists all running tomcat instances
alias tomcats='ps aux | grep tomcat'

# Encode an URL (requires Python)
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'

# Navigate up to 5 directories upwards
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
