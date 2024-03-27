FROM mcr.microsoft.com/azure-cli

COPY main.sh /main.sh

RUN chmod +x /main.sh

RUN apk add --no-cache curl

CMD [ "./main.sh" ]