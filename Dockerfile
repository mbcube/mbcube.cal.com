FROM node:20

WORKDIR /cal

ARG MAX_OLD_SPACE_SIZE=4096
ARG NEXTAUTH_SECRET=duKC9Dd5S1piUB966NlNm6xMMGlMUZGbN0N2PqonNbA=
ARG CALENDSO_ENCRYPTION_KEY=ZgzGf0BI4Jh76+7SMNCV28kwARf0Nm0i9uSQvGou3UE=
ARG DATABASE_URL=postgres://postgres.dxxuzjxkykpqejzwfqvm:lGtcHU0IcfyDkJgQ@aws-0-ca-central-1.pooler.supabase.com:6543/postgres?pgbouncer=true
ARG DATABASE_DIRECT_URL=postgres://postgres.dxxuzjxkykpqejzwfqvm:lGtcHU0IcfyDkJgQ@aws-0-ca-central-1.pooler.supabase.com:5432/postgres
ARG NEXTAUTH_URL=http://localhost:3000

ENV NODE_OPTIONS=--max-old-space-size=${MAX_OLD_SPACE_SIZE} \
    CI=true \
    NEXT_PUBLIC_CI=true \
    NEXTAUTH_SECRET=${NEXTAUTH_SECRET} \
    NEXTAUTH_URL=${NEXTAUTH_URL} \
    CALENDSO_ENCRYPTION_KEY=${CALENDSO_ENCRYPTION_KEY} \
    DATABASE_URL=${DATABASE_URL} \
    DATABASE_DIRECT_URL=${DATABASE_DIRECT_URL}

COPY . /cal

RUN yarn config set httpTimeout 1200000
RUN npx turbo prune --scope=@calcom/web --docker 
RUN yarn install 
RUN yarn build

EXPOSE 3000

CMD ["yarn" , "start"]

