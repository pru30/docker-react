FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

RUN npm run build

# run phase

FROM nginx
#expose port 80 in production environment, elastic bean stalk looks for EXPOSE
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html