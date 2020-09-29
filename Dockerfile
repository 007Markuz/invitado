FROM node:10.13-alpine as node
ENV NODE_ENV production
WORKDIR /app
COPY . /app/.
#COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]

#RUN npm install -g @angular/cli
#RUN npm install --save angular/material2-builds angular/cdk-builds angular/animations-builds
#RUN npm i @angular-devkit/build-webpack
#RUN npm install 
#COPY . .

#install packages
# you can change the version of angular CLI to the one you are using in your application
RUN npm install -g  @angular/cli@latest
RUN npm install -g --save @angular-devkit/build-angular
RUN npm install

# if you have libraries in your workspace that the angular app relies on, build them here

#RUN ng build library-name --prod

# build your application
#RUN ng build 

# STAGE 2
# Deploy APP

# In this stage, we are going to take the build artefacts from stage one and build a deployment docker image
# We are using nginx:alpine as the base image of our deployment image

FROM nginx:alpine

COPY --from=node /app/dist/invitado /usr/share/nginx/html
COPY --from=node /app/nginx.conf /etc/nginx/conf.d/default.conf


EXPOSE 80
#CMD npm start
