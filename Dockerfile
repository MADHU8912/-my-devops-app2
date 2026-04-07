FROM alpine:latest
WORKDIR /app
COPY app.txt .
CMD ["sh", "-c", "echo Container started && cat /app/app.txt && sleep 3600"]