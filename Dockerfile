# base image
FROM node:8.9.4

# Install dependencies
RUN npm install -g webpack
RUN sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ cosmic main'
RUN apt-get update && apt-get install -y fakeroot
RUN sudo apt install --install-recommends winehq-stable
RUN apt-get install libpng-dev

# copy the application files
COPY . /usr/src/app

######## NPM ########
# Take care of the packages in the root of the repository.
WORKDIR /root-npm
COPY package.json /root-npm/
RUN npm install --quiet

# Take care of the packages in the submodule /contents directory.
WORKDIR /contents-npm
COPY contents/package.json /contents-npm/
RUN npm install --quiet

######## WORKING DIRECTORY ########
# set working directory
WORKDIR /usr/src/app

# copy the previously cached node modules
RUN cp -a /root-npm/node_modules /usr/src/app/ \
  && cp -a /contents-npm/node_modules /usr/src/app/contents/

# build
# enter the submodule contents directory to do the build
WORKDIR /usr/src/app/contents
RUN npm run build
WORKDIR /usr/src/app
RUN npm run dist-lin
RUN npm run dist-win
RUN npm run dist-mac

VOLUME ["/releases", "/releases"]
# start app
CMD ["npm", "start"]
