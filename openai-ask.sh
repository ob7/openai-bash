#!/usr/bin/env bash
MODEL=gpt-3.5-turbo
KEY=`cat KEY.txt`
TEMP=0.7
MAX=3096
INPUT="$@"
COUNT=`echo $INPUT | wc -w`
MAX_TOKENS=$(($MAX - 14))
#echo $MAX_TOKENS
#echo $COUNT
#INPUT=`echo "$@" | sed 's/ /\\ /g'`
#echo $INPUT
PROMPT=${INPUT// /\\ }
#echo $PROMPT
#echo "$@"
#curl -X GET "https://api.openai.com/v1/answers?model=$MODEL&prompt="$1"&temperature=$TEMP&max_tokens=$MAX&n=1" -H "Content-Type: application/json" -H "Authorization: Bearer $KEY"
#curl -X GET "https://api.openai.com/v1/chat/completions?model=$MODEL&prompt="$1"&temperature=$TEMP&max_tokens=$MAX&n=1" -H "Content-Type: application/json" -H "Authorization: Bearer $KEY"
ANSWER=$(curl -s https://api.openai.com/v1/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $KEY" \
  -d '{
  "model": "'$MODEL'",
  "max_tokens": '$MAX_TOKENS',
  "messages": [{"role": "user", "content": "'"$INPUT"'"}],
  "temperature": '$TEMP'
}')
#echo `$ANSWER | jq '.[0]'`
#echo `$ANSWER | grep -Po '"content": *\K"[^"]*"'`
FINAL=`echo "$ANSWER" | grep -Po '"content": *\K"[^"]*"'`
echo "$FINAL"
#REQUEST=
  #-d "{
  #\"model\": \"$MODEL\",
  #\"messages\": [
  #  {
  #    \"role\": \"user\",
  #    \"content\": \"$1\"
  #  }
  #],
  #\"temperature\": $TEMP 
