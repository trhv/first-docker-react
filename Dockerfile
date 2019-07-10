# this docker file we of 2 steps:
# 1. Build Phase - 
#   Use node:alpine - > Copy the package.json file -> install dependencies -> Run npm run build
# 2. Run Phase -
#   Use nginx -> Copy over the result of 'npm run build' -> start nginx


# 1. Build Phase
# The name of this build stage. 
# Set the base image to use for any subsequent 
# instructions that follow and also give this 
# build stage a name.
FROM node:alpine AS builder

WORKDIR '/app'

COPY package.json .

RUN npm install

COPY . .

RUN npm run build



# 2. Run Phase
FROM nginx

# i want to copy over somthing that other phase that we just were working on
COPY --from=builder /app/build /usr/share/nginx/html