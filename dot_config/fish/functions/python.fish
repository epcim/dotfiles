
function p -d "Start the best Python shell that is available"
    set -l cmd

    if test -f manage.py
        if pip freeze ^/dev/null | grep -iq 'django-extensions'
            set cmd (which python) manage.py shell_plus
        else
            if pip freeze ^/dev/null | grep -iq 'flask-script'
                # do nothing, use manage.py, fall through
                set -e cmd
            else
                set cmd (which python) manage.py shell
            end
        end
    end

    if test -z $cmd
        set -l interpreters (which bpython ^/dev/null; which ipython ^/dev/null; which python ^/dev/null)

        if test -z "$interpreters"
            set_color red
            echo "No python interpreters found on the PATH."
            set_color normal
            return 127
        end

        # Try to find the first interpreter within the current virtualenv
        # Rationale: it's more important to start a Python interpreter in the
        # current virtualenv than it is to start an _IPython_ interpreter (for
        # example, when the current virtualenv has no ipython installed, but such
        # would be installed system-wide).
        for interp in $interpreters
            #echo '-' $interp
            #echo '-' (dirname (dirname $interp))
            if test (dirname (dirname $interp)) = "$VIRTUAL_ENV"
                set cmd $interp
                break
            end
        end

        # If they all fall outside the virtualenv, pick the first match
        # (preferring ipython over python)
        if test -z "$cmd"
            set cmd $interpreters[1]
        end
    end

    # Run the command
    printf "Using "; set_color green; echo $cmd; set_color normal
    eval $cmd $argv
end

alias pm 'python manage.py'
alias pms 'python manage.py shell_plus'

function pipr -d "Find & install all requirements for this project"
    pushd (git root)
    begin
        if test -f requirements.txt
            command pip install -r requirements.txt
        end
        if test -f dev-requirements.txt
            command pip install -r dev-requirements.txt
        end
        if test -f .pipignore
            command pip install -r .pipignore
        end
    end
    popd
end
