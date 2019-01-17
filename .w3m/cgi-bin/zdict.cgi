#!/bin/sh
printf "W3m-control: SHELL zdict -c \"${QUERY_STRING}\" | less -Fr\n"
printf "W3m-control: BACK\n"

