# Doesn't work to suppress newline
echo -nonewline test #doesn't work

write -NoNewline "test" #doesn't work

write-host -NoNewline "test" #works
write-host -NoNewline "test2" #works
