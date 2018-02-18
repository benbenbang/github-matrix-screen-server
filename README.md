## Matrix Screen Saver for Mac

The GitHub [Matrix](http://en.wikipedia.org/wiki/The_Matrix) shows a constant stream of recent commits from GitHub. Click on the drops to open the corresponding revision on GitHub. Use the pause/play button at the lower right corner to pause and resume the matrix animation (or press SPACE).

## Credit & A Known Issue 

The original project is made by [@winterbe](https://github.com/winterbe). Since the server is down, I decided to encapsulate it into docker to keep this nice project could be easily served on client side. But due to I'm not a Java guy, there's a error about `CORS` should be solved if you want to serve it on the cloud.

## Before Start

Before you start, you will need to prepare:

- A Github account to create your own API Token
  - Go to settings → Developer settings → Personal Assess Tokens → Generate new token
  - In the *Edit personal access token* section, you don't need to select any scope; for this application, **public access** will be enough.
- If you want to host it locally, you will need to install `docker`. Please go to their [official site](https://www.docker.com/docker-mac) to download and install it.
- Otherwise, you will need a AWS account which offer 1 year free-tier and also need to fix the `CORS` issue.

## Run in Localhost

1. After install docker, please download `Dockerfile` from [here](https://d.pr/f/zcFGxn)

2. Run the following code:

   ```bash
   # First test your docker have properly installed
   # You might see some output with "hello world" from docker :)
   $ sudo docker run hello-world
   $ export API_KEY="PASTE YOUR GITHUB API KEY HERE"
   $ sudo docker build --build-arg GITHUB_API_KEY=${API_KEY} -t matrix -f matrix.Dockerfile ./
   $ sudo docker run -d -p 8080:8080 --name matrix matrix
   ```

3. Download the screen saver file [here](https://d.pr/f/5RQH2l), and then open your terminal (or iTerm…you name it) on your Mac, and run `tar -xzf WebViewScreenSaver.tar.gz`

4. Double click on `WebViewScreenSaver.saver` file to install it

5. Go to `System Prefenerences > Desktop & Screen Saver `, click on `WebViewScreenSaver > Screen Saver Options…`. 

   - Check that the default value is `localhost:8080` 
   - Check the `fetch` option and paste `http://localhost:8080` into it.

6. Enjoy your Matrix screen saver!

## Contribute

Feel free to [fork](https://github.com/benbenbang/github-matrix-screen-server/fork) this project and send me pull requests. You can also send me feedback by [opening an issue](https://github.com/benbenbang/github-matrix-screen-server/issues).

## License

The source code is published under the MIT license. If you reuse parts of the code for your own projects please preserve information about me as original author visible in your application.

## Appendix

``` dockerfile
FROM maven:3.5.2-slim
LABEL version="1.0"
LABEL maintainer="bn<at>m11n.io"
EXPOSE 8080
ARG GITHUB_API_KEY

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV API_KEY=$GITHUB_API_KEY

RUN apt update
RUN apt install -y git

WORKDIR /home
RUN git clone https://github.com/benbenbang/github-matrix-screen-server
VOLUME /home/github-matrix-screen-server
WORKDIR /home/github-matrix-screen-server

CMD ["/bin/bash", "matrix.sh"]
```

