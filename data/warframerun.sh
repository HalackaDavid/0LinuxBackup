echo "$(date)" > /tmp/HERE
echo "$@" >> /tmp/HERE
exec "$@"
