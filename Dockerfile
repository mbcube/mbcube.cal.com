FROM node:20

WORKDIR /cal

ARG MAX_OLD_SPACE_SIZE=4096
ENV NODE_OPTIONS=--max-old-space-size=${MAX_OLD_SPACE_SIZE} \
    CI=true \
    NEXT_PUBLIC_CI=true

COPY . /cal

RUN yarn config set httpTimeout 1200000
RUN npx turbo prune --scope=@calcom/web --docker 
RUN yarn install 
RUN yarn build

CMD ["yarn" , "start"]

