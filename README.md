# scheduler

Create the `.env` file with the following variables:

```
TWITTER_API_KEY=1aSwQIFJjDdqtUS
TWITTER_API_SECRET=RvMqJ1mzMcHs
TWITTER_ACCESS_TOKEN=1597035658
TWITTER_ACCESS_TOKEN_SECRET=uc5
INSTAGRAM_ACCESS_TOKEN=EAAI8AZB
MEDIUM_PUBLICATION_ID=a0ff5915f
MEDIUM_ACCESS_TOKEN=2a605217986
GITHUB_ACCESS_TOKEN=ghp_xe1IzzY
GITHUB_USER=github-actions[bot]
```

Setup local crontab:

```
crontab -e

PATH=/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/bin:/bin:/usr/sbin:/sbin
45 */1 * * * cd /Users/[username]/scheduler/ && git pull && ./builder.sh > builder.log 2>&1
30 */1 * * * cd /Users/[username]/scheduler/ && ./publisher.sh > publisher.log 2>&1
0 0 * * * cd /Users/[username]/scheduler/ && ./midnigth.sh > midnigth.log 2>&1

crontab -l

# debug:
tail -f /var/mail/[username]
```

Also update `IMAGES_REPO="staticX"` in the "builder.sh" file when needed.

# AI

- https://ollama.com/
- https://ollama.com/download
- https://github.com/ollama/ollama

```
curl -OL https://ollama.com/download/Ollama-darwin.zip
```
