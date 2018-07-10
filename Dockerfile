FROM       node:alpine 

MAINTAINER https://github.com/mpezzolano/blockchain-v1

EXPOSE     3000

WORKDIR    /blockchain-v1 

COPY       package.json /blockchain-v1

RUN        npm install

COPY       . /blockchain-v1 

CMD        ["bin/www"]
