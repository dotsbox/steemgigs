FROM node:7-alpine

ARG SOURCE_COMMIT
ENV SOURCE_COMMIT ${SOURCE_COMMIT}
ARG DOCKER_TAG
ENV DOCKER_TAG ${DOCKER_TAG}



WORKDIR /var/app
RUN mkdir -p /var/app
ADD package.json /var/app/
RUN npm install

COPY . /var/app

# FIXME TODO: fix eslint warnings

# run unit tests
RUN npm run unit

# run e2e tests
RUN npm run e2e

# run all tests
RUN npm test

RUN npm run build

RUN npm run build --report

ENV PORT 8080

EXPOSE 8080

CMD [ "npm", "start" ]
