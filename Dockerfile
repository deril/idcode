## Build the builder image
FROM daewok/sbcl:alpine AS build
RUN apk update && apk upgrade

# Set working directory
WORKDIR /opt/idcode
env HOME /opt/idcode

# Pull down the latest Quicklisp
ADD https://beta.quicklisp.org/quicklisp.lisp quicklisp/

# install quicklisp
COPY build/install-quicklisp.lisp build/
RUN sbcl --script build/install-quicklisp.lisp

# build the application
COPY build/build.lisp build/
COPY . quicklisp/local-projects/idcode
RUN sbcl --script ./build/build.lisp

## Build the runtime image
FROM alpine
WORKDIR /opt/idcode

# Copy over the representer code
COPY --from=build /opt/idcode/idcode bin/
COPY bin/run.sh bin/
RUN chmod +x bin/run.sh

# Set representer script as the ENTRYPOINT
ENTRYPOINT ["bin/run.sh"]
